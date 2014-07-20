#!/bin/sh
## Created by Indira thangasamy
##      Re-engineering of this code permitted only if you agree to put the 
##      above block of comments in your new code 

#count=3000
#cat $HOME/scripts/uids.txt|while read line
for i in `seq 1 1000`
do
curl -k -u user.${i}:password  https://qa-systest-20.sv.splunk.com:1901/services/saved/searches -d name="user.${i}.aaaMysavedSearch" -d search="|tstats count where index%3D* groupby splunk_server"
count=`expr $count + 1`
done

