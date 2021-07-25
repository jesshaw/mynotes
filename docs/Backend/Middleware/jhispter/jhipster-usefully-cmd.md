---
title: jhipster注意事项
tags: jhipster
categories: 
  - java
  - jhipster

thumbnail: /gallery/blue-water1.jpg
---
jhipster注意事项
<!-- more -->

## [分享前后端](https://jhipster-china.github.io/separating-front-end-and-api/)


## [使用Swagger2Markup产生静态文档](https://jhipster-china.github.io/tips/008_tips_static_swagger_docs.html)

./mvnw test swagger2markup:convertSwagger2markup install


## jdl定义格举类型增加注释无法生成实体json

## jdl实体定义最好不定义枚举类型

## 产生jhipster模型json

jhipster import-jdl ./src/model/member.jdl --json-only

## 仅创建后端实体相关

jhipster entity UserExt --skip-client

## 生成查询条件语句
1. filter [entity name]

2. jhipster import-jdl ./model.jdl --json-only

3. 确认.jhipster中的对应的实体json中有"jpaMetamodelFiltering": true

4. jhipster entity UserExt --skip-client

## 添加字段修改字段升级
1. 先生成实体对象。
2. revert回滚掉自动生成的升级字段。
3. 使用 ./mvnw clean compile liquibase:diff用 mvn clean compile liquibase:diff也行
4. 把生成的***changelog.xml添加到master.xml。
5. 运行 ./mvnw 即完成升级。


## jhipster的docker应用映射目录时的权限问题
基本思路：宿主机目录映射到docker目录时，用户和用户组保持一致，以docker目录为准
执行步骤
1. 进行对应的容器
```bash
docker exec -it containId /bin/sh
2. 查看docker映射目录的用户
```bash
ls -l upload-dir

drwxr-xr-x    3 jhipster jhipster      4096 May 31 06:01 upload-dir
```
3. 查看jhipster对就原passwd与group的id

```bash
cat /etc/passwd # 查看用户

jhipster:x:1000:1000:Linux User,,,:/home/jhipster:/bin/sh

cat /etc/group # 查看用户组长

jhipster:x:1000:

```

4. 递归修改宿主机的用户和组的拥者
```bash
chown -R 1000:1000 upload-dir  # 查看用户组长
```



[DooD](http://container-solutions.com/running-docker-in-jenkins-in-docker/)
[libltdl7问题](https://www.cnblogs.com/leolztang/p/6934694.html)