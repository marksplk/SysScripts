for i in 1tb blue bt green main spritzer twitter 
do
echo "Events in $i"
$SPLUNK_HOME/bin/splunk search "index=$i * |stats count" -auth admin:changeme -preview false
done
