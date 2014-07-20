#!/bin/bash
set -x
url=$2
hname=$1
sfix=$3
base="~/systest/clustering"
fname=`echo $url  | cut -d\/ -f4`
if [ $sfix = "" ]
then
   prefix1=`echo $url  | cut -d\/ -f7 | cut -d- -f1`
else
   prefix1=$sfix
fi
prefix=`echo $url  | cut -d \/ -f4 | cut -d - -f1`
ssl=true
RUN_FILE=/tmp/run.$$.sh
WEB_PORT=1900
ADMIN_PORT=1901
if [ $# -lt 2 ]
then
    echo "usage: $0 remoteHostName buildUrl"
    exit 1
fi

echo "
if [ ! -e $base ];then
	mkdir -p $base
fi
cd $base
$base/$prefix1/bin/splunk -f stop
pkill splunk
pkill python
mv $prefix ss.org
/bin/rm -rf ss.org &
curl -O $url
tar xfz $fname
cat <<EOF > $base/$prefix/etc/splunk-launch.conf
SPLUNK_FIPS=1
EOF
cat <<EOF > $base/$prefix/etc/system/local/server.conf
[general]
serverName = $hname

[sslConfig]
enableSplunkdSSL = $ssl
EOF
cat <<EOF >$base/$prefix/etc/system/local/web.conf
[settings]
httpport = $WEB_PORT
mgmtHostPort = 127.0.0.1:$ADMIN_PORT
root_endpoint=/sso
EOF
$base/$prefix/bin/splunk start --accept-license --answer-yes
" > $RUN_FILE
chmod +x $RUN_FILE
scp -i /Users/cesc/Work/Documents/AWSkeys/mark_splk.pem $RUN_FILE ubuntu@$hname:$RUN_FILE
ssh -i /Users/cesc/Work/Documents/AWSkeys/mark_splk.pem ubuntu@$hname $RUN_FILE
#/bin/rm -f $RUN_FILE
