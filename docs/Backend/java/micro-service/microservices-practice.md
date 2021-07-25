---
title: 微服务实践
tags: microservice,微服务.
categories: 
  - java

thumbnail: /gallery/blue-water4.jpg
---
长期在大公司呆，通常是对某一领域的技术接触较多。对于整个技术运营的把握有限，结合已有成熟经验快速搭建一个多应用的微服务系统，算是对自己的一个总结。本文逐步实现微服务实现细节
<!-- more -->

## 前置条件和相关技术

linux

docker, docker-compose

git 

java

js, react, nodejs


## 物理架构
1 台服务注册机
1 台站点网关
1 台微服务应有


## 逻辑架构

   |--register 8761
   |--reservation gateway 18080
   |--info service 18081

### 快速创建微服务应用

docker参考官网安装
docker-compose安装慢采用国内镜像安装
git参考官网安装


### 使用docker建自定义私有镜像

因未使用tls认证方式，因此使用简单验证（正式环境不推荐)，使用以下命令生成用户名和密码

```bash
docker run --entrypoint htpasswd registry:2 -Bbn testuser testpassword > ./docker-registry/auth/htpasswd
```

在客户端设置允许远程访问,liux下增加如下配置到daemon.json文件中。
```bash
{
  "insecure-registries" : ["49.235.132.153:5000"]
}
```
然后重启docker让daemon生效
```bash
systemctl restart docker
```
docker-compose文件如下
```bash
version: '2'
services:
  registry:
    restart: always
    image: registry:2
    ports:
      - 5000:5000
    environment:
      #  REGISTRY_HTTP_TLS_CERTIFICATE: file:./docker-registry/certs/domain.crt
      #  REGISTRY_HTTP_TLS_KEY: file:./docker-registry/certs/domain.key
      REGISTRY_AUTH: htpasswd
      REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd # generate by hash: docker run --entrypoint htpasswd registry:2 -Bbn testuser testpassword > ./docker-registry/auth/htpasswd
      REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
    volumes:
      - ./docker-registry/data:/var/lib/registry
      - ./docker-registry/certs:/certs
      - ./docker-registry/auth:/auth
```

### 部署微服务注册站 register

docker-compose -f reservation/src/main/docker/jhipster-registry.yml up -d



### 部署应用网官 reservation gateway

#### 编译打包生成镜像image，推荐送到服务器

1. 先配置好npm和yarn的下载地址到国内镜像用以提高下载速度

```bash
<plugin>
    <groupId>com.github.eirslett</groupId>
    <artifactId>frontend-maven-plugin</artifactId>
    <executions>
        <execution>
            <id>install node and yarn</id>
            <goals>
                <goal>install-node-and-yarn</goal>
            </goals>
            <configuration>
                <nodeVersion>${node.version}</nodeVersion>
                <yarnVersion>${yarn.version}</yarnVersion>
                <nodeDownloadRoot>https://npm.taobao.org/mirrors/node/</nodeDownloadRoot>
                <yarnDownloadRoot>https://npm.taobao.org/mirrors/yarn/</yarnDownloadRoot>
            </configuration>
        </execution>
    </executions>
</plugin>
```

2. 配置好推送路径
```bash
 <plugin>
    <groupId>com.google.cloud.tools</groupId>
    <artifactId>jib-maven-plugin</artifactId>
    <version>${jib-maven-plugin.version}</version>
    <configuration>
        <from>
            <image>adoptopenjdk:11-jre-hotspot</image>
        </from>
        <to>
            <image>49.235.132.153:5000/lxm/reservation:latest</image>
        </to>
    </configuration>
</plugin>
```

3. 编译打包生成镜像image
```bash
 ./mvnw package -Pprod verify jib:dockerBuild

 ./mvnw package -Pprod -DskipTests verify jib:dockerBuild

 ```

 若出现授权无法安装node或yarn的问题，删除maven对应的下载安装包重试。

 4. 登录私有库并推送

```bash
docker login -u testuser -p testpassword 49.235.132.153:5000

docker push 49.235.132.153:5000/lxm/reservation:latest
 ```

5. 登录远程服务器拉出镜像
```bash
docker login -u testuser -p testpassword localhost:5000

curl -u testuser:testpassword http://49.235.132.153:5000/v2/_catalog

docker pull 49.235.132.153:5000/lxm/reservation

dcoker tags source:latest target:latest

 docker container stats $(docker container ps --format={{.Names}})
 ```


 ### 
docker-compose -f reservation/src/main/docker/jhipster-registry.yml up -d


  background: url("../../../content/images/logo-jhipster.png") no-repeat center;




