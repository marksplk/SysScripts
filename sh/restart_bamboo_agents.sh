for i in 05 06 07 08 09 10 11 12 13 14 15; do ssh bamboo@qa-test-lin-2${i}.sv.splunk.com ./bamboo-agent-home/bin/bamboo-agent.sh restart; done
