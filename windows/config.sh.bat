c:\splunk\bin\splunk.exe edit licenser-localslave -master_uri https://qa-systest-35.sv.splunk.com:1901 -auth admin:changeme 
c:\splunk\bin\splunk.exe edit cluster-config   -mode searchhead -secret secret12 -master_uri https://qa-systest-35.sv.splunk.com:1901 -auth admin:changeme -replication_port 6565 
c:\splunk\bin\splunk.exe restart -f  

