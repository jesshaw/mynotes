#!/bin/bash
set -o nounset
TMOUT=3

echo "Are you sure? (Y/N)"
read input

if [ "$input" == "Y" ]
then
    echo "Continue..."
else
    echo "Exit!"
fi