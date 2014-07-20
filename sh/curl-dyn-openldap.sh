#!/bin/sh
name1="OpenLDAP_DynGroup"
 curl -k  -u admin:changeme -d"name=$name1&bindDNpassword=secret12&bindDN=cn%3DManager,dc%3Dopenldap,dc%3Dsplunk,dc%3Dcom&groupBaseDN=dc%3Dopenldap,dc%3Dsplunk,dc%3Dcom&groupMemberAttribute=member&groupNameAttribute=cn&host=10.160.23.1&realNameAttribute=cn&userNameAttribute=cn&userBaseDN=dc%3Dopenldap,dc%3Dsplunk,dc%3Dcom" https://localhost:8089/services/authentication/providers/LDAP
