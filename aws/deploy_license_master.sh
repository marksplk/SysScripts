#!/bin/bash

DEPLOY_RUN_FILE="deploy_aws_license_master_$$.sh"
licensefile="./licenses/500MB.lic"

cat "./aws_instance_list" | while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	if [ $nodeType = "licenseMaster" ]; then
		scp -i ~/Work/Documents/AWSkeys/mark_splk.pem $licensefile ubuntu@$host:500MB.lic
		echo "sh ../sh/cluster/setup-cluster-node.sh $nodeType $host splunk" >> $DEPLOY_RUN_FILE
	fi
done

chmod +x $DEPLOY_RUN_FILE
echo "execute the $DEPLOY_RUN_FILE to deploy the license master"