#!/bin/bash
set -x
if [ $# -lt 3 ]
then
    echo "Usage: $0 NodeType remoteHostName build_prefix"
    exit 1
fi
nodeType=$1
rep_port=9011
master_port=1901
proto=https
hname=$2
base="~/systest/clustering"
prefix="$3"
RUN_FILE=/tmp/node.config.$$

index_target="$4"
PORT=9777
INDEXNAME="forward_data"

echo "
#!/bin/bash

cat <<EOF >$base/$prefix/etc/system/local/outputs.conf
[tcpout]
defaultGroup=my_indexers

[tcpout:my_indexers]
server=$index_target:9777

[tcpout-server://$index_target:9777]
compressed=false
sendCookedData=true

EOF

$base/$prefix/bin/splunk restart
$base/$prefix/bin/splunk add monitor /var/log/syslog -auth admin:changeme
"> $RUN_FILE

chmod 755 $RUN_FILE 
scp -i /Users/cesc/Work/Documents/AWSkeys/mark_splk.pem $RUN_FILE ubuntu@$hname:$RUN_FILE
ssh -i /Users/cesc/Work/Documents/AWSkeys/mark_splk.pem ubuntu@$hname $RUN_FILE
/bin/rm $RUN_FILE