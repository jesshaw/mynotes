#!/bin/bash

set 1 2 3 four five six 7 8 9 ten
echo "$1 $9 ${10}"

echo "argument 1: $1"
echo "argument 2: $2"
echo "argument 10: ${10}"

echo "$*"

echo "$@"