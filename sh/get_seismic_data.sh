#!/bin/bash
for i in {01..29}
do
 if [ $i -lt 10 ]
 then
   i="0${i}"
 fi
 curl -s http://apps1.gdr.nrcan.gc.ca/laurentian/stp-${i}.nav -o ldif/testldif/seis/st-${i}.txt 
done
