#!/bin/bash
Del_Monitor()
{
FILES==`ls /Users/ithangasamy/scripts/ldif/testldif/l`
for f in $FILES
	do
	f1="%252FUsers%252Fithangasamy%252Fscripts%252Fldif%252Ftestldif%252Fl%252F$f"
	curl -k -u admin:changeme -X DELETE https://localhost:8089/services/data/inputs/monitor/$f1
	echo "Deleted the monitor $f1"
	done
}
Add_Monitor()
{
FILES==`ls /Users/ithangasamy/scripts/ldif/testldif/l`
for f in $FILES
	do
	f1="/Users/ithangasamy/scripts/ldif/testldif/l/$f"
	curl -k -u admin:changeme https://localhost:8089/services/data/inputs/monitor -d name=$f1
	echo "added the file $f"
	done
}
#main
if [ "$1" = "add" ]
then
 Add_Monitor
fi
if [ "$1" = "del" ]
then
 Del_Monitor
fi
#lsit the monitors
curl -s -k -u admin:changeme https://localhost:8089/servicesNS/nobody/search/admin/monitor |grep totalResults|cut -d: -f2|cut -d\> -f2|cut -d\< -f1

