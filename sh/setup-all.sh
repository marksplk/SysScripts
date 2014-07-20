#!/bin/bash 
URL="$1"
#setup instance 
$HOME/bin/setup-instance.sh fool01 $URL splunk
$HOME/bin/setup-instance.sh fool03 $URL splunk
$HOME/bin/setup-instance.sh fool05 $URL splunk
$HOME/bin/setup-instance.sh fool06 $URL splunk
$HOME/bin/setup-instance.sh fool08 $URL splunk
$HOME/bin/setup-instance.sh fool10 $URL splunk
#Setup Clsuter 
$HOME/bin/setup-cluster-node.sh master fool01 splunk
$HOME/bin/setup-cluster-node.sh slave fool05 splunk
$HOME/bin/setup-cluster-node.sh slave fool06 splunk
$HOME/bin/setup-cluster-node.sh slave fool08 splunk
$HOME/bin/setup-cluster-node.sh slave fool03 splunk
$HOME/bin/setup-cluster-node.sh searchhead fool10 splunk
