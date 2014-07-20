FLE=/Volumes/hellaspace/dropbox/for_indira/data/indira.txt
#FLE=/Users/ithangasamy/scripts/50kuidPwd.txt
while true
do
cat $FLE | while read line 
do
curl -s -k -X POST -d "username=$line&password=$line" https://sveserv50.sv.splunk.com:8089/services/auth/login
done
echo "Loop done at `date`"
done 

