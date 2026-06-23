#!/bin/bash

## 条件测试语法，方括号两边都必须得有空格
## test命令可以用于文件属性测试；字符串测试；算术测试
#  test EXPRESSION
#  或
#  [ EXPRESSION ]

# echo $? 显示上一次执行的结果
test -d "$HOME"; echo $?

[ "abc" != "abcd" ]; echo $?


test 7 -gt 3 && echo True || echo False 