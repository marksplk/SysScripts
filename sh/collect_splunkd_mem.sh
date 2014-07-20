#!/bin/bash
#set -x
FILE=$SPLUNK_HOME/resource_usage_`hostname`.log
while true
do
TMP_FILE=/tmp/.nex
splk_pid=`$SPLUNK_HOME/bin/splunk status |grep "splunkd is running"|cut -d: -f2|cut -d\) -f1`
splk_PID=`echo $splk_pid|sed 's/ //g'` 
cat /proc/$splk_PID/status > $TMP_FILE
Mem=`grep "^VmRSS" $TMP_FILE`
ram=`echo $Mem|cut -d' ' -f2`
VMem=`grep "^VmSize" $TMP_FILE`
Vram=`echo $VMem|cut -d' ' -f2`
Thrds=`grep "^Threads" $TMP_FILE|cut -d: -f2|sed 's/ //g'`
FDs=`grep "^FDSize" $TMP_FILE|cut -d: -f2|sed 's/ //g'`
mem_usage=` expr $ram / 1024`
vmem_usage=` expr $Vram / 1024`
echo "[`date`] Threads=$Thrds,FDs=$FDs,RSS=$mem_usage,VIRTUL=$vmem_usage" >> $FILE
sleep 300
done
