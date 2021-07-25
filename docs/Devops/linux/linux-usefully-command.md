---
title: linux常用命令
tags: linux,linux
categories: 
  - linux
thumbnail: /gallery/blue-water9.jpg
---

收集平时常用的一些linux命令。
<!-- more -->

## 排序的方式查看进程使用情况

```bash
ps aux --sort -rss
```

## ssh几个超时参数

### 客户端方案
Host *
    ServerAliveInterval 60

### 服务器方案
```bash
vim /etc/ssh/sshd_config
```

\#ClientAliveInterval 0改为ClientAliveInterval 500     （每500秒往客户端发送会话请求，保持连接）

\#ClientAliveCountMax 3      （去掉注释即可，3表示重连3次失败后，重启SSH会话）

```bash
systemctl restart sshd   #重启sshd服务
```


http://www.361way.com/ssh-autologout/4679.html


## 更改密码
```bash
$  passwd
```


## 查看大文本
```bash
$  more filename
```

## 查看系统版本
```bash
$ more /proc/version
Linux version 3.10.0-514.26.2.el7.x86_64 (builder@kbuilder.dev.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Jul 4 15:04:05 UTC 2017

$ more /etc/redhat-release
CentOS Linux release 7.2.1511 (Core)

$ uname -a
Linux izbp1hsmr9thgc19em3gl8z 3.10.0-514.26.2.el7.x86_64 #1 SMP Tue Jul 4 15:04:05 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

```


## 配置路由
```bash
$ wget http://mirrors.163.com/centos/7/os/x86_64/Packages/iptables-1.4.21-33.el7.x86_64.rpm

$ vim /etc/sysconfig/iptables-config

$ systemctl restart iptables

```



