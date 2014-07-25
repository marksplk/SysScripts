# SYS deployment on AWS

## Preparation

* install the "boto" and "fabric" modules which will been used when creating the AWS instance.

```
	pip install boto
	pip install fabric
```

* checkout the "sysscripts" project from github
* set the workspace to "aws"

```
	cd aws
```

## Deployment

>  Warning: execute the command under the `aws` workspace otherwise may cause some relative path error


#### Create the aws instances


```
	python aws_clustering.py
```
the parameters inside the `aws_clustering.py` is configurable as following

```
master = 1
deployment_server = 1
slave = 3
search_head = 1
license_master = 1
forwarder = 1
``` 

after the successfuly finish the step , a new file `aws_instance_list` will been generated under the same folder. The schema of the `aws_isntance_list` as following 

```
instance_id,public_ip,nodeType,public_dns_domain,private_ip
```

#### deploy the splunk to all instances

```
	sh deploy_splunk.sh
	sh [The shell script generated]
```

#### deploy the license master

```
	sh deploy_license_master.sh
	sh [The shell script generated]
```

#### deploy the cluster with the license master

```
	sh deploy_splunk_cluster.sh
	sh [The shell script generated]
```

#### deploy the deployment server

```
	sh deploy_deployment_server.sh
	sh [The shell script generated]
```

#### deploy the deployment client

```
	sh deploy_deployment_client.sh
	sh [The shell script generated]
```

#### create the index on search peer and listern on TCP port

```
	sh deploy_slave_add_tcp_index.sh
	sh [The shell script generated]
```

#### add the monitor fowarder to the indexer

```
	sh ../sh/cluster/setup_add_monitor_forwarder.sh forwarder [forwarder_public_ip] splunkforwarder [target indexer public ip]
```
