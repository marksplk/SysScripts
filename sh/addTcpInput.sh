#!/bin/bash
set -x
COUNT=9090
for a in {9091..9191}
do
#./splunk add tcp 8081 -remotehost slapd${a} -auth admin:changeme
PORT= $COUNT + $a
./splunk add tcp $a  -auth admin:changeme
echo "nc 10.160.23.1 $PORT" >> /tmp/nc-cat.txt
done  
