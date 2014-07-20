#!/bin/sh
cat ~/scripts/input2.txt| while read line
do
tmp=`echo $line|cut -d: -f1`
name1="splunk_role_$tmp"
 curl -k  -u admin:changeme -X DELETE https://localhost:8089/services/authentication/roles/$name1
done
