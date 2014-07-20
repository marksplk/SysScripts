#!/bin/sh
i=0
n=3
while [ $i -lt $n ]
do
n=`expr $n - 1`
name1="ADD_ldap_from_cli$n"
 curl -k  -u admin:changeme -d"name=$name1&groupBaseDN=O%3DSplunk%20Inc.%2CL%3DSan%20Francisco%2Cc%3DUS&groupMemberAttribute=member&bindDNpassword=secret12&bindDN=cn%3DDirectory Manager&port=1389&groupNameAttribute=cn&host=localhost&realNameAttribute=cn&userNameAttribute=uid&userBaseDN=O%3DSplunk%20Inc.%2CL%3DSan%20Francisco%2Cc%3DUS" https://localhost:8089/services/authentication/providers/LDAP
 #curl -k  -u amadmin:secret12 -d"name=$name1&groupBaseDN=dc%3Dosx%2Cdc%3Dsplunk%2Cdc%3Dcom&groupMemberAttribute=uid&groupNameAttribute=cn&host=osx.splunk.com&realNameAttribute=cn&userNameAttribute=uid&userBaseDN=dc%3Dosx%2Cdc%3Dsplunk%2Cdc%3Dcom" https://localhost:8089/services/authentication/providers/LDAP
echo "done with $name1"
done
