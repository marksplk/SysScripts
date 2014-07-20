#!/bin/sh
# Active Directory
# CREATE
curl -k  -X POST -u admin:secret12  -d "name=ActiveDirectory1"  --data-urlencode "bindDN=cn=directory manager,cn=users,dc=qa,dc=ad2008r2,dc=com"  -d "bindDNpassword=We1c0me1"  --data-urlencode "groupBaseDN=cn=users,dc=qa,dc=ad2008r2,dc=com"  -d "groupMappingAttribute=dn" -d "groupMemberAttribute=member" -d "groupNameAttribute=cn" -d "host=slapd.splunk.com"  -d "port=389" -d "realNameAttribute=cn"  --data-urlencode  "userBaseDN=cn=users,dc=qa,dc=ad2008r2,dc=com" -d "userNameAttribute=cn"  "https://localhost:9089/services/authentication/providers/LDAP"
#LIST 
curl -k  -u admin:secret12  "https://localhost:9089/services/authentication/providers/LDAP"
curl -k  -u admin:secret12  "https://localhost:9089/services/authentication/providers/LDAP/ActiveDirectory1"
#UPDATE
#curl -k  -u admin:secret12  -d"groupMemberAttribute=uniquemember"  "https://localhost:9089/services/authentication/providers/LDAP/ActiveDirectory1"

#DELTETE 
#curl -v  -k -X DELETE   -u admin:secret12  "https://localhost:9089/services/authentication/providers/LDAP/ActiveDirectory1"

