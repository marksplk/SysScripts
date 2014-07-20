#!/bin/bash
for log in  spritzer_f0_2012-05-25 spritzer_f0_2012-05-26 spritzer_f0_2012-05-27 spritzer_f0_2012-05-28 spritzer_f0_2012-05-29 spritzer_f0_2012-05-30 spritzer_f0_2012-05-31 spritzer_f0_2012-09-01
do 
$SPLUNK_HOME/bin/splunk add monitor $LOG_BASE/${log}.log.gz -index $log  -auth admin:changeme
done

