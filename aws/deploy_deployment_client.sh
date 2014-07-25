#!/bin/bash
set -x

DEPLOY_RUN_FILE="deploy_aws_deployment_client_$$.sh"

export LICENSE_MASTER
export DEPLOYMENT_SERVER
while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	internal_host=`echo $line|cut -d "," -f5`
	if [ $nodeType == "licenseMaster" ]; then
		LICENSE_MASTER=$internal_host
	elif [ $nodeType == "deploymentServer" ]; then
		DEPLOYMENT_SERVER=$internal_host
	fi
done<"./aws_instance_list"

cat "./aws_instance_list" | while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	if [ $nodeType = "slave" ]; then
		echo "sh ../sh/cluster/setup_deployment_client.sh $nodeType $host splunk $DEPLOYMENT_SERVER" >> $DEPLOY_RUN_FILE
	fi
done

chmod 755 $DEPLOY_RUN_FILE

echo "execute the $DEPLOY_RUN_FILE to deploy the deployment client"
