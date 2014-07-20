#!/bin/sh
FILE=$HOME/scripts/roles.txt
ACTION=$1

cat $FILE|while read line
do
#curl -k -u admin:changeme -X POST -d  "$line=$line" https://localhost:8089/services/properties/authentication/roleMap_localhost
#splunk_role=LDAP Group
curl -u admin:changeme  -k -X POST -d "roles=admin" https://localhost:8089/services/admin/LDAP-groups/locaOpenDS%2C$line
done 
