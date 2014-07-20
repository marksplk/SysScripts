#!/bin/bash
BASE=$HOME/replication
TMP_DIR=/tmp/indira
BUILD_URL="$1"
if [ $# < 2 ]
then
   PREFIX=splunk
else
   PREFIX="$2"
fi


get_build()
{
 if [ ! -d $TMP_DIR ]
 then 
  mkdir $TMP_DIR 
 fi
 curl -s -k -o $TMP_DIR/splunk.tgz -G "$BUILD_URL"
 if [ ! -e $TMP_DIR/splunk.tgz ]
 then
    return 1
 fi
 return 0
}

Setup_Splunk()
{
 inst_root="$1"
 web_port="$2"
 splunk_port="$3"
 if [ ! -d $inst_root ]
 then 
  mkdir $inst_root 
 fi
 cd $inst_root
 tar xvfz $TMP_DIR/splunk.tgz
 if [ ! -f  $inst_root/$PREFIX/bin/splunk ]
 then
	  echo "tar : Failed"
	  return 1
 fi
# setup the ports in loca/web.conf
 echo "#Added by a script called $0
[settings]
httpport = $web_port
mgmtHostPort = 127.0.0.1:${splunk_port}
" >  $inst_root/$PREFIX/etc/system/local/web.conf
 $inst_root/$PREFIX/bin/splunk start  --answer-yes --no-prompt --accept-license
  return 0
}

#start/stop
Start_Splunk()
{
 base="$1"
 $base/$PREFIX/bin/splunk start --answer-yes --no-prompt --accept-license
 return 0
}
#need to perform the status check later
Stop_Splunk()
{
 base="$1"
 $base/$PREFIX/bin/splunk stop --answer-yes --no-prompt --accept-license
 return 0
}
#restart
Restart_Splunk()
{
 Stop_Splunk $1
 Start_Splunk $1
}

#Setting up master
Enable_Cluster_Master()
{
 instance_base="$1"
 $instance_base/$PREFIX/bin/splunk edit cluster-config -mode master ${user}:${pass}
 Restart_Splunk $instance_base
 return 0
}
#Setting up peer
Enable_Cluster_Peer()
{
 instance_base="$1"
 peer_port="$2"
 master_uri="$3"
 $instance_base/$PREFIX/bin/splunk enable listen $peer_port -auth ${user}:${pass}
 $instance_base/$PREFIX/bin/splunk edit cluster-config -mode slave -master_uri $master_uri -auth ${user}:${pass} 
 Restart_Splunk $instance_base
 return 0
}
#cleanup
Cleanup_Cluster()
{
  cd $BASE && /bin/rm -rf peer1 master peer2 peer3 
  return 0
}
#main

get_build
#setup master
Setup_Splunk $BASE/master 58080 59090
Restart_Splunk  $BASE/master
Enable_Cluster_Master $BASE/master
#setup peer1
Setup_Splunk $BASE/peer1 58181 59191
Enable_Cluster_Peer $BASE/peer1 48181 http://ronnie.splunk.com:59090
#setup peer2
Setup_Splunk $BASE/peer2 58282 59292
Enable_Cluster_Peer $BASE/peer2 48282 http://ronnie.splunk.com:59090
#setup peer3
Setup_Splunk $BASE/peer3 58383 59393
Enable_Cluster_Peer $BASE/peer3 48383 http://ronnie.splunk.com:59090
#/bin/rm -rf $TMP_DIR 
