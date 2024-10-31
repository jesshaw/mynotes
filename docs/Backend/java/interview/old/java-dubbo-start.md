---
title: 快速搭建基于dubbo的微服务
tags: java,dubbo
categories: 
  - java
  - duboo

thumbnail: /gallery/green-water1.jpg
---
一直以来对微服务的使用大多是基于应用层面，较少全局搭建实践，有时候全面了解可能会带来意想不到的收获。
<!-- more -->

阅读完dubbo文档之后，一个完整的dubbo微服务应当包括：一个注册中心，一个监控中心，一个提供服务方和一个消费端

## 1. 注册中心和监控搭建

新建一个docker-componse文件

docker-componse -f app.yml up -d

```
version: '3'

services:
  zookeeper:
    image: zookeeper
    ports:
      - 2181:2181
  admin:
    image: apache/dubbo-admin
    depends_on:
      - zookeeper
    ports:
      - 8080
    environment:
      - admin.registry.address=zookeeper://zookeeper:2181
      - admin.config-center=zookeeper://zookeeper:2181
      - admin.metadata-report.address=zookeeper://zookeeper:2181
```

## 2.创建一个服务提供方
拉取dubbo-registry-zookeeper-samples，启动

```java
@Service(version = "${demo.service.version}")
public class DefaultDemoService implements DemoService {

    /**
     * The default value of ${dubbo.application.name} is ${spring.application.name}
     */
    @Value("${dubbo.application.name}")
    private String serviceName;

    @Override
    public String sayHello(String name) {
        return String.format("[%s] : Hello, %s", serviceName, name);
    }
}

@EnableAutoConfiguration
public class DubboRegistryZooKeeperProviderBootstrap {

    public static void main(String[] args) {
        new SpringApplicationBuilder(DubboRegistryZooKeeperProviderBootstrap.class)
                .listeners((ApplicationListener<ApplicationEnvironmentPreparedEvent>) event -> {
                    Environment environment = event.getEnvironment();
                    int port = environment.getProperty("embedded.zookeeper.port", int.class);
                    new EmbeddedZooKeeper(port, false).start();
                })
                .run(args);
    }
}
```

## 3.创建一个消费方
启动
```java
@Service(version = "${demo.service.version}")
public class DefaultDemoService implements DemoService {

    /**
     * The default value of ${dubbo.application.name} is ${spring.application.name}
     */
    @Value("${dubbo.application.name}")
    private String serviceName;

    @Override
    public String sayHello(String name) {
        return String.format("[%s] : Hello, %s", serviceName, name);
    }
}
```

## 4. 到监控dubbo-admin中即可以看到是否注册和调用成功

## 引用
1. [dubbo-admin](https://github.com/apache/dubbo-admin)
2. [dubbo-registry-zookeeper-samples](https://github.com/apache/dubbo-spring-boot-project/tree/master/dubbo-spring-boot-samples/dubbo-registry-zookeeper-samples)