#!/bin/bash


# 对整个脚本进行调试 bash -x ./debug_shell.sh
# set -x和 set+x对某一段代码进行调整
# -v 显示详细输出模式
# 对整个脚本进行调试 bash -xv ./debug_shell.sh
# export PS4='+{$LINENO:${FUNCNAME[0]}}'
# 执行前语法检查 bash -n ./debug_shell.sh

echo "The \$_ is $_"

set -x
uname -a
set +x

echo -a