cat j | while read line
do
curl -k -uadmin:secret12 -X GET https://qa-sv-rh61x64-4:8089/services/deployment/server/clients/$line
curl -k  -X DELETE  -uadmin:secret12 https://qa-sv-rh61x64-4:8089/services/deployment/server/clients/$line
done
