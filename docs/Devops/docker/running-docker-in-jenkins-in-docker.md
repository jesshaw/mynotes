---
title: 在docker中的jenkins如何运行兄弟docker
tags: docker, jenkins
categories: 
  - docker

thumbnail: /gallery/blue-water1.jpg
---
容器间的通信
<!-- more -->

docker不可避免的会跟CD和CI联系上，当使用docker搭建jenkins时。因为docker容器一般是独立部署，会把打包好的数据，在兄弟容器启动。本文讲述如何在jenkins容器中跟兄弟容器通信，从而实现一键发布的功能。其关键就是docker sock的映射实现容器间的通信。

## 通过Dockerfile创建一个jenkins镜像

```bash
FROM jenkins:2.60.3

USER root
RUN apt-get update \
      && apt-get install -y sudo libltdl7 \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
 
USER jenkins
COPY plugins.txt  /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
```

把jenkins添加到sudoer用户组，给其制制授权避免jenkins用户执行不了docker的问题


## 不需要以下插件，可以到jenkins站点直接安装

新建plugins.txt，增加需要的插件
```bash
$ cat plugins.txt
scm-api:latest
git-client:latest
git:latest
greenballs:latest
maven-plugin:latest
```

## 接下来构建镜像并运行容器，并映射Docker socket和binary。

```bash
$ docker build -t myjenkins .

$ docker run -d --name tm_jenkins \
				-v /var/run/docker.sock:/var/run/docker.sock \
                -v $(which docker):/usr/bin/docker \
                -v /home/jenkins_home:/var/jenkins_home \
                -p 8080:8080 \
                -p 50000:50000  myjenkins

```

这样jenkins就启动了，然后不需要安装其他任何插件。

### 查看日志
docker logs [containerId]
docker container logs myjenkins
### 将工作区存储在以下目录，因此首先要给目录授权
chmod 777 /home/osboxes/jenkins_home/


### jenkins 的问题

Failed to connect to repository : Command "git ls-remote -h 地址 HEAD" returned status code 128:
stdout: 
stderr: Host key verification failed. 
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

解决必须使用docker容器中的ssh key的方式解决

### docker-compose 需要自行到docker容器安装

### docker-compose up 之前先清理以前创建的镜像，否则进而面的数据文件不会有变化
docker-compose down --rmi local 清量自定生成的image文件


## 按以下步骤创建一个项目

* 在浏览器中打开Jenkins并创建一个新的项目。 Open the Jenkins home page in a browser and click the “create new jobs” link.
* 选择 “Freestyle project” ，输了一个名为“docker-test”的名称，保存。
* 在配置页上点击“Add build step” 添加 “Execute shell”。
* 在命令中输入 “sudo docker run hello-world”。
* 保存并立即构建。

运行成功则说明容器间通信成功。



##### 启动docker的jenkins时给jenkins授权,1000:1000为jenkins用户和用户组
```bash
sudo chown -R 1000:1000 /home/docker/jenkins
```


[DooD](http://container-solutions.com/running-docker-in-jenkins-in-docker/)
[libltdl7问题](https://www.cnblogs.com/leolztang/p/6934694.html)