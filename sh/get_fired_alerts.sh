#!/bin/bash
while true
do
 curl -s -k -u admin:secret12 https://qaad1.sv.splunk.com:8089/servicesNS/-/-/alerts/fired_alerts|grep totalResults|cut -d: -f2|cut -d\> -f2|cut -d\< -f1
done


## IPv6 monitor
## curl -v -k -u admin:changeme -g "https://[::1]:8087/servicesNS/-/-/data/inputs/monitor"
## curl -v -k -u admin:changeme -g "http://[fdb8:325:94e3:10::113]:8087/servicesNS/-/-/data/inputs/monitor"

