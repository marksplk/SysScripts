#!/bin/sh
SPLUNK_LOG=$HOME/splunkbeta/var/log/splunk
while true
do
ls $SPLUNK_LOG/crash-* 2>&1 /dev/null
if [ $? -eq 0 ]
then
echo "Got A Crash"
fi
 sleep 30
 done

