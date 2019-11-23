#!/bin/bash
if [ -z $1 ]; then
    POINTS=1000
else
    POINTS=$1
fi

HOSTS=(
    user@192.168.56.105:
    root@192.168.56.104:
    fettuccine@localhost:
)
TMP=$(mktemp)

# Copy program to hosts
echo "Connecting..."
PROGRAM=$(mktemp)
for host in ${HOSTS[*]}; do
    scp -q math.pl "${host}${PROGRAM}"
done

# Execute and save results to file
echo "Executing..."
HOSTLIST=$(tr ' ' ',' <<< ${HOSTS[*]})
pexec -n "$HOSTLIST" -o "$TMP" -c -- "perl $PROGRAM $POINTS; rm $PROGRAM"

# Calculate average of results
for i in $(cat $TMP); do
    SUM=$((SUM + i))
done
NODES=$(cat $TMP | wc -l)
PI=$(perl -e "print 4*$SUM/$NODES/$POINTS")

# Done
echo "Pi is about: $PI"

rm $TMP
