---
title: maven中重复类冲突解决办法
tags: maven,mvn,maven命令
categories: 
  - java

thumbnail: /gallery/blue-water10.jpg
---

maven引入其他jar的时候常会碰到重得类冲突，一般解决思路是查看依赖关系，排出不需要的jar或类。
<!-- more -->

## 解决步骤如下
1. 哪两个jar包出现重复类了。
2. 两个jar是依赖哪个组件引入的。
3. 通过mvn命令查找依赖关系。 

```mvn
mvn dependency:tree -Dverbose -Dincludes=DESIRED-groupId:DESIRED-artifactId

mvn dependency:tree -Dverbose -Dincludes=javax.servlet:javax.servlet-api

```

## 解决办法有以下3种：
* 两个jar包报重复类，如果其中有个jar包是不需要的，则可以通过<exclusions>的方式把它从依赖树中排除，这样重复类问题就被解决了。
* 如果两个jar包都是需要的，此时需要改造其中一个jar包，消除重复类问题（比如改变类名或者改变package）。如果是第三方组件测修改版本号。
* 还有一类，是不得以而为之的（不推荐），就是重复类的问题很难解决&&评估下来没必要解决，可通过添加白名单的方式略过重复类问题。



