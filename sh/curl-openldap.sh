#!/bin/sh
name1="ADD_ldap_from_cli$n"
 curl -k  -u admin:changeme -d"name=$name1&groupBaseDN=dc%3Dnodomain&groupMemberAttribute=member&groupNameAttribute=cn&host=10.160.23.1&realNameAttribute=cn&userNameAttribute=uid&userBaseDN=dc%3Dnodomain" https://localhost:8089/services/authentication/providers/LDAP
