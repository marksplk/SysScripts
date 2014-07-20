#!/bin/bash
ACCESS_TOKEN="jGVWzve0v3fw5FZlM98J6DIL-jio_NWE0YRcEKugkANustY1aTB392UmeexGfIPT8lM1DSCoF2w="
cat ~/scripts/data/enwiki-20080103-abstract.xml | while read line
do
curl -u $ACCESS_TOKEN:Storm \
		   "https://api.staging.splunkstorm.com/1/inputs/http?index=2db3c28a744d11e1a8dc1231390a79e1&sourcetype=rest_input" \
		     -d "$line"
done
