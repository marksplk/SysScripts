while true
do
/export/home/clustering/splunk/bin/splunk search "|tstats count where index=* groupby splunk_server" -auth OpenLDAP_Alice:OpenLDAP_Alice -uri https://qa-systest-26.sv.splunk.com:1901
/export/home/clustering/splunk/bin/splunk search "|tstats count where index=* groupby splunk_server" -auth OpenLDAP_Alice:OpenLDAP_Alice -uri https://qa-systest-27.sv.splunk.com:1901
/export/home/clustering/splunk/bin/splunk search "|tstats count where index=* groupby splunk_server" -auth OpenLDAP_Alice:OpenLDAP_Alice -uri https://qa-systest-01.sv.splunk.com:1901
/export/home/clustering/splunk/bin/splunk search "|tstats count where index=* groupby splunk_server" -auth OpenLDAP_Alice:OpenLDAP_Alice -uri https://qa-systest-02.sv.splunk.com:1901
/export/home/clustering/splunk/bin/splunk search "|tstats count where index=* groupby splunk_server" -auth OpenLDAP_Alice:OpenLDAP_Alice -uri https://qa-systest-19.sv.splunk.com:1901
/export/home/clustering/splunk/bin/splunk search "|tstats count where index=* groupby splunk_server" -auth OpenLDAP_Alice:OpenLDAP_Alice -uri https://qa-systest-20.sv.splunk.com:1901
/export/home/clustering/splunk/bin/splunk search "|tstats count where index=* groupby splunk_server" -auth OpenLDAP_Alice:OpenLDAP_Alice -uri https://qa-systest-11.sv.splunk.com:1901
done
