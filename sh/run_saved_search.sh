#!/bin/bash
count=1
#cat $HOME/scripts/uids.txt|while read line
for usr in `seq 1 1000`
do
curl -k -u "user.$usr:password" https://fool08.sv.splunk.com:1901/services/search/jobs  -d search=savedsearch aaaMysavedSearch$count" -d search="index%3D_internal user.$usr"
count=`expr $count + 1`
done

