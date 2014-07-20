#!/bin/sh
#count=3000
#cat $HOME/scripts/uids.txt|while read line
for i in `seq 25 501 `
do
curl -k -u user.${i}:password -X DELETE https://qa-systest-20.sv.splunk.com:1901/servicesNS/user.${i}/search/saved/searches/user.${i}.aaaMysavedSearch 
count=`expr $count + 1`
done

