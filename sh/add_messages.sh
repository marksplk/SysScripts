for i in {1..50000}
do
	curl -k -uadmin:secret12 -X POST -d name="MyMessage$i" -dvalue="This is my in the request for the update on the camera image of PDF and bubbles$i" http://wimpy.splunk.com:18091/services/messages/
done
