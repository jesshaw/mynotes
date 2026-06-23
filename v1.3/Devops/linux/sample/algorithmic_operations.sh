#!/bin/bash

## 算术运算与C语言相同

let var=5*2
echo $var


let var=9%2
echo $var

let var*=5
echo $var
let var*=5
echo $var


echo $((2 && 3))
echo $((2 && 0))
echo $((2 || 0))
echo $((0 || 0))

# 逗号运算符将两个或更多的算术运算链接在一起，所有的运算都会被 求值，但只有最后一个的值被返回
let var=(2+3, 10-5, 20-6)
echo $var

let var=(var1=10, 10%3)
echo $var
echo $var1


## 数字常量

let des=20
echo "Decimal number: $des"

let des=020
echo "Octal number: $des"

let des=0x20
echo "Hexadecimal number: $des"

let des=2#111
echo "Binary number: $des"

#@代表62，_代表63
let des=64#@_
echo "Binary number: $des"

var=5
var=$(( $var + 8)) #同 var=$(( var + 8))
echo $var

x=17
y=2
z=$(( x%y ))
echo $z

echo $((10 > 3))

a=28
b=25
c=$(($((a>b))?a:b))
echo $c

let i=i+5
echo $i

let i=i + 5 # 这个会报错运算符两边不包含空格
let "i=i + 5" #  要带空格就必须得带上双引号
echo $i


expr 6 + 8 # 与let相反，运算符两边要使用空格
expr 6+8 # 与let相反，运算符两边要使用空格
expr 6 \* 8 # 运算符，使用转义
expr 6 \> 8 # 运算符，使用转义
expr 6 \< 8 # 运算符，使用转义

a=15
b=35
expr $a \* $b

c=`expr $a \* $b`
echo $c

c=$(expr $a \* $b)
echo $c
