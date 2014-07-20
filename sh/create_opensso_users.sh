#!/bin/bash
input=/Users/ithangasamy/scripts/uids.txt
token=`curl -s  -d "&username=amadmin&password=secret12" http://localhost:8080/opensso/identity/authenticate|cut -d= -f2-`
cat $input | while read line
do
  curl -X POST -d "identity_name=$line&identity_attribute_names=userpassword&identity_attribute_values_userpassword=$iline&identity_attribute_names=sn&identity_attribute_values_sn=${line}_sn_for_rest_user&identity_attribute_names=cn&identity_attribute_values_cn=${line}_cn_of_REST_user&identity_realm=/&identity_type=user&admin=$token" http://localhost:8080/opensso/identity/create
  echo "Done with $line"
 done
