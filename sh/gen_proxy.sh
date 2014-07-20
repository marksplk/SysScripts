cnt=16
cat ssoHosts |while read line
do
echo "
#Mapping for $line
ProxyPass /sso$cnt http://$line/sso$cnt retry=1
ProxyPassReverse /sso$cnt http://$line/sso$cnt retry=1 "
cnt=`expr $cnt + 1`
done
