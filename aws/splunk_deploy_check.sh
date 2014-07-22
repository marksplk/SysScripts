#!/bin/bash

cat "./aws_instance_list" | while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	status_code=`curl -sL -w "%{http_code}\\n" "http://$host:1900/sso/en-US/" -o /dev/null`
	echo "[[$nodeType]] -> $host service is [$status_code]"
done
