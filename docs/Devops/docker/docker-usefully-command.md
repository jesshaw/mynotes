---
title: docker常用命令
tags: docker,docker命令
categories: 
  - docker

thumbnail: /gallery/blue-water9.jpg
---

收集平时常用的一些docker命令。
<!-- more -->

##### 拉取镜像
```bash
docker pull
```

##### 创建镜像
```bash
docker build
```

##### 列出镜像
```bash
docker images
```

##### 运行容器
```bash
docker run
```

##### 列出容器
```bash
docker ps
docker ps -a
```

##### 删除容器
```bash
docker rm
docker rm 1adbdsaf
 
```

##### 删除所有已出的容器
```bash
docker rmi `docker ps -a | grep  "Exited" | awk '{print $1}'`
```

##### 删除镜像
```bash
docker rmi 1232a
```

##### 删除所有none镜像
```bash
docker rmi `docker images | grep  "<none>" | awk '{print $3}'`
```


##### 在host和container之间拷贝文件
```bash
docker cp

docker cp <containerId>:/file/path/within/container /host/path/targe

```

##### 保存改动为新的镜像
```bash
docker commit 
```

##### 进行docker容器

```bash
docker exec -it [container id] bash
docker exec -it [container id] /bin/sh
```

##### 启动docker的jenkins时给jenkins授权,1000:1000为jenkins用户和用户组

```bash
sudo chown -R 1000:1000 /home/docker/jenkins
```

##### 配置客户端访问私有仓库
1. vim /etc/docker/daemon.json 增加以下接点

"insecure-registries" : ["47.100.28.49:5000"]

2. sudo systemctl daemon-reload

3. sudo systemctl restart docker

4. 验证

docker login -u jes -p jes1@lexiangmiao.com 47.100.28.49:5000

##### 登录拉取私有库数据，并启动

docker login -u jes -p jes1@lexiangmiao.com localhost:5000

docker pull localhost:5000/jesshaw/retail:lastest

docker-componse -f retail.yml up -d



retail.yml

version: '2'
services:
    retail-app:
        image: localhost:5000/jesshaw/retail:latest
        environment:
            - _JAVA_OPTIONS=-Xmx512m -Xms256m
            - SPRING_PROFILES_ACTIVE=prod,swagger
            - SPRING_DATASOURCE_URL=jdbc:mysql://lxm-mysql:3306/retail?useUnicode=true&characterEncoding=utf8&useSSL=false
            - JHIPSTER_SLEEP=10 # gives time for the database to boot before the application
        ports:
            - 8090:8080


5. shell启用 retail

start-retail

start.sh

chmod 777  start.sh

#!/bin/sh

echo "---------------remove images----------------------------"
docker-compose down
echo "---------------remove sucess ---------------------------"

echo "---------------remove images----------------------------"
sudo docker rmi -f  localhost:5000/jesshaw/retail
echo "---------------remove sucess ---------------------------"


echo "---------------login localhost registry--------------"
sudo docker login -u jes -p jes1@lexiangmiao.com localhost:5000
echo "---------------login sucess --------------------------"

echo "---------------pull images----------------------------"
sudo docker pull localhost:5000/jesshaw/retail
echo "---------------pull sucess ---------------------------"

echo "-----------------start api start---------------------"
docker-compose up -d
echo "-----------------start api end---------------------"




