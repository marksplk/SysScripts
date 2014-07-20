#!/bin/bash
cat ~/scripts/data/enwiki-20080103-abstract.xml| while read line
do
curl -s  -k -u admin:secret12 "https://qa-sol10sparc.splunk.com:8089/services/receivers/simple?source=www&sourcetype=web_event" -d "$line" > /dev/null
done
