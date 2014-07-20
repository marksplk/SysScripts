#!/bin/bash
FILE=$SPLUNK_HOME/memory_splunkd_`hostname`.log
while true
do
date >> $FILE
ps -e -orss=,args= |  sort -nr | head |grep start >> $FILE
sleep 300
done
