#!/bin/bash
TIME_LIMIT=10
INTERVAL=1

echo
echo "Hit Control-C to exit before ${TIME_LIMIT} seconds."
echo

while [ "$SECONDS" -le "$TIME_LIMIT" ]
do 
    if [ "$SECONDS" -eq 1 ]
    then
        units=second
    else
        units=seconds
    fi

    echo "This script has been running $SECONDS $units."

    sleep $INTERVAL
done
exit 0