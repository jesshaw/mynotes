#!/bin/bash
# 显示linux日期和主机名的脚本
echo "Current date: $(date) @ $(hostname)"
echo "neteowrk configuration"

echo "Say something"
# 用于多行注释时，始终使用引号，即 : << 'COMMENT'，避免解析注释内容。
: << 'Comment'
    注释行1
    注释行1
Comment

echo "Do something else"