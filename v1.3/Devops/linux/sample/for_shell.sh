#!/bin/bash

for i in 1 2 3
do
    echo "The for loop is run $i times"
done

for file in `ls *`
do
    echo $file
done

for ((i=0;i<3;i++))
do
    for ((j=0; j < 5; j++))
    do
        echo -n "* "
    done
    echo ""
done