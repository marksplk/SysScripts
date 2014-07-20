#!/bin/bash
FILE=/tmp/session.$$
curl -s -uadmin:changeme  -k https://localhost:8089/services/authentication/httpauth-tokens\?count=0 |grep userName |cut -d\" -f2- |cut -d\> -f2|cut -d\< -f1 > $FILE
#curl -s -uadmin:changeme  -k https://localhost:8089/services/authentication/httpauth-tokens\?count=0 |grep authString |cut -d\" -f2- |cut -d\> -f2|cut -d\< -f1 > $FILE
cnt=`wc -l $FILE|awk '{print $1}'`
echo "There are $cnt sessions"
/bin/rm -f $FILE
