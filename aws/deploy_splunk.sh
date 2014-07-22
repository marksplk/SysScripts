#!/bin/bash

SPLUNK_RELEASE="http://ec2-54-179-189-159.ap-southeast-1.compute.amazonaws.com/splunk-6.1.2-213098-Linux-x86_64.tgz"
SPLUNK_FORWARDER_RELEASE="http://ec2-54-179-189-159.ap-southeast-1.compute.amazonaws.com/splunkforwarder-6.1.3-216374-Linux-x86_64.tgz"

DEPLOY_RUN_FILE="deploy_aws_$$.sh"

cat "./aws_instance_list" | while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	if [ ! $nodeType = "forwarder" ]; then
		echo "sh ../sh/setup-instance.sh $host $SPLUNK_RELEASE splunk" >> $DEPLOY_RUN_FILE
	fi
done

chmod +x $DEPLOY_RUN_FILE
