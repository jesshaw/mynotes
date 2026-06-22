#!/bin/bash

var=1
while [ $var -le 3 ]
do
    echo "The while loop is run $var times."
    var=$((var+1))
done