#!/bin/bash
for log in  spritzer_f0_2012-09-02 spritzer_f0_2012-09-03 spritzer_f0_2012-09-04 spritzer_f0_2012-09-05 spritzer_f0_2012-09-06 spritzer_f0_2012-09-07 spritzer_f0_2012-09-08 spritzer_f0_2012-09-09
do 
$SPLUNK_HOME/bin/splunk add monitor $LOG_BASE/${log}.log.gz -index $log  -auth admin:changeme
done

