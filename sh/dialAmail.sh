#!/bin/sh
FILE=/tmp/file
echo "Kicked off the mail script" > $FILE
echo "from the script dialamail.sh @ `date`" >> $FILE
mailx -s "MAile from Script" indira@splunk.com < $FILE
