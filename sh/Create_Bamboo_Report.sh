#!/bin/bash
## Created by Indira thangasamy
##      Re-engineering of this code permitted only if you agree to put the 
##      above block of comments in your new code 

set -x
LOG_HOME=/var/bamboo
FILE=/tmp/text_file.txt
DAY=`date|awk '{print $2,$3}'`
FILE_LIST=`find $LOG_HOME -mtime -1 -type f -name "*.log"  -print |xargs ls -l|grep "$DAY" |grep  430-|awk '{print $9}'`
for f in $FILE_LIST
do
 BAMBOO_PLAN=`echo $f|cut -d\/ -f6 `
 grep "Total Executed:" $f 2>&1
 if [ $? -eq 0 ]
 then
  Total_Tests=`grep  "Total Executed:  " $f|cut -d: -f4`
  Passed_Tests=`grep  "Passed:  " $f|cut -d: -f4`
  Failed_Tests=`grep  "Failed:  " $f|cut -d: -f4`
  Error_Tests=`grep   "Error:  " $f|cut -d: -f4`
  Skipped_Tests=`grep "Skipped:  " $f|cut -d: -f4`
  echo "PLAN: $BAMBOO_PLAN |$Total_Tests|$Passed_Tests|$Failed_Tests|$Error_Tests|$Skipped_Tests" >>$FILE
  else
  echo "some issue with the plan $BAMBOO_PLAN" >>$FILE
  fi
#echo "BAMBOO_PLAN= $BAMBOO_PLAN"
#exit 1
done
