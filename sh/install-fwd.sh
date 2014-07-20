#!/bin/bash
MAX=25
if [ $# -eq 0 ]
then
BINARY_ARCHIVE=$HOME/forwarders/splunkforwarder-6.0.2-196940-Linux-x86_64.tgz
D_SERVER=qa-systest-03.sv.splunk.com:1901
BASE=$HOME/forwarders
for i in $(eval echo "{1..$MAX}")
do
INST=$BASE/fwd-client${i}
MGMT_PORT=`expr 3411 + $i`
mkdir -p $INST && cd $INST
tar xzf $BINARY_ARCHIVE
echo "[deployment-client]

[target-broker:deploymentServer]
# Specify the deployment server that the client will poll.
targetUri= $D_SERVER " > $INST/splunkforwarder/etc/system/local/deploymentclient.conf
echo "[settings]
mgmtHostPort = 127.0.0.1:$MGMT_PORT " > $INST/splunkforwarder/etc/system/local/web.conf
echo "[general]
serverName = mrt-dc${i}.splunk.com" > $INST/splunkforwarder/etc/system/local/server.conf
$INST/splunkforwarder/bin/splunk start --accept-license
done
fi
if [ $# -eq 2 ]
then
BASE=$HOME/forwarders
for i in $(eval echo "{1..$MAX}")
do
INST=$BASE/fwd-client${i}
$INST/splunkforwarder/bin/splunk stop
/bin/rm -rf $INST
done
fi

