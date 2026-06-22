# linux编程

## shell脚本第一行

```bash
#! INTERPRETER [OPTIONS]...
```

INTERPRETER必须是绝对路径

几乎所有的Bash脚都是以`#!/bin/bash`开头。不指定默认为`#!/bin/sh`。

## 注释

```bash
# 单行注释
<<COMMENT
    注释行1
    注释行1
COMMENT
```

- $()：圆括号 → 执行命令。
- ${}：花括号 → 引用/操作变量。

## 用于字符串测试的操作符

```bash
# -z <STRING>  为空则为真
[ -z "" ]; echo $?
# -n <STRING> 不为空则为真
[ -n "a" ]; echo $?
# <STRING1> = <STRING2> 相同则为真
test "abc" = "dce"; echo $?
# <STRING1> != <STRING2> 不同则为真
test "abc" != "dce"; echo $?
[ "abc" != "dce" ]; echo $?
# <STRING1> < <STRING2> STRING1在字典顺序之前则为真
test "abc" \< "dce"; echo $?
# <STRING1> > <STRING2> STRING1在字典顺序之前则为真
test "abc" \> "dce"; echo $?
[ "abc" \> "dce"]; echo $?
```

## 用于算术测试的操作符

```bash
# <INT1> -eq <INT2>  相等则为真
# <INT1> -ne <INT2>  不等则为真
# <INT1> -le <INT2>  小于或等于则为真
# <INT1> -ge <INT2>  大于或等于则为真
# <INT1> -lt <INT2>  小于则为真
# <INT1> -gt <INT2>  大于则为真

test 5 -eq 5 && echo Yes || echo No
[ 5 -ge 5 ] && echo Yes || echo No

```

## if条件判定的语法格式

```bash
if TEST-COMMANDS; then CONSEQUENT-COMMANDS; fi
```


```bash
if TEST-COMMANDS; then
    CONSEQUENT-COMMANDS
fi
```

```bash
if TEST-COMMANDS
then
    CONSEQUENT-COMMANDS
elif TEST-COMMANDS
then
    CONSEQUENT-COMMANDS
else
    CONSEQUENT-COMMANDS
fi
```

## case语句的语法格式

```bash
case EXPRESSION in
    PATTERN1 )
        CONSEQUENT-COMMANDS
        ;;
    PATTERN2 )
        CONSEQUENT-COMMANDS
        ;;
    PATTERN3 )
        CONSEQUENT-COMMANDS
        ;;
    ...
    PATTERNn )
        CONSEQUENT-COMMANDS
        ;;
esac
```

## for循环语句

```bash
for VAR in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done
```

```bash
# 循环变量
for VAR in $fileNames
do
    command1
    command2
    ...
    commandN
done
```

```bash
# 循环命令替换
for VAR in $(Linux-command-name)  # 或使用 `Linux-command-name`
do
    command1
    command2
    ...
    commandN
done
```

```bash
# 循环三项表达式
for ((EXP1; EXP2; EXP3))
do
    command1
    command2
    ...
    commandN
done
```

## while循环语句

```bash
while [ CONDITION ]
do
    command1
    command2
    ...
    commandN
done
```

无限循环

```bash
while : # true 或 false
do
    command1
    command2
    ...
    commandN
done
```

## until循环语句

类似c中的do while循环，至少执行1次

```bash
until [ CONDITION ]
do
    command1
    command2
    ...
    commandN
done
```

## select循环语句

```bash
select VAR in LIST
do
    command1
    command2
    ...
    commandN
done
```

## 循环控制

`break`和`continue`与其它语言完全一致
```bash
# n代表层级
break [n]
continue [n]
```

## 函数

```bash
function_name(){
    commands...
    [ return int;]
}
# 或
function function_name(){
    commands...
    [ return int;]
}
# 或
function name { command1; command2; commandN; }
# 或
function_name() { command1; command2; commandN; }
```

## 函数的传递

```bash
function function_name(){
    arg1=$1
    local var=$2 定义一个本地变量，不会影响到外部的var
    command on $arg1
}
var=abc
function_name "cc"
echo "$var"
```
