# skywalking 部署

## 目标

Docker版本部署，适用于中小型应用。若K8s部署请查阅[^1]

## 选型比较[^2]

| 维度 | Cat | Zipkin | PinPoint | Skywalking |
| --- |  --- |  --- |  --- |  --- |
| 实现方式 | 代码埋点（拦截器，注解，过滤器等） | 拦截请求，发送（HTTP，MQ）数据至Zipkin服务 | Java探针，字节码增强 | Java探针，字节码增强 |
| 接入方式 | 代码侵入 | 基于Linkerd或者Sleuth方式，引入配置即可 | JavaAgent字节码，高并发情况下，代理对吞吐量的影响比skywalking和zipkin都大 | JavaAgent字节码，支持20+的中间件、框架、类库 |
| agent到collector的协议 | http/tcp | http,MQ | thrift | gRPC |
| 可扩展性 | 水平扩展服务端 | 多个zipkin-Server实例进行异步消费mq中的监控信息 | collector+web+agent+存储，使得能够水平扩展以便支持大规模服务器集群。 | OAP（skywalking6.x才有OAP这个概念，skywalking5.x叫collector）+Web+agent+存储+zk，使得能够水平扩展以便支持大规模服务器集群。 |
| 数据存储 | Mysql,Hdfs | ES，mysql,Cassandra | Hbase(RowKey精确查找，SCAN范围查找，全表扫描),Mysql | ES，H2，Mysql，TiDB，Sharding-Sphere |
| 分析粒度 | 代码级，全局调用统计，报警，JVM监控 | 接口级，支持traceid查询 | 方法级，全局调用统计、报警 | 方法级，全局调用统计、traceid查询，报警，JVM监控 |
| 调用链可视化 | 有 | 有 | 有 | 有 |
| 报表 | 丰富 | 少 | 中 | 中 |
| 调用链应用拓扑 | 简单，仅限于服务与服务之间 | 简单，仅限于服务与服务之间 | 好 | 好 |
| 埋点方式 | 侵入 | 侵入 | 无侵入 | 无侵入 |
| Heartbeat支持 | 有 | 无 | 有 | 有 |
| Metric支持 | 有 | 无 | 无 | 有 |
| 是否支持webflux | 否 | 是 | 是 | 是 |
| 客户端支持 | Java、C/C++、Node.js、Python | java | Java,php | Java, C#, PHP, Node.js, Go |
| 中文支持 | 好 | 无 | 无 | 好 |
| 社区支持 | 好 | 好 | 一般 | 好 |
| 国内案例 | 美团、携程、陆金所等等 | 京东，阿里定制后不开源 | 暂无 | 阿里，小米，滴滴，华为、当当等等 |
| 社区活跃度（截止2021-10） | 16k | 14.8k | 11.8k | 18k |
| 社区活跃度（截止2020-2） | 12.7k | 12.5k | 9.9k | 12.3k |
| 社区活跃度（截止2020-22） | 12.7k | 12.5k | 9.9k | 12.3k |
| 社区活跃度（截止2019-12 | 12.3K | 12.2K |  | 11.8K |
| 社区活跃度（截止2018-5） | 4.9k | 8.4k | 5.9k | 3.3k |

### 埋点数据传输性及性能比较

https://zhuanlan.zhihu.com/p/60436915

综合考虑现有项目情况和资源状况选用SkyWalking合适。

## 版本选择

选择8.7.0 [^3]

原因：之前的版本没这个版本完善，之后的版本目前agent包还没有好（如8.8.1）。

## 部署步骤

基于[SkyWalking架构](./skywalking.md)相关知识，若选用ElasticSearch作为存储库，至少需要启用4个docker容器。分别为

- ElastichSearch
- SkyWalking OAP Server
- SkyWalking UI
- Java Agent容器

### 基础镜像拉取

