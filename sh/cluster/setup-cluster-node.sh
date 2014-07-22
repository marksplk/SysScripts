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
licensefile="500MB.lic"

licensemaster="$4"
masterUrl="$5"

if [ $nodeType = "master" ]
then
    echo "#!/bin/bash
    $base/$prefix/bin/splunk edit cluster-config -mode master -secret secret12 -auth admin:changeme
    $base/$prefix/bin/splunk stop -f  
    $base/$prefix/bin/splunk start  
    $base/$prefix/bin/splunk list master-info -auth admin:changeme
    " > $RUN_FILE
elif [ $nodeType = "slave" ]
then
    echo "#!/bin/bash
    $base/$prefix/bin/splunk edit cluster-config -mode slave -secret secret12  -master_uri ${proto}://$masterUrl:$master_port -replication_port $rep_port -auth admin:changeme
    $base/$prefix/bin/splunk edit licenser-localslave -master_uri https://$licensemaster:1901 -auth admin:changeme
    $base/$prefix/bin/splunk stop -f  
    $base/$prefix/bin/splunk start  
    $base/$prefix/bin/splunk list peer-info  -auth admin:changeme
    $base/$prefix/bin/splunk enable listen -port 9999 -auth admin:changeme
    " > $RUN_FILE
elif [ $nodeType = "licenseMaster" ]; then
    echo "#!/bin/bash
        $base/$prefix/bin/splunk add licenses ~/500MB.lic -auth admin:changeme
        $base/$prefix/bin/splunk restart
        $base/$prefix/bin/splunk edit licenser-groups Enterprise -is_active 1 -auth admin:changeme
        $base/$prefix/bin/splunk restart
    " > $RUN_FILE
elif [ $nodeType = "deploymentServer" ]; then
    echo "
    #!/bin/bash
    $base/$prefix/bin/splunk edit licenser-localslave -master_uri https://$licensemaster:1901 -auth admin:changeme
    $base/$prefix/bin/splunk enable deploy-server -auth admin:changeme
    $base/$prefix/bin/splunk stop -f  
    $base/$prefix/bin/splunk start
" > $RUN_FILE
else
    echo "#!/bin/bash
    $base/$prefix/bin/splunk edit cluster-config -mode searchhead -secret secret12  -master_uri ${proto}://$masterUrl:$master_port -replication_port $rep_port -auth admin:changeme
    $base/$prefix/bin/splunk edit licenser-localslave -master_uri https://$licensemaster:1901 -auth admin:changeme
    $base/$prefix/bin/splunk stop -f  
    $base/$prefix/bin/splunk start  
    $base/$prefix/bin/splunk list peer-info -auth admin:changeme
    " > $RUN_FILE
fi
chmod 755 $RUN_FILE
echo $RUN_FILE
scp -i /Users/cesc/Work/Documents/AWSkeys/mark_splk.pem $RUN_FILE ubuntu@$hname:$RUN_FILE
ssh -i /Users/cesc/Work/Documents/AWSkeys/mark_splk.pem ubuntu@$hname $RUN_FILE
/bin/rm $RUN_FILE
