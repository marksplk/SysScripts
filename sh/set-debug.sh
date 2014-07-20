#!/bin/sh
FILE=$HOME/scripts/debug-classes.txt
level=DEBUG
#level=DEBUG
cat $FILE|while read line
do
curl -k -u admin:changeme -X POST -d "level=$level" https://localhost:8089/services/server/logger/$line
 echo "Set Class $line to $level"
done 
