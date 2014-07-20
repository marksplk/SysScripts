#!/bin/bash
i=1
cat $HOME/scripts/data/openldap.txt|while read line
#while true
do
/Users/ithangasamy/splunk/bin/python $HOME/scripts/connectToSplunkWeb.py $line $line 
i=$(($i+1))
echo "Session No: $i : $line"
done
