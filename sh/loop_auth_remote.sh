#!/bin/bash
FILE=$HOME/scripts/dns_uid.txt
FILE2="/tmp/sessions"
MAX=$1
n=0
cat $FILE|while read line
do
 echo "Getting a session for $line"
 curl -s -k -X POST -d "username=$line&password=password" http://10.1.5.35:8087/services/auth/login
 n=$(($n+1))
if [ $n -gt $MAX ]
then
break
fi
done 
curl -s -u admin:changeme -k -X GET http://10.1.5.35:8087/services/authentication/httpauth-tokens\?count=0 -o $FILE2
grep "\<title" $FILE2 > /tmp/sss
mv /tmp/sss $FILE2
perl -i -pe 's#</title>##g' $FILE2
perl -i -pe 's#<title>##g' $FILE2
perl -i -pe 's# ##g' $FILE2
sed -i -e "/^httpauth-tokens$/d" $FILE2
mnt=`wc -l $FILE2`
cat $FILE2|while read line
do
 echo "Getting a session for $line"
 curl -s -u admin:changeme -k -X GET http://10.1.5.35:8087/services/authentication/httpauth-tokens/$line
 echo "curl -s -u admin:changeme -k -X GET https://localhost:8089/services/authentication/httpauth-tokens/$line"
 curl -s  -u admin:changeme -k -X DELETE  http://10.1.5.35:8087/services/authentication/httpauth-tokens/$line
done 
echo "===============> Here is the Session Counts ============"
echo "===============> Session Counts From auth: $mnt ============"
echo "===============> Session Counts From list: $cnt ============"
#/bin/rm -f $FILE2
