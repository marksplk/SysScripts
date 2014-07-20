#!/bin/bash
for i in `seq 2 35`
do
cat <<EOF 
==Scenario $i==

{| class="wikitable" style="color:green; background-color:#ffffcc;" cellpadding="10" cellspacing="0" border="1"
|+
|-
! scope="col" | Configuration
! scope="col" | Pre-Condition
! scope="col" | Setup/Configuration
! scope="col" | Expected Results
! scope="col" | Status
|-
| 
*Number of Sites: 
*sites - origin: ,total: 
|
*  sites – each site has  peers
|
#
|
*
|
-
|}
EOF
done