[SkyWalking UI镜像](https://hub.docker.com/r/apache/skywalking-ui)
[SkyWalking OAP Server镜像](https://hub.docker.com/r/apache/skywalking-oap-server)
[Elastic Search](https://hub.docker.com/_/elasticsearch)
[SkyWalking Java Agent镜像](https://hub.docker.com/r/apache/skywalking-java-agent)

```bash
docker pull apache/skywalking-oap-server:8.7.0-es7
docker pull apache/skywalking-ui:8.7.0
docker pull elasticsearch:7.5.1
```

### 依赖和数据流向

依赖关系为 **SkyWalking UI -> SkyWalking OAP Server -> ElastichSearch**

数据收集方向为: **Java Agent容器 -> SkyWalking OAP Server -> ElastichSearch**

因先搭建顺序：**ElastichSearch -> SkyWalking OAP Server -> SkyWalking UI或Java Agent容器**

### 网络选择

因为是Docker Compose方式拉起，所以须要指定网络模式为bridge(Docker Compose若不指定，默认会创建以服务名前缀的bridge网络)。当然使用其他方式也可以但必须得保证监控相关后台在同一网段。

### 部署ElastichSearch

ElastichSearch配置yml如下：

```yml
version: '3'
services:
  elasticsearch:
    network_mode: bridge
    image: elasticsearch:7.5.1
    container_name: es7
    hostname: node-es-1
    volumes:
      - ${PWD}/es/data:/usr/share/elasticsearch/data
      - ${PWD}/es/logs:/usr/share/elasticsearch/logs
    ports:
      - "9200:9200"
      - "9300:9300"
    environment:
      - TZ=Asia/Shanghai
      - discovery.type=single-node
```

拉起

```bash
docker-compose up -d
```

### 部署SkyWalking OAP Server及SkyWalking UI

SkyWalking OAP及SkyWalking UIyml文件如下:

```yml
version: '3'
services:
  skywalking-oap-server:
    network_mode: bridge
    image: apache/skywalking-oap-server:8.7.0-es7
    container_name: oap
    ports:
      - "12800:12800"
      - "11800:11800"
    environment:
      - TZ=Asia/Shanghai
      - SW_STORAGE=elasticsearch7
      - SW_STORAGE_ES_CLUSTER_NODES=es7:9200
    external_links:
      - es7
  skywalking-ui:
    network_mode: bridge
    image: apache/skywalking-ui:8.7.0
    container_name: skywalking-ui
    ports:
      - "8088:8080"
    environment:
      - TZ=Asia/Shanghai
      - SW_OAP_ADDRESS=http://oap:12800
    depends_on:
      - skywalking-oap-server
    external_links:
      - oap
```

**注意：**

若不指定`SW_STORAGE=elasticsearch7`则默认会使用H2内存数据库，不支持全文搜索，也不利于持久化

拉起

```bash
docker-compose up -d
```

#### 验证是否成功

打开http://localhost:8088能正常打开说明UI启动功能

打开http://localhost:9200/_cat/indices若看到以sw开头的索引则说明OAP能正常写入数据到ElasticSearch

或直接命令项方式验证

```bash
curl http://localhost:9200/_cat/indices
yellow open sw_network_address_alias-20211022                 6ssMoaO_Tj6NK51A5WbzQA 1 1     12   1921 120.6kb 120.6kb
yellow open sw_profile_task_log-20211022                      hybdB44_Rk6t-7ewA60Grw 1 1      0      0    208b    208b
```

至此应用监控服务端搭建完成

### 部署Java Agent客户端

Java Agent 8.7.0代理搭建与6.6.0[^4]原理相似，但又有细微不同。完全整的配置参考可以查阅官网文档[^5]

Java Agent有如下三种方式：

- 使用官方提供的基础镜像
- agent包构建到基础镜像，通过指定环境变量来运行
- 按需挂载（类似k8s的sidecar模式）

选用方式三，更方便灵活选择插件、适配现有应用。

#### 创建一个简单的SpringBoot项目

参考或直接拉取 https://github.com/jesshaw/java-sample/docker-deploy 创建一个SpringBoot项目。

#### 获取agent包

```bash
wget https://archive.apache.org/dist/skywalking/8.7.0/apache-skywalking-apm-es7-8.7.0.tar.gz
tar -xvzf apache-skywalking-apm-es7-8.7.0.tar.gz
tree apache-skywalking-apm-bin-es7 -L 1
apache-skywalking-apm-bin-es7/
├── LICENSE
├── NOTICE
├── README.txt
├── agent
├── bin
├── config
├── config-examples
├── licenses
├── oap-libs
├── tools
└── webapp
```

为了镜像更为仅保留agent目录即可，由于我们使用了Spring Cloud Gateway网关，所以要复制agent/optional-plugins相关插件。 插件的选用上可以参考skywalking-java源码[^6]来决定

```bash
cd agent/optional-plugin/

ls
apm-spring-cloud-gateway-2.1.x-plugin-8.7.0.jar
apm-spring-webflux-5.x-plugin-8.7.0.jar
apm-spring-annotation-plugin-8.7.0.jar

cp 以上三文件.jar ../plugins/
```

建议自定义Dockerfile打包镜像

```Dockerfile
FROM openjdk:8-jre-alpine
WORKDIR /opt
cp  ${PWD}/target/*.jar app.jar
cp -r  ${PWD}/apache-skywalking-apm-bin-es7/agent .
```

```bash
docker build -t  test/dockerdeploy .
```

#### 启动客户端

```yml
version: "3"
services:
  java-app:
    image: test/dockerdeploy
    container_name: java-app
    ports:
      - "8089:8080"
    environment:
      - TZ="Asia/Shanghai"
    entrypoint: >
      java
      -javaagent:/opt/agent/skywalking-agent.jar
      -Dskywalking.agent.service_name=java-app
      -Dskywalking.collector.backend_service=host.docker.internal:11800
      -Dskywalking.plugin.toolkit.log.grpc.reporter.server_host=host.docker.internal
      -Dskywalking.plugin.toolkit.log.grpc.reporter.server_port=11800
      -Dserver.port=8080
      -jar opt/app.jar
```

**注意：**

skywalking.plugin.toolkit.log.grpc.reporter配置是用于日志同步，skywalking.agent.service_name用于应用注册到OAP（格式为`服务分组名::服务名`）等，因为两个都需要配置。

#### 其他重要配置

[官网参考](https://skywalking.apache.org/docs/skywalking-java/latest/en/setup/service-agent/java-agent/configurations/)
[插件源码结构](https://github.com/apache/skywalking/blob/v6.6.0/docs/en/setup/service-agent/java-agent/README.md)

在agent/config/agent.config中配置

**收集 SQL 参数（默认是 false）**
`plugin.jdbc.trace_sql_parameters=${SW_JDBC_TRACE_SQL_PARAMETERS:true}`
​
**收集 SpringMVC 请求参数（默认是 false）**
`plugin.springmvc.collect_http_params=${SW_PLUGIN_SPRINGMVC_COLLECT_HTTP_PARAMS:true}`
​
**收集 Http 客户端请求参数（默认是 false）**
`plugin.httpclient.collect_http_params=${SW_PLUGIN_HTTPCLIENT_COLLECT_HTTP_PARAMS:true}`
​
**收集 feign 调用的请求 body 参数（默认是 false）**
`plugin.feign.collect_request_body=${SW_PLUGIN_FEIGN_COLLECT_REQUEST_BODY:true}`

**传输格式化（默认为 true）**
plugin.toolkit.log.transmit_formatted=${SW_PLUGIN_TOOLKIT_LOG_TRANSMIT_FORMATTED:false}

当设置false时会把日志提出成多个索引加消息内容的形式

**忽略特定的URL跟踪**
amp-trace-ignore-plugin-8.7.0.jar
[参考配置](https://github.com/apache/skywalking/blob/v6.6.0/docs/en/setup/service-agent/java-agent/agent-optional-plugins/trace-ignore-plugin.md)

选用方式2

复制/agent/optional-plugins/apm-trace-ignore-plugin/apm-trace-ignore-plugin.config 到 /agent/config/
trace.ignore_path=/your/path/1/**,/your/path/2/**

#### 相关指标

[相关指标参考](https://www.itmuch.com/books/skywalking/protocols/#query-protocol)

#### 启动

```bash
docker-compose up -d
```

## 结论

从以上的部署步骤能较快的步骤好链路跟踪，看到服务之间的调用拓扑图。但仅是开始，若要把服务内部的日志串连起来，则需要在日志模块增加相应的tid即跟踪唯一标识，相对来讲会有一些侵入pom.xml和日志配置文件等。所以“全”链路的话还是多多少少有一些侵入性。

[^1]: [K8s部署SkyWalking](https://blog.csdn.net/ryanlll3/article/details/113445632)
[^2]: [全链路监控选型](https://www.jianshu.com/p/07a00d66e703)
[^3]: [Apache SkyWalking APM 8.7.0发布列表](https://skywalking.apache.org/events/release-apache-skywalking-apm-8-7-0/)
[^4]: [SkyWalking 极简入门](https://skywalking.apache.org/zh/2020-04-19-skywalking-quick-start/)
[^5]: [Java Agent 配置参考](https://skywalking.apache.org/docs/skywalking-java/latest/en/setup/service-agent/java-agent/configurations/)
[^6]: [skywalking-java github](https://github.com/apache/skywalking-java)