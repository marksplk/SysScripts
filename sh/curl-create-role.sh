#!/bin/sh
i=0
n=3
cat ~/scripts/input2.txt| while read line
do
tmp=`echo $line|cut -d: -f1`
name1="splunk_role_$tmp"
 curl -k  -u admin:changeme -d"name=$name1&capabilities=$tmp" https://localhost:8089/services/authentication/roles
#curl -k -u admin:changeme -X POST -d  "$name1=$tmp" https://localhost:8089/services/properties/authentication/roleMap_localhost
curl -u admin:changeme  -k -X POST -d "roles=$name1" https://localhost:8089/services/admin/LDAP-groups/ADD_ldap_from_cli0%2C$tmp

echo "done with $name1"
done
