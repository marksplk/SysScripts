for i in `seq 1 9`
#for i in `seq 10 18`
do
echo -n "qa-systest-0$i's version: "
curl -s -k https://qa-systest-0$i.sv.splunk.com:1901/services/server/info| grep build | head -1  | cut -d\= -f2,3|cut -d \/ -f1
#host qasvwin2012svr$i
done
