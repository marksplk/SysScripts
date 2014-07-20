echo "{| class=\"wikitable\"
	|-
		! Owner!! Test Name
		"
cat /tmp/ll |while read line
do
fld1=`echo $line|cut -d\| -f1`
fld2=`echo $line|cut -d\| -f2`
	echo "|-
		| $fld1 || $fld2 
		|- "
done
		echo "
		|} "
