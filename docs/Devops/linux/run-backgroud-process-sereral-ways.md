---
title: 在Linux中后台运行进程的几种方法
tags: linux,process,后台运行
categories: 
  - linux

thumbnail: /gallery/blue-water10.jpg

---

第二次碰到需要在后台运行进程，主要解决用telnet/ssh登录Linux服务器后，让一些程序一直运行，不受关闭终端/网络断开连接影响而不能使用。以下给出了多种方法，分别适用于不同场景。

<!-- more -->

## nohup

nohup 的用途就是让提交的命令忽略 hangup 信号
``` bash
nohup ping lexiangmiao.com & 

nohup ping lexiangmiao.com >log.txt>&1 &

ps -ef |grep lexiangmiao.com
```

## setsid

用一新的会话运行程序
``` bash
setsid ping lexiangmiao.com

ps -ef |grep lexiangmiao.com
```

## &

使用()和&小技巧可以实现后台稳定运行

()可以运行多个命令

``` bash
# 终端关闭（收到 HUP即hangup信号）后就其子进程也关闭了
ping lexiangmiao.com &

# 新提交的进程的父 ID（PPID）为1（init 进程的 PID），并不是当前终端的进程 ID。因此并不属于当前终端的子进程，从而也就不会受到当前终端的 HUP 信号的影响了
(ping lexiangmiao.com &)
ps -ef |grep lexiangmiao.com
```

## disown

``` bash
cp -r testLargeFile largeFile &
jobs
# 指jobs查出的编号
disown -h %1
```


## screen

已经知道了如何让进程免受 HUP 信号的影响，但是如果有大量这种命令需要在稳定的后台里运行，如何避免对每条命令都做这样的操作呢？

用screen -dmS session name来建立一个处于断开模式下的会话（并指定其会话名）

``` bash

screen -r Urumchi
ping www.ibm.com &

## 查看依赖关系树
pstree -H 9488
```

## 总结

综上所述，nohup/setsid 无疑是临时需要时最方便的方法，disown 能帮助我们来事后补救当前已经在运行了的作业，而 screen 则是在大批量操作时不二的选择了。

[ref](https://www.ibm.com/developerworks/cn/linux/l-cn-nohup/)


