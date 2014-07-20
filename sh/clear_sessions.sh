#!/bin/bash
FILE=/tmp/session.$$
curl -s -uadmin:changeme  -k https://localhost:8089/services/authentication/httpauth-tokens |grep authString |cut -d\" -f2- |cut -d\> -f2|cut -d\< -f1 > $FILE
cnt=`wc -l $FILE|awk '{print $1}'`
cat $FILE | while read line
do
curl -s -uadmin:changeme  -k -X DELETE https://localhost:8089/services/authentication/httpauth-tokens/$line
done
echo "Deleted $cnt sessions"
/bin/rm -f $FILE
