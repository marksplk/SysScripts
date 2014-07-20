for i in `seq 10 50`; do ping -c 2 qa-systest-${i}.sv.splunk.com ; done
#for i in `seq 1 9`; do ssh -t eserv@qa-systest-0${i}.sv.splunk.com  "cat  /mnt/engineering_qa/bashrc >> /home/eserv/.bashrc" ; done
