indexes="twitter 1tb main _internal j2ee syslog _audit spritzer"
for indx in $indexes
do
echo "starting count for index $indx" >>/mnt/engineering_qa/total.count.txt
cnt=`$SPLUNK_HOME/bin/splunk search "index=$indx |stats count" -preview false -auth OpenLDAP_Alice:OpenLDAP_Alice`
echo "$indx Count is: $cnt" >>  /mnt/engineering_qa/total.count.txt
done
