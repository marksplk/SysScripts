for i in `seq 11 16`
do
echo -n "qasvwin2012svr$i's version: "
curl -s -k https://qasvwin2012svr$i.sv.splunk.com:1901/services/server/info| grep build | head -1  | cut -d\= -f2,3|cut -d \/ -f1
host qasvwin2012svr$i
done
