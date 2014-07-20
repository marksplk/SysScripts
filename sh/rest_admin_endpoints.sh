#!/bin/sh
URL=$HOME/scripts/data/admin-rest-uris.txt
user=admin
pass=changeme
while true
do
 cat $URL |while read line
 do 
#$line
#curl -k -s -u $user:$pass -X GET "$line" 
#curl -k -s -u $user:$pass -X POST "$line" 
curl -k -H 'Authorization: Basic T3BlbkRTX0FsaWNlOk9wZW5EU19BbGljZQ==' -X GET "$line" 
curl -k -H 'Authorization: Basic T3BlbkRTX0FsaWNlOk9wZW5EU19BbGljZQ==' -X POST "$line" 
 done
done
