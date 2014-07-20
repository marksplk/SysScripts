#!/bin/bash
# Create new config stanza
PASSWD=changeme
HOST=localhost
curl -k -s -u admin:$PASSWD -X PUT  "https://$HOST:8089/services/properties/alert_actions/email"
cat email|while read line
do
curl -k -s -u admin:$PASSWD -X POST  -d "$line" "https://$HOST:8089/services/properties/alert_actions/email"
echo "Done with $line"
done
curl -k -s -u admin:$PASSWD -X GET  "https://$HOST:8089/services/properties/alert_actions/email"


