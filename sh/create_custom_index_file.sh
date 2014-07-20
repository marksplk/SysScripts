#!/bin/bash
for i in `seq 1 500`
do
echo "
[myindex${i}]
coldPath = \$SPLUNK_DB/myindex${i}/colddb
homePath = \$SPLUNK_DB/myindex${i}/db
thawedPath = \$SPLUNK_DB/myindex${i}/thaweddb
maxDataSize=5
maxHotBuckets=15
maxHotSpanSecs=7776
"
done

