---
title: 如何快速搭建linux运行环境
tags: linux,VirtualBox,VirtualBox image,CentOS
categories: 
  - linux

thumbnail: /gallery/blue-water7.jpg
---

对于程序员来说，很可能用linux作为服务器运行环境，为了提前发现问题不可避免的需要搭建一套linux运行环境，此文给出一个可行、快速且经济的解决方案。

<!-- more -->
# 目标

* 在VirtualBox中安装好CentOS 7 
* 可实现主机到虚机的双向复制和文件共享


# 方案

## 环境

* win7
* VirtualBox 5.2.6
* CentOS 7 32位镜像


## 实施步骤

### 1 下载VirtualBox
打开[virtualbox官网](https://www.virtualbox.org/wiki/Downloads) ，选择windows hosts下载到本地，安装完成进行到下一步。

### 2 下载Linux镜像

打开[osboxes官网](https://www.osboxes.org/virtualbox-images/) ,打开CentOS链接，找到linux 32bit下载。也可以下载64bit据自身机器情况而定。

### 3 创建虚拟电脑

打开VirtualBox->新建->CentOS->...->使用已有虚拟硬盘->选择已下载的Linux镜像*.vdi文件->..->直至完成。

### 4 系统初始化设置

按提示进行系统设置，最后输入osboxes.org作为用户密码，登入Linux系统即完成搭建。

### 5 安装增强功能

##### 安装

设备->安装增强功能->直至完成。

##### 设置共享剪切板

设备->共享剪切板->双向

##### 设置共享目录

设备->共享文件夹->设置共享目录。

```bash
--挂载
mount -t vboxsf hostDirectoryName virtualDirectoryPath
--解挂
umount virtualDirectoryPath
```
##### 挂载解决办法
问题：/sbin/mount.vboxsf: mounting failed with the error: No such device

执行以下命令

```bash
yum clean all
yum update
yum install kernel
yum install kernel-devel
yum install kernel-headers
yum install gcc
yum install make  
reboot
```

[参考](http://blog.csdn.net/daiyudong2020/article/details/58073520)


## 3  延伸阅读

### 设置系统启动后进入文本界面：

```bash
systemctl set-default multi-user.target
```

### 设置系统启动后进入图形界面：

```bash
systemctl set-default graphical.target
```

### 重启系统：

```bash
systemctl reboot
```

### 以文本界面启动后，执行以下命令启动图形界面：

```bash
startx
```
### 快捷方式

Ctrl + Alt + F2  切换到文本界面
Ctrl + Alt + F1  切换到图形界面
Ctrl + Alt + backspace 重启当前图形界面

[参考](https://www.ifshow.com/centos-7-switching-graphical-and-text-interface/)

### 进入setting设置termial终端打开快捷键为alt+F12

Setthings->Keyboard->add command->Name "Terminal" Command "/usr/bin/gnome-terminal”->Shortcuts->输入alt+F12。





