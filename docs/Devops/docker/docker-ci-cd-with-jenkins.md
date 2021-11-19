---
title: Docker下自动化部署解决方案
tags: 
  - docker
  - jenkins
  - maven
---
如今我们可能已习惯部署自动化，如何高效快速搭建部署自动化呢？以下解决方案，经验证可行

<!-- more -->

## 拉取jenkins镜像

```bash
sudo docker pull jenkins:2.60.3
```

## 创建名为myjenkins的容器

```bash
# 将工作区存储在以下目录，因此首先要给目录授权
chmod 777 /home/osboxes/jenkins_home/
# 启动
sudo docker run -d --name myjenkins -p 8080:8080 -p 50000:50000 -v /home/osboxes/jenkins_home:/var/jenkins_home jenkins:2.60.3

sudo docker run -d --name myjenkins -p 8080:8080 -p 50000:50000 -v /home/jenkins_home:/var/jenkins_home jenkins:2.60.3
# 查看日志
docker logs
docker container logs myjenkins
```

## 浏览器中打开jenkins
首次打开需要密码，密码来自动于容器启动时产生的密码。通过docker logs可以查看到。

## 安装maven插件

### 1. 新增一个maven插件版本
按导航方式
Jenkins->Manage Jenkins->Global Tool Configuration找到Maven，选择需要自动安装的Maven版本。

### 2. 安装maven插件
按导航方式
Jenkins->Manage Jenkins->Manage Plugins选择Available，搜索框输入找找到Maven Integration plugin插件安装即可。

### 3. 配置maven镜像，为maven下载加速
找到settings.xml路径

```bash
sudo find / -name 'settings.xml'
```

增加以下xml配置的镜像
```xml
<mirror>
    <id>alimaven</id>
    <mirrorOf>central</mirrorOf>
    <name>aliyun maven</name>
    <url>http://maven.aliyun.com/nexus/content/groups/public</url>
</mirror>
```

## 增加maven持续集成项目

按导航方式Jenkins->New Item，创建一个测试的maven项目。

从https://github.com/spring-guides/gs-spring-boot.git 上使用git克隆获取示例项目

配置pom.xml相对路径complete/pom.xml

## 引用
1. [jenkins容器](https://hub.docker.com/_/jenkins/)
2. [docker最佳实践](https://docker_practice.gitee.io/container/daemon.html)
3. [docker下的Jenkins安装和体验](https://blog.csdn.net/boling_cavalry/article/details/78942408)
