/export/home/clustering/splunk/bin/splunk stop -f 
echo "SPLUNK_FIPS=0" > /export/home/clustering/splunk/etc/splunk-launch.conf
mv /export/home/clustering/splunk/bin/splunkd /export/home/clustering/splunk/bin/splunkd.org
cp /mnt/engineering_qa/splunkd /export/home/clustering/splunk/bin/splunkd
/export/home/clustering/splunk/bin/splunk restart -f 
