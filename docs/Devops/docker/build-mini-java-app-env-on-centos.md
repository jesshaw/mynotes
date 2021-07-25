---
title: 如何在CentOS上搭建迷你版的java应用
tags: linux,CentOS,java,jvm
categories: 
  - linux

thumbnail: /gallery/blue-water8.jpg
---

开发好一个基本spring-boot和nodejs应用后，如何使用最少的工具在纯净版的CentOS上搭建运行环境。本文提供了一个可行的方案。

<!-- more -->
## 运行环境需求

* 后端运行环境 JRE 
* 数据库 mysql 

## 实施过程

### 安装Java 8 JRE 

1 选择Oracle的JDK主要是为了保证开发和生产一致性。当然视情况也可以选择OpenJRE。

``` bash
cd ~
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jre-8u162-linux-i586.rpm"

sudo yum localinstall jre-8u162-linux-i586.rpm

rm ~/jre-8u162-linux-i586.rpm
```

2 接下来设置环境变量

``` bash
--针对当前用户
export JAVA_HOME=/usr/java/jdk1.8.0_60/jre
--针对所有用户
sudo sh -c "echo export JAVA_HOME=/usr/java/jdk1.8.0_60/jre >> /etc/environment"
--显示设置的环境变量
echo $JAVA_HOME
```

3 卸载安装包

``` bash
--列出所安装的jre
yum list | grep jre
--执行卸载
yum remove jre1.8
```

[ref](https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora)

### 安装mysql

下载并添加仓库，然后更新

``` bash
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update
```

安装mysql并启动服务

``` bash
sudo yum install mysql-server
sudo systemctl start mysqld
```
[ref](https://linode.com/docs/databases/mysql/how-to-install-mysql-on-centos-7/)

## 延伸阅读

以下为实现自动化，可能需要安装的工具。

### 安装git

以管理员方式，使用yum安装

``` bash
sudo yum install git-all
```

[ref](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### 安装nodejs

##### 方法一 安装多版本nodejs

1 获取脚本并执行 
``` bash
curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
```
2 刷新资源 
``` bash
source ~/.bash_profile
```

3 查看远程版本后选择安装
``` bash
nvm --查看帮助
nvm ls-remote
nvm install v8.9.4
nvm use v8.9.4
 ```

4 验证安装

``` bash
node -v
npm version
```
[ref](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-a-centos-7-server)

##### 方法二 通过下载二进制安装nodejs

1 下载 

``` bash
wget https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x86.tar.xz
``` 

2 解压到指定目录 

``` bash
 sudo mkdir /usr/lib/nodejs
 sudo tar -xJvf node-v8.9.4-linux-x64.tar.xz -C /usr/lib/nodejs 
 sudo mv /usr/lib/nodejs/node-v8.9.4-linux-x64 /usr/lib/nodejs/node-v8.9.4
 ```

3 设置环境变量 `~/.profile`

``` bash
# Nodejs
export NODEJS_HOME=/usr/lib/nodejs/node-v8.9.4
export PATH=$NODEJS_HOME/bin:$PATH 
```

4 刷新profile

``` bash
. ~/.profile
```

5 验证安装

``` bash
node -v
npm version
```

[ref](https://github.com/nodejs/help/wiki/Installation)








