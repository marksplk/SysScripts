c:\splunk\bin\splunk.exe edit cluster-config -mode master -secret secret12 -auth OpenLDAP_Alice:OpenLDAP_Alice 
copy z:\windows\indexes.conf c:\splunk\etc\master-apps\_cluster\local
copy z:\windows\serverclass.conf c:\splunk\etc\system\local
c:\splunk\bin\splunk.exe restart -f 
