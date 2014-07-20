#!/bin/sh
FILE=$HOME/scripts/uids.txt
ACTION=$1

user_add()
{
line1=$1
curl -k  -u admin:secret12 -X POST -d "name=$line&password=$line&roles=admin" https://qa-sol10sparc.splunk.com:8089/services/authentication/users
#curl -k  -u admin:secret12 -X POST -d "name=$line&password=$line&roles=splunk_role_edit_tcp" https://qa-sol10sparc.splunk.com:8089/services/authentication/users
 echo "Creating User $line"
return 0
}
user_del()
{
line1=$1
curl -k  -u admin:secret12 -X DELETE https://qa-sol10sparc.splunk.com:8089/services/authentication/users/$line1
 echo "Deleting User $line"
return 0
}
user_auth()
{
line1=$1
curl -k -X POST -d "username=$line1&password=$line1" https://qa-sol10sparc.splunk.com:8089/services/auth/login
 echo "Authenticating User $line"
return 0
}

cat $FILE|while read line
do
if [ $ACTION = "add" ]
then
 user_add $line
elif [ $ACTION = "del" ]
then
 user_del $line
else
 user_add $line
 user_auth $line
 user_del $line
fi
done 
