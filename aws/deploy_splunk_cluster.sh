#!/bin/bash

SPLUNK_RELEASE="http://ec2-54-179-189-159.ap-southeast-1.compute.amazonaws.com/splunk-6.1.2-213098-Linux-x86_64.tgz"
DEPLOY_RUN_FILE="deploy_aws_cluster_$$.sh"

cat "../../amazone_server_config" | while read line; do
	host=`echo $line|cut -d " " -f2`
	nodeType=`echo $line|cut -d " " -f3`
	echo "sh ../sh/cluster/setup-cluster-node.sh $nodeType $host splunk" >> $DEPLOY_RUN_FILE
done

chmod +x $DEPLOY_RUN_FILE