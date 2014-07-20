#!/bin/bash

cat /mnt/indira_cluster/indira/index.txt | while read line
do 
echo "
#Index definition of $line
[$line]
homePath = \$SPLUNK_HOME/var/lib/splunk/$line/db
coldPath = \$COLDPATH/var/lib/splunk/$line/colddb
thawedPath = \$SPLUNK_HOME/var/lib/splunk/$line/thaweddb
maxMemMB = 25
maxDataSize = 12
maxTotalDataSizeMB = 200
maxWarmDBCount = 12
repFactor = auto

"
done

