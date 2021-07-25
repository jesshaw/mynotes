---
title: CentOS下安装Docker
tags: CentOS, docker, install,安装
categories: 
  - docker

thumbnail: /gallery/green-water4.jpg

---
Docker意为搬运工人。负责将开发出来的代码部署到指定的系统环境当中。相对于原始的手动或虚拟机部署，Docker极大的提高了生产效率。

<!-- more -->

## Docker介绍

Docker 是个划时代的开源项目，它彻底释放了计算虚拟化的威力，极大提高了应用的维护效率，降低了云计算应用开发的成本！使用 Docker，可以让应用的部署、测试和分发都变得前所未有的高效和轻松！

无论是应用开发者、运维人员、还是其他信息技术从业人员，都有必要认识和掌握 Docker，用以提高生产效率，节约有限的生命。

## Docker基本概念

镜像（Image）和容器（Container）的关系，就像是面向对象程序设计中的 类 和 实例 一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。

### 镜像（Image）

Docker 镜像是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）。镜像不包含任何动态数据，其内容在构建之后也不会被改变。

### 容器（Container）

容器的实质是进程，但与直接在宿主执行的进程不同，容器进程运行于属于自己的独立的 命名空间。因此容器可以拥有自己的 root 文件系统、自己的网络配置、自己的进程空间，甚至自己的用户 ID 空间。容器内的进程是运行在一个隔离的环境里，使用起来，就好像是在一个独立于宿主的系统下操作一样。这种特性使得容器封装的应用比直接在宿主运行更加安全。

### 仓库（Repository）

镜像构建完成后，可以很容易的在当前宿主机上运行，但是，如果需要在其它服务器上使用这个镜像，我们就需要一个集中的存储、分发镜像的服务，Docker Registry 就是这样的服务。

一个 Docker Registry 中可以包含多个仓库（Repository）；每个仓库可以包含多个标签（Tag）；每个标签对应一个镜像。



## Docker安装

### 注意事项
1. Docker有两个版本，分别是社区版本：Community Edition (CE)和企业版本：Enterprise Edition (EE)。一般使用CE版。
2. CE版本仅支持64位系统。
3. Docker安装方式有很多种，因为线路原因，综合考虑使用从安装包安装的方式。

### 步骤

1 下载stable版本的包 

到https://download.docker.com/linux/centos/7/x86_64/stable/Packages/ 下载需要装的版本
```bash
wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/package.rpm
```

注意: 如要下载edge包，则需要改变路径。stable版每季度发版一次，提供4个月的支持。
edge版每月发版一次，仅当月提供支持。

2 安装Docker CE  

```bash
$ sudo yum install /path/to/package.rpm
```

3 启动

```bash
$ sudo systemctl start docker
```

4 验证

通过运行hell-world镜像，验证是否安装正确。

```bash
$ sudo docker run hello-world
```

## Docker国内镜像配置

由于种种原因，下载镜像会很慢，配置国内镜像是明智选择。

1 停止docker

```bash
sudo systemctl stop docker
```

2 配置镜像

创建或修改daemon.json
```bash
sudo touch /etc/docker/daemon.json
```

在daemon.json中增加以下配置
```json
{
<<<<<<< HEAD
"registry-mirrors": ["https://docker.mirrors.ustc.edu.cn", "http://hub-mirror.c.163.com"],
=======
"registry-mirrors": ["https://docker.mirrors.ustc.edu.cn", "http://hub-mirror.c.163.com","https://registry.docker-cn.com"],
>>>>>>> master_bak
"max-concurrent-downloads": 10
}
```

3 启动docker

```bash
sudo systemctl start docker
```




## 引用
1. [在centos中，从安装包安装Docker](https://docs.docker.com/install/linux/docker-ce/centos/#upgrade-docker-ce)
2. [Docker最佳实践](https://docker_practice.gitee.io/introduction/what.html)
