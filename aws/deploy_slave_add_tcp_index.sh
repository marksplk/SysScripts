#!/bin/bash
set -x

DEPLOY_RUN_FILE="deploy_aws_slave_add_tcp_index_$$.sh"

cat "./aws_instance_list" | while read line; do
	host=`echo $line|cut -d "," -f2`
	nodeType=`echo $line|cut -d "," -f3`
	if [ $nodeType = "slave" ]; then
		echo "sh ../sh/cluster/setup_slave_tcp_index.sh $nodeType $host splunk" >> $DEPLOY_RUN_FILE
	fi
done

chmod 755 $DEPLOY_RUN_FILE