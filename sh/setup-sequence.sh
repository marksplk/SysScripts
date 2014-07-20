echo "Starting the sequence of Configuring the Cluster"
ssh -t eserv@qa-systest-21.sv.splunk.com "/export/home/clustering/splunk/bin/splunk  add license /mnt/engineering_qa/cc.lic -auth admin:changeme ;/export/home/clustering/splunk/bin/splunk version" 
echo " Done Configuring the License Master"
ssh -t eserv@qa-systest-21.sv.splunk.com "/export/home/clustering/splunk/bin/splunk  edit cluster-config -mode master -secret secret12 -auth OpenLDAP_Alice:OpenLDAP_Alice ;/export/home/clustering/splunk/bin/splunk restart -f " 
echo "Done With Configuring the Cluster MAster"
for i in 19 20 22 23 24 25
do
ssh -t eserv@qa-systest-${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk edit licenser-localslave -master_uri https://[2620:70:8000:c146:f292:1cff:fe13:b968]:1901 -auth admin:changeme ; /export/home/clustering/splunk/bin/splunk restart -f" 
echo "Added the Lciense Slave: qa-systest-${i}.sv.splunk.com"
done
#Enable Clsutering
for i in 22 23 24 25
do
ssh -t eserv@qa-systest-${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk enable listen 9999 -auth admin:changeme" 
ssh -t eserv@qa-systest-${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk edit cluster-config   -mode slave -secret secret12  -master_uri https://[2620:70:8000:c146:f292:1cff:fe13:b968]:1901 -replication_port 6565 -auth admin:changeme ; /export/home/clustering/splunk/bin/splunk restart -f" 
echo "Done with Configuring the Cluster Slave qa-systest-${i}.sv.splunk.com"
done
#config the search heads
for i in 19 20 
do
ssh -t eserv@qa-systest-${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk edit cluster-config   -mode searchhead -secret secret12  -master_uri https://[2620:70:8000:c146:f292:1cff:fe13:b968]:1901 -replication_port 6565 -auth admin:changeme ; /export/home/clustering/splunk/bin/splunk restart -f" 
echo "Done with SH Cluster qa-systest-${i}.sv.splunk.com"
done
