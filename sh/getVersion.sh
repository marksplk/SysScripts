set -x
#!/bin/bash
#curl -k -s https://qa-systest-${1}.sv.splunk.com:1901/services/server/info| grep "generator"
for i in  `seq -w 1 8`
do
echo "qa-systest-0${i}.sv.splunk.com"
hname=`curl -k -s https://qa-systest-08.sv.splunk.com:1901/services/server/info | grep serverName |cut -d\> -f2|cut -d \< -f1`
version=`curl -k -s https://qa-systest-08.sv.splunk.com:1901/services/server/info | grep  version|tail -1 | cut -d\> -f2|cut -d \< -f1`
build_version=`curl -k -s https://qa-systest-08.sv.splunk.com:1901/services/server/info | grep build | head -1  | cut -d\= -f2,3`

#curl -k -s https://qa-systest-${host}.sv.splunk.com:1901/services/server/info
done
