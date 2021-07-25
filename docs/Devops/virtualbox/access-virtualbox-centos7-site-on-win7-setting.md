---
title: 在win7中访问VirtualBox中的CentOS站点
tags: linux,CentOS,VirtualBox,win7
categories: 
  - linux

thumbnail: /gallery/blue-water9.jpg
---

在VirtualBox中建好CentOS站点应用后，首先要做的是看是否能够正常访问。以下描述了具体的实施过程。

<!-- more -->
## 目标

* 可通过http正常访问CentOS的站点 

## 实施步骤

#### 1. 确保可以访问外网

按如下配置完成后，可自动实现虚机访问外网的功能

设置->网络->选网络地下转换(NAT)->..->确定

启动虚机后检验
``` bash
ping lexiangmiao.com
```

### 2. 主机访问虚机

按如下配置完成后，可自动实现虚机访问主机的功能
设置->网络->仅主机(Host-Only)网络->..->确定

启动虚机后检验
``` bash
ping 192.168.56.1
# 查看网卡和虚机地址
ip address
```

### 3. 永久开放端口

``` bash
sudo firewall-cmd --zone=public --add-port=5121/tcp --permanent
# --zone 作用域
# --add-port=5121/tcp 添加端口，格式为：端口/通讯协议
# --permanent 永久生效，没有此参数重启后失效

sudo firewall-cmd --reload


# 检查新的防火墙规则
firewall-cmd --list-all
```

防火墙开关

``` bash
# 临时关闭防火墙
systemctl stop firewalld

# 永久关闭防火墙，开机自启动
systemctl disable firewalld

# 临时打开防火墙
systemctl start firewalld

# 永久打开防火墙，开机启动
systemctl enable firewalld

# 查看防火墙状态
systemctl status firewalld

```





