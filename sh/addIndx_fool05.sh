#!/bin/bash
for log in spritzer_f0_2012-05-18 spritzer_f0_2012-05-19 spritzer_f0_2012-05-20 spritzer_f0_2012-05-21 spritzer_f0_2012-05-22 spritzer_f0_2012-05-23 spritzer_f0_2012-05-24
do 
$SPLUNK_HOME/bin/splunk add monitor $LOG_BASE/${log}.log.gz -index $log  -auth admin:changeme
done

