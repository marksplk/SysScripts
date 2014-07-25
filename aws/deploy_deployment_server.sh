#!/bin/bash

export deploymentserver_host

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

DEPLOY_RUN_FILE="deploy_aws_deploymentserver_$$.sh"

while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	if [ $nodeType == "deploymentServer" ]; then
		deploymentserver_host=$host
		echo "sh ../sh/cluster/setup-cluster-node.sh $nodeType $host splunk $LICENSE_MASTER $MASTER">> $DEPLOY_RUN_FILE
	fi
done<"./aws_instance_list"

chmod 755 $DEPLOY_RUN_FILE

echo "execute the $DEPLOY_RUN_FILE to deploy the deployment server"