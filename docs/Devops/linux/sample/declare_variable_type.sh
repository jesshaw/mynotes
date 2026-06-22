#!/bin/bash

# 声明为整数类型的NUMBER变量
declare -i NUMBER

NUMBER=1
echo "The number is $NUMBER"

NUMBER=one
echo "The number is $NUMBER"

NUMBER=9/2
echo "The number is $NUMBER"



# 声明为数组变量
declare -a ARRAYNAME
ARRAYNAME[0]=aa
ARRAYNAME[1]=bb
echo "The array is ${ARRAYNAME[0]}"


declare -a linux=('Debian' 'Redhat' 'Suse' 'Fedora')
echo "${linux[@]}"

al=('a' 'b' 'c' 'd')

echo "${al[@]}"
echo "${al[*]}"

unset al[2]
echo "${al[*]}"

unset al
echo "${al[*]}"
