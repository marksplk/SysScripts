#!/bin/bash
return_item()
{
if [ $# -ne 1 ]
then
echo "Syntax: $0 FILE"
echo $0 - display a random line from FILE.
exit 1
fi
RAND=`od -An -N1 -i /dev/random|awk '{print $1}'`
head -$RAND $1 | tail -1
return 
}

tz1=`return_item $HOME/scripts/tzdata.txt`
zdump -v $tz1
