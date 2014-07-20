cd $SPLUNK_HOME
$SPLUNK_HOME/bin/splunk stop -f 
tar xvfz  /mnt/engineering_qa/bits/splunk-6.1-202854-Linux-x86_64.tgz
$SPLUNK_HOME/bin/splunk start
