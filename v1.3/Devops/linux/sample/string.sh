#!/bin/bash

PARAMETER=TEMP
TEMP="it's indirect"
echo ${!PARAMETER}
echo ${PARAMETER}

## 字符串大小写

# 第一个字母大写
echo ${!PARAMETER^}
# 所有字母大写
echo ${!PARAMETER^^}

# 第一个字母小写
echo ${PARAMETER,}
# 所有字母小写
echo ${PARAMETER,,}
# 第一个字母小写
echo ${PARAMETER~}
# 所有字母小写
echo ${PARAMETER~~}

# 列出以字符串BASH开头的所有变量名
echo ${!BASH*}
echo ${!BASH@}


## 字符串截取

MYSTRING="This is used for removing string"

# 从开头除匹配“* ”的一个文本
echo ${MYSTRING#* }
# 从开头除匹配“* ”的所有文本
echo ${MYSTRING##* }

# 从末尾除匹配“ *”的一个文本
echo ${MYSTRING% *}
# 从末尾移除匹配“ *”的所有文本
echo ${MYSTRING%% *}


## 字符串搜索与替换

MYSTRING="This is used for replaceing string or removeing string"

# 从开头替换string为characters
echo ${MYSTRING/string/characters}
# 替换所有string为characters
echo ${MYSTRING//string/characters}


# 删除第1个string
echo ${MYSTRING/string}
# 删除所有string
echo ${MYSTRING//string}
# 删除所有string
echo ${MYSTRING//string/}


## 字符串长度

MYSTRING="Hello World"

echo ${#MYSTRING}
echo ${MYSTRING:1}
# 从第1位（首位是0）截取长度为6的字符串
echo ${MYSTRING:1:6}


## 字符串默认值 
unset MYSTRING
echo ${#MYSTRING}
echo ${MYSTRING}
echo ${MYSTRING:-hello world}
echo ${MYSTRING-hello}


## 字符串设置默认值
unset MYSTRING
echo ${MYSTRING:=Hello world}
echo ${MYSTRING}

unset MYSTRING
echo ${MYSTRING=hello}
echo ${MYSTRING}

## 字符串替代值

# 未定义或为空值不使用替代值
MYSTRING=""
echo ${MYSTRING:+Hello world}

# 不为空值使用替代值
MYSTRING="Hi"
echo ${MYSTRING+注意：MYSTRING的值已设置}
echo ${MYSTRING}
