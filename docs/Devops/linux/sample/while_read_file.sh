#!/bin/bash
file=$1

if [ $# -lt 1 ]
then
    echo "Useage: $0 FILEPATH"
    exit
fi

while read -r line
do
    echo $line
done < "$file"


while read -r f1 f2 f3
do
    echo "Field 1: $f1 ==> Field 2: $f2 ==> Field 3: $f3"
done < "$file"
