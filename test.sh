#!/bin/bash
LOOP_SEC=$1
ADMIN_PASS=$2
LOADBALANCER_ADDR=$3
MOUNTPOINT_LIST=$4
BW_LIMIT=$5

test -z $LOOP_SEC && exit;
test -z $ADMIN_PASS && exit;
test -z $LOADBALANCER_ADDR && exit;
test -z $MOUNTPOINT_LIST && exit;
test -z $BW_LIMIT && exit;

VALUE=""
OLDVALUE=""
TIME=""

#echo AAA

while [ $LOOP_SEC -ne 0 ]; do
#echo BBB
    if [ "x$VALUE" != "x" ]; then OLDVALUE=$VALUE; fi
    OLDTIME=$TIME
    TIME=$(date "+%s")
    VALUE=$(iptables -vxn -L OUTPUT | grep OUTPUT | awk '{print $7}')
    if [ "x$OLDVALUE" == "x" ]; then sleep $LOOP_SEC; continue; fi
	echo > /dev/null
    	if [ $VALUE -ge $OLDVALUE ]; then
	    NOB=$[ $VALUE- $OLDVALUE ]
	    NOS=$[ $TIME - $OLDTIME ]
	    BW_KBPS=$[ $[ $[ $NOB * 8 ] / $NOS ] / 1000 ] 
#echo ZAPPI
	    TOPARRAY=($(top -bn1 | grep -iw id | grep -iw wa))
	    IDLE=$(echo ${TOPARRAY[7]} | sed 's/\,.*//')
	    LOAD=$(echo "scale=3;100 - $IDLE;" | bc -l)
echo zuppi
#	    curl -o /dev/null --connect-timeout 1 --digest --user "admin:$ADMIN_PASS" -s "http://$LOADBALANCER_ADDR/update.php?mnt=$MOUNTPOINT_LIST&bw=$BW_KBPS&bwl=$BW_LIMIT&load=$LOAD" 2>&1 > /dev/null
	fi
    sleep $LOOP_SEC
done

exit
