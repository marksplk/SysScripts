#!/bin/bash

cat "../../amazone_server_config" | while read line; do
	host=`echo $line|cut -d " " -f2`
	status_code=`curl -sL -w "%{http_code}\\n" "http://$host:1900/sso/en-US/" -o /dev/null`
	echo "$host service is [$status_code]"
done