---
title: maven常用命令
tags: maven,mvn,maven命令
categories: 
  - java

thumbnail: /gallery/blue-water9.jpg
---

收集平时常用的一些maven命令。
<!-- more -->

## 清除现有jar包

```mvn
mvn clear
```

## 查看依赖关系

maven存在a->b->c和e->f->c，但此时c的版本不一致时，就需要查看依赖关系。

```mvn
mvn dependency:tree -Dverbose -Dincludes=DESIRED-groupId:DESIRED-artifactId

mvn dependency:tree -Dverbose -Dincludes=javax.servlet:javax.servlet-api
```




