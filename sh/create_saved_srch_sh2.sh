#!/bin/sh
#count=3000
#cat $HOME/scripts/uids.txt|while read line
for i in `seq 1 1000`
do
curl -k -u user.${i}:password  https://qa-systest-19.sv.splunk.com:1901/services/saved/searches -d name="user.${i}.syslog" -d search="|tstats count where index%3Dsyslog groupby splunk_server"
done

