SPLUNK_HOME=/export/home/clustering/splunk
mkdir $SPLUNK_HOME/var/log/splunk/old_logs
$SPLUNK_HOME/bin/splunk stop -f 
mv $SPLUNK_HOME/var/log/splunk/* $SPLUNK_HOME/var/log/splunk/old_logs
