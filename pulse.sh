#!/bin/bash
LOOP_SEC=$1
ADMIN_PASS=$2
LOADBALANCER_ADDR=$3
BW_LIMIT=$4
LOAD_LIMIT=$8
LOG=/host/tmp/pulse.log

test -z $LOOP_SEC && exit;
test -z $ADMIN_PASS && exit;
test -z $LOADBALANCER_ADDR && exit;
test -z $BW_LIMIT && exit;
test -z $LOAD_LIMIT && exit;

while true; do
    A_CPU=($( ./cpuload.sh $TOTALTICKS $IDLETICKS ))
    TOTALTICKS=${A_CPU[0]}
    IDLETICKS=${A_CPU[1]}
    CPULOAD=${A_CPU[2]}

    A_IO=($( ./ioload.sh $TOTALBYTES $TIMESTAMP ))
    TOTALBYTES=${A_IO[0]}
    TIMESTAMP=${A_IO[1]}
    IOLOAD=${A_IO[2]}

    if [ "x$IC_HOST" == "x127.0.0.1" -o "x$IC_HOST" == "x" ]; then
	MOUNT="0@proxy"
    else
	MOUNT="$( ./mountpoints.sh)"
    fi

echo "H:   $IC_HOST" > $LOG
echo "CPU: $CPULOAD" >> $LOG
echo "IO:  $IOLOAD" >> $LOG
echo "MNT: $MOUNT" >> $LOG

    if [ "x$CPULOAD" != "x" -a "x$IOLOAD" != "x" -a "x$MOUNT" != "x" ]; then
	    curl -o /dev/null --connect-timeout 5 --max-time 10 --digest --user "admin:$ADMIN_PASS" -s "http://$LOADBALANCER_ADDR/update.php?mnt=$MOUNT&bw=$IOLOAD&bwl=$BW_LIMIT&load=$CPULOAD&loadl=$LOAD_LIMIT" 2>&1 > /dev/null 
	    echo "$CPULOAD" > /host/tmp/pulse.cpuload
	    echo "$LOADBALANCER_ADDR" > /host/tmp/loadbalancer.addr
    fi
    sleep $LOOP_SEC
done

exit
