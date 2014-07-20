#!/bin/sh
FILE=$HOME/scripts/uids.txt
##
## IPv6
## curl -6 -k  -X POST -d"username=admin" -d"password=secret12" https://\\[2620:70:8000:c301:129a:ddff:fe69:102b\\]:8089/services/auth/login
#FILE=$HOME/scripts/opends.users.txt
FILE2="/tmp/sessions"
MAX=$1
n=0
cat $FILE|while read line
do
 echo "Getting a session for $line"
#curl -s -k -X POST -d "username=$line&password=password" https://localhost:8089/services/auth/login
curl -s -k -X POST -d "username=$line&password=$line" https://localhost:8089/services/auth/login
 n=$(($n+1))
if [ $n -gt $MAX ]
then
break
fi
done 
curl -s -u admin:changeme -k -X GET https://localhost:8089/services/authentication/httpauth-tokens\?count=0 -o $FILE2
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
 curl -s -u admin:changeme -k -X GET https://localhost:8089/services/authentication/httpauth-tokens/$line
 echo "curl -s -u admin:changeme -k -X GET https://localhost:8089/services/authentication/httpauth-tokens/$line"
 curl -s  -u admin:changeme -k -X DELETE  https://localhost:8089/services/authentication/httpauth-tokens/$line
done 
echo "===============> Here is the Session Counts ============"
echo "===============> Session Counts From auth: $mnt ============"
echo "===============> Session Counts From list: $cnt ============"
#/bin/rm -f $FILE2
