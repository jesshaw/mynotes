# docker常用命令

## 搜索镜像

```bash
docker search nginx

# 查找镜像的版本

docker image inspect imagename:latest | grep -i version

```

## 拉取镜像

```bash
docker pull
```

## 创建镜像

**-t** 指定镜介名称
**.** 默认当前路径下的Dockerfile文件

```bash
docker build -t jes/imagename .
```

## 列出镜像

```bash
docker images
```

## 镜像重命名tag

```bash
docker image tag --help

docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
```

## 镜像导出

保存镜像到tar文件

```bash
sudo docker save -o <path for generated tar file> <image name>

docker save -o c:/myfile.tar centos:16
```

## 机器互拷文件

```bash
scp -r source target

# 远程拷本地
sudo scp -r root@192.168.1.100:/data/ /home/myfile/


# 本地拷远程
sudo scp -r /home/myfile/ root@192.168.1.100:/data/
```

## 镜像导入

从文件导入成镜像

```bash
sudo docker load -i <path to image tar file>
```

## 保存改动为新的镜像

```bash
docker commit 
```

## 运行容器

**-v** 挂载宿主机的路径到指定容器路径，英文冒号`:`为分隔符
**-p** 宿主机端口映射到docker容器的端口
**-d** 后台运行
**--rm** 容器运行结束后清除
**--it** 进行shell命令
**ls /images** 为进行容器后执行的命令

```bash
docker run -v $PWD/images:/images imagename

# 进入容器后准备执行命令,退出后删除容器
docker run --rm -it -v $PWD/images:/images imagename

# 进入容器后执行ls命令，然后结束运行容器并删除容器
docker run -v $PWD/images:/images --rm -it imagename ls /images

# 后台运行，映射了端口
docker run -p 80:80 -v $PWD/data:/data -d nginx:latest
```

## 进入容器

```bash
docker exec -it [container id] /bin/sh
docker exec -it [container id] bash
```

## 列出容器

```bash
docker ps
docker ps -a
```

## 删除容器

```bash
docker rm
docker rm 1adbdsaf
 
```

## 删除所有已退出的容器

```bash
docker rm `docker ps -a | grep  "Exited" | awk '{print $1}'`
```

## 删除镜像

```bash
docker rmi 1232a
```

## 删除所有none镜像

```bash
docker rmi `docker images | grep  "<none>" | awk '{print $3}'`
```

## 远程调用

有三种方式

unix:///path/to/sock

tcp://host:port

fd://socketfd

```bash
# 通过2375连接到192.168.0.2机器，查看docker的基本信息
docker -H tcp://192.168.0.2:2375 info
```

## docker-compose

-f 默认不指定的文件名为docker-compose.yml，显示指定**必须放在第一个参数**

### docker-compose启动服务

```bash
docker-compose -f docker-compose.yml up -d
```

### docker-compose停止服务

```bash
docker-compose -f docker-compose.yml stop
```

### docker-compose停止并删除服务

```bash
docker-compose -f docker-compose.yml down
```

## 在host和container之间拷贝文件

```bash
docker cp

docker cp <containerId>:/file/path/within/container /host/path/targe

```

## 授权

启动docker的jenkins时给jenkins授权,1000:1000为jenkins用户和用户组

```bash
sudo chown -R 1000:1000 /home/docker/jenkins
```

## 配置客户端访问私有仓库

1. vim /etc/docker/daemon.json 增加以下接点 "insecure-registries" : ["47.100.28.49:5000"]
2. sudo systemctl daemon-reload
3. sudo systemctl restart docker
4. 验证

    docker login -u jes -p jes1@lexiangmiao.com 47.100.28.49:5000

    登录拉取私有镜像库数据，并启动

    ```bash
    docker login -u jes -p jes1@lexiangmiao.com localhost:5000

    docker pull localhost:5000/jesshaw/retail:lastest

    docker-componse -f retail.yml up -d
    ```

    retail.yml

    ```yml
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
    ```

5. shell启用 retail

    ```bash
    cd start-retail
    chmod 777  start.sh
    start.sh

    ```

    start.sh

    ```bash
    #!/bin/sh

    echo "---------------stop contianer----------------------------"
    docker-compose down

    echo "---------------remove contianer----------------------------"
    sudo docker rmi -f  localhost:5000/jesshaw/retail


    echo "---------------login localhost images repsitory--------------"
    sudo docker login -u jes -p jes1@lexiangmiao.com localhost:5000

    echo "---------------pull images----------------------------"
    sudo docker pull localhost:5000/jesshaw/retail

    echo "-----------------start contianer---------------------"
    docker-compose up -d
    ```
