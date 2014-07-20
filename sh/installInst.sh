#!/bin/bash
for i in  `seq -w 19 25`
#for i in  `seq -w 10 18`
do
 ./setup-instance.sh qa-systest-${i}.sv.splunk.com http://releases/dl/current_builds/6.1-20140318-0000/splunk-6.1-201357-Linux-x86_64.tgz splunk 6.1
done
