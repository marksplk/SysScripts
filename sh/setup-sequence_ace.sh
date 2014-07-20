echo "Starting the sequence of Configuring the Cluster"
ssh -t eserv@qa-systest-03.sv.splunk.com  "cp /mnt/engineering_qa/windows/authentication.conf /export/home/clustering/splunk/etc/system/local" 
ssh -t eserv@qa-systest-03.sv.splunk.com "/export/home/clustering/splunk/bin/splunk  add license /mnt/engineering_qa/cc.lic -auth admin:changeme ;/export/home/clustering/splunk/bin/splunk version" 
echo " Done Configuring the License Master"
ssh -t eserv@qa-systest-03.sv.splunk.com "/export/home/clustering/splunk/bin/splunk  edit cluster-config -mode master -secret secret12 -replication_factor 1 -search_factor 1 -auth admin:changeme ;/export/home/clustering/splunk/bin/splunk restart -f " 
echo "Done With Configuring the Cluster MAster"
for i in 4 5 6 7 8 9
do
ssh -t eserv@qa-systest-0${i}.sv.splunk.com  "cp /mnt/engineering_qa/windows/authentication.conf /export/home/clustering/splunk/etc/system/local" 
ssh -t eserv@qa-systest-0${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk edit licenser-localslave -master_uri https://qa-systest-03.sv.splunk.com:1901 -auth admin:changeme ; /export/home/clustering/splunk/bin/splunk restart -f" 
echo "Added the Lciense Slave: qa-systest-${i}.sv.splunk.com"
done
#Enable Clsutering
for i in 4 5 6 7 8 9
do
ssh -t eserv@qa-systest-0${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk enable listen 9999 -auth admin:changeme" 
ssh -t eserv@qa-systest-0${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk edit cluster-config   -mode slave -secret secret12  -master_uri https://qa-systest-03.sv.splunk.com:1901 -replication_port 6565 -auth admin:changeme ; /export/home/clustering/splunk/bin/splunk restart -f" 
echo "Done with Configuring the Cluster Slave qa-systest-${i}.sv.splunk.com"
done
#config the search heads
for i in 1 2 
do
ssh -t eserv@qa-systest-0${i}.sv.splunk.com  "/export/home/clustering/splunk/bin/splunk edit cluster-config   -mode searchhead -secret secret12  -master_uri https://qa-systest-03.sv.splunk.com:1901 -replication_port 6565 -auth admin:changeme ; /export/home/clustering/splunk/bin/splunk restart -f" 
echo "Done with SH Cluster qa-systest-${i}.sv.splunk.com"
done
