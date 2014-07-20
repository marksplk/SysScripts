#!/bin/bash
for i in  `seq -w 1 25`
do
ssh -t ithangasamy@qa-systest-${i}.sv.splunk.com sudo /mnt/engineering_qa/indira/create_home.sh
done
