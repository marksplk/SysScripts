#!/bin/bash
#for i in  `seq 1 25`
for i in  `seq -w 10 25`
#for i in  `seq -w 01 09`
do
myhost=qa-systest-${i}.sv.splunk.com
if [ $i -lt 10 ]
then
 myhost=qa-systest-0${i}.sv.splunk.com
fi
#ssh -t eserv@qa-systest-${i}.sv.splunk.com  "find /export/home/clustering/splunk/  -name \"yellow\" -print "
#ssh -t eserv@qa-systest-${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk version "
#ssh -t eserv@qa-systest-0${i}.sv.splunk.com  "grep \"RUOneProcess\"  /export/home/clustering/splunk/var/log/splunk/splunkd.log* "
ssh -t eserv@$myhost "find /export/home/clustering/splunk/var/log/splunk -name \"crash-2014-05*\" -print" 
# | xargs grep \"BucketSummary\"  "
#ssh -t eserv@qa-systest-0${i}.sv.splunk.com  "/mnt/engineering_qa/unix/collect_single.sh "
done
