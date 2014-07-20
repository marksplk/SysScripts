#!/bin/sh
URL=$HOME/scripts/data/rest_urls_remote.txt
 while true
 do
 cat $URL |while read line
 do 
#$line
$line -o /dev/null
if [ $? -ne 0 ]
then
 echo "####Command: $line Failed #####"
fi
 done
#echo "You want to loop: "
# read resp
# if [ $resp != "y" ]
# then
# exit 1
# fi
 done
