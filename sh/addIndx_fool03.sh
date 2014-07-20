#!/bin/bash
for log in  spritzer_f0_2012-05-11 spritzer_f0_2012-05-12 spritzer_f0_2012-05-13 spritzer_f0_2012-05-14 spritzer_f0_2012-05-15 spritzer_f0_2012-05-16 spritzer_f0_2012-05-17
do 
$SPLUNK_HOME/bin/splunk add monitor $LOG_BASE/${log}.log.gz -index $log  -auth admin:changeme
done

