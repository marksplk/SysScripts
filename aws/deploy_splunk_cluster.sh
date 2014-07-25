#!/bin/bash

SPLUNK_RELEASE="http://ec2-54-179-189-159.ap-southeast-1.compute.amazonaws.com/splunk-6.1.2-213098-Linux-x86_64.tgz"
DEPLOY_RUN_FILE="deploy_aws_cluster_$$.sh"

export LICENSE_MASTER
export MASTER
while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	internal_host=`echo $line|cut -d "," -f5`
	if [ $nodeType == "licenseMaster" ]; then
		LICENSE_MASTER=$internal_host
	elif [ $nodeType == "master" ]; then
		MASTER=$internal_host
	fi
done<"./aws_instance_list"

echo $LICENSE_MASTER
echo $MASTER

cat "./aws_instance_list" | while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	if [ $nodeType == "master" ]; then
		echo "sh ../sh/cluster/setup-cluster-node.sh $nodeType $host splunk $LICENSE_MASTER $MASTER" >> $DEPLOY_RUN_FILE
	elif [ $nodeType == "searchHead" ] || [ $nodeType == "slave" ]; then
		echo "sh ../sh/cluster/setup-cluster-node.sh $nodeType $host splunk $LICENSE_MASTER $MASTER" >> $DEPLOY_RUN_FILE
	fi
done

chmod +x $DEPLOY_RUN_FILE

echo "execute the $DEPLOY_RUN_FILE to deploy the cluster with [master,indexer,search head]"