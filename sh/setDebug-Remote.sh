#!/bin/sh
FILE=$HOME/scripts/debug-classes.txt
level=DEBUG
cat $FILE|while read line
do
curl -k -u admin:secret12 -X POST -d "level=$level" https://slapd.splunk.com:8089/services/server/logger/$line
 echo "Set Class $line to $level"
done 
