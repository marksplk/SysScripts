#!/bin/bash

DEPLOY_RUN_FILE="deploy_license_master_$$.sh"

cat "./aws_instance_list" | while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	if [ $nodeType = "licenseMaster" ]; then
		echo "sh ../sh/cluster/setup-cluster-node.sh $nodeType $host splunk" >> $DEPLOY_RUN_FILE
	fi
done

chmod +x $DEPLOY_RUN_FILE