#!/bin/bash
for i in {1..100}
do
dName="My Group Name$i"
echo "
dn: CN=my qa group$i,OU=groups,OU=ADMon Automation,DC=qa,DC=ad2008r2,DC=com
objectClass: group
objectClass: top
objectCategory: CN=Group,CN=Schema,CN=Configuration,DC=qa,DC=ad2008r2,DC=com
cn: my qa group$i
description: this is my my group no$i
distinguishedName: CN=my qa group$i,OU=groups,OU=ADMon Automation,DC=qa,DC=ad2008r2,DC=com
member: CN=Indira thangasamy,CN=Users,DC=qa,DC=ad2008r2,DC=com
name: my qa group$i"
done
#name:Name Of ${dName}"
