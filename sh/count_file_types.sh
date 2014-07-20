#!/bin/bash
DIRS="Splunk_Server_x64 Splunk_Server_x86 Splunk_Universal_Forwarder_x64 Splunk_Universal_Forwarder_x86"
FILE_EXE=/tmp/.fileexe
FILE_dll=/tmp/.filedll
FILE_sys=/tmp/.filesys
FILE_drv=/tmp/.filedrv
FILE=/tmp/FilesCount.txt
BASE=$HOME/Downloads/msi
set -x
pretty_print()
{
	 SPL=$1
    perl -i -pe 's/ //g' $SPL
	cat $SPL |while read line
	do
	 Fname=`basename "$line"`
	echo "    $Fname"
	done
}
/bin/rm -f $FILE
for dir in $DIRS
do
 echo "processing $dir"
 find  $BASE/$dir   -name '*.exe' > $FILE_EXE
 count=`wc -l $FILE_EXE|awk '{print $1}'`
 echo "Product $dir
 There are  $count exe files" >> $FILE
 pretty_print $FILE_EXE >> $FILE
 find  $BASE/$dir   -name '*.dll' > $FILE_dll
 count=`wc -l $FILE_dll|awk '{print $1}'`
 echo "
 There are  $count dll files" >> $FILE
 pretty_print $FILE_dll >> $FILE
 find  $BASE/$dir   -name '*.sys' > $FILE_sys
 count=`wc -l $FILE_sys|awk '{print $1}'`
 echo "
 There are  $count sys files" >> $FILE
 pretty_print $FILE_sys >> $FILE
 find  $BASE/$dir   -name '*.drv' > $FILE_drv
 count=`wc -l $FILE_drv|awk '{print $1}'`
 echo "There are  $count drv files" >> $FILE
 pretty_print $FILE_drv >> FILE
 echo "====================================="  >> $FILE
done



