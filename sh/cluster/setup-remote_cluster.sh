#!/bin/bash
## Created by Indira thangasamy
##      Re-engineering of this code permitted only if you agree to put the 
##      above block of comments in your new code 

#set -x
MAX=5
BINARY="$1"
MODE=$2
HOST_N=$3
SSL=$4
LOG_FILE=/tmp/setup-cluster-log.$$
if [ $SSL -eq "ssl" ]
then
   proto=https
   ssl=true
else
   proto=http
   ssl=false
fi
base=$HOME/clustering
init=18080
for i in $(eval echo "{1..$MAX}")
do
$base/p${i}/splunk/bin/splunk stop 2>&1 >$LOG_FILE
/bin/rm -rf $base/p${i}/ 2>&1 >>$LOG_FILE
done
for i in $(eval echo "{1..$MAX}")
do
WEB_PORT=`expr $init + 10`
ADMIN_PORT=`expr $init + 11`
init=$ADMIN_PORT
mkdir $base/p${i} && cd $base/p${i} 2>&1 >>$LOG_FILE
gunzip < $BINARY | tar xf -  2>&1 >>$LOG_FILE
echo "[general]
serverName = $HOSTNAME-${i}

[sslConfig]
enableSplunkdSSL = $ssl
">$base/p${i}/splunk/etc/system/local/server.conf
echo "[settings]
httpport = $WEB_PORT
mgmtHostPort = 127.0.0.1:$ADMIN_PORT
">$base/p${i}/splunk/etc/system/local/web.conf
$base/p${i}/splunk/bin/splunk start --accept-license --answer-yes 2>&1 >>$LOG_FILE
done
i=1
$base/p${i}/splunk/bin/splunk edit cluster-config -mode master -secret secret12 -auth admin:changeme 2>&1 >>$LOG_FILE
$base/p${i}/splunk/bin/splunk restart 2>&1 >>$LOG_FILE
master_port=`$base/p${i}/splunk/bin/splunk show splunkd-port -auth admin:changeme | cut -d: -f2| sed 's/ //g'`

for i in $(eval echo "{2..$MAX}")
do
rep_port=`expr $init + 43`
init=$rep_port
$base/p${i}/splunk/bin/splunk edit cluster-config -mode slave  -secret secret12  -master_uri ${proto}://ronnie.splunk.com:$master_port -replication_port $rep_port -auth admin:changeme 2>&1 >>$LOG_FILE
$base/p${i}/splunk/bin/splunk restart
done
