# SkyWalking

## 概念

Skywalking是适用于分布式系统的应用程序性能监视的工具，专为微服务、云原生架构和基于容器（Docker、K8s、Mesos）架构而设计[^1]。

SkyWalking 是一个可观察性分析平台和应用程序性能管理系统。 跟踪、指标和记录一体化解决方案。

支持 Java、.Net Core、PHP、NodeJS、Golang、LUA、C++、Python 代理

支持 Istio + Envoy 服务网格

## 核心功能

- 服务、服务实例、端点指标分析
- 根本原因分析。在运行时分析代码
- 服务拓扑图分析
- 服务、服务实例和端点依赖分析
- 缓慢的服务和端点检测
- 性能优化
- 分布式跟踪和上下文传播
- 数据库访问指标。检测慢速数据库访问语句（包括SQL语句）
- 消息队列性能和消耗延迟监控
- 警报
- 浏览器性能监控
- 基础设施（VM、网络、磁盘等）监控
- 跨指标、跟踪和日志的协作

## 支持多种来源和多种格式的数据收集（metrics, traces和logs）

- Java、.NET Core、NodeJS、PHP 和 Python 自动检测代理。
- Go 和 C++ SDK。
- LUA 代理，特别适用于 Nginx、OpenResty 和 Apache APISIX。
- 浏览器代理。
- 服务网格可观察性。控制面板和数据面板。
- 度量系统，包括 Prometheus、OpenTelemetry、Spring Sleuth(Micrometer)、Zabbix。
- 日志。
- Zipkin v1/v2 跟踪。（无分析）

## 整体架构[^2]

![SkyWalking架构图](assets/skywaking-arch.png)

Tracing部分做应用代理把信息通过Transport Layer推送到Receiver Cluster（即OAP）Aggregator Cluster完全成计算存储到Sotrage Options中。

GUI/CLI通过Receiver Cluster（SkyWaking UI）查看应用系统健康状态。

Sotrage Options选项有很多：ES、MySQL、Sharding Sphere、TiDB、H2

## 参考

[官方英文文档](https://github.com/apache/skywalking/tree/master/docs) 

[官方中文文档](https://github.com/SkyAPM/document-cn-translation-of-skywalking)

[《OpenTracing 官方标准 —— 中文版》](https://github.com/opentracing-contrib/opentracing-specification-zh)

Google 论文 [《Dapper，大规模分布式系统的跟踪系统》](https://bigbully.github.io/Dapper-translation/)

[SkyWalking 极简入门](https://skywalking.apache.org/zh/2020-04-19-skywalking-quick-start/)

[ik中文分词器](https://cloud.tencent.com/developer/article/1817667)

[SkyWalking Demo](http://demo.skywalking.apache.org/)

[SkyWalking指标相关](https://www.jianshu.com/p/055e4223d054)

[^1]: [SkyWalking官网](http://skywalking.apache.org/)
[^2]: [SkyWalking github](https://github.com/apache/skywalking)
