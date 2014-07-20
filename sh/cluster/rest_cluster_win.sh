#!/bin/sh
## Created by Indira thangasamy
##      Re-engineering of this code permitted only if you agree to put the 
##      above block of comments in your new code 

while true
do
user=SunLDAP_Alice
pass=SunLDAP_Alice
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/buckets
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/control
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/generation/master
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/indexes
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/info/master
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/peers
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/searchheads
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/sites
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster//searchhead/generation
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster//slave/searchheadcertificate
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/licenser/groups
curl -k -u $user:$pass https://qa-systest-21.sv.splunk.com:1901//services/licenser/licenses
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/licenser/localslave
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/licenser/messages
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/licenser/pools
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/licenser/slaves
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/licenser/stacks
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/messages
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clusterconfig
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterbuckets
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterfixup
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/introspection--resource-usage--splunk-processes
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/introspection--disk-objects--indexes
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/introspection--resource-usage--hostwide
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/introspection--disk-objects--partitions-space
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/introspection--disk-objects--fishbucket
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermastergeneration
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterinfo
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterpeerindexes
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/cluster/master/buckets
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clusterconfig
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterbuckets
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermastercontrol
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterfixup
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermastergeneration
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterinfo
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterpeerindexes
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterpeers
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermasterreplications
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermastersearchheads
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustermastersites
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clustersearchheadgeneration
curl -k -u $user:$pass https://qasvwin2012svr12.sv.splunk.com:1901/services/admin/clusterslavesearchheadcertificate
done
