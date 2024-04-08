# 阿里K8s

## 如何开通

1. 创建专有网络
2. 创建交换机

### 创建专有网络

虚拟私有云（Virtual Private Cloud）是用户在云上申请的隔离的、私密的虚拟网络环境。用户可以基于VPC构建独立的云上网络空间，配合弹性公网IP、云连接、云专线等服务实现与Internet、云内私网、跨云私网互通，帮您打造可靠、稳定、高效的专属云上网络

VPC网段选择，推荐192.168.0.0/16。 建议您不要选择10.0.0.0/8作为VPC的网段，因为经典网络的网段也是10.0.0.0/8。

### 创建交换机

**交换机的网段必须是其所属VPC网段的子集**。例如VPC的网段是192.168.0.0/16，那么该VPC下的交换机的网段可以是192.168.0.0/17，一直到192.168.0.0/29。

## k8s部署所需要的资源列表

消息队列 RocketMQ 版
全站加速
HybridDB for PostgreSQL
CDN
弹性容器实例 ECI
日志服务
媒体处理
表格存储
云服务器ECS-快照
链路追踪
微服务治理按量付费
数据库备份DBS（按量付费）
应用型负载均衡(按量付费)
Prometheus
Redis日志服务
数据传输（包年包月）
云解析 PrivateZone (按量付费)
应用监控按量付费
关系型数据库RDS(包月)
关系型数据库RDS(包月)
共享流量包
NAT网关（按量付费）
POLARDB-包年包月
云服务器ECS-按量付费
云服务器ECS-包年包月
云服务器ECS-包年包月
云服务器ECS-包年包月
文件存储NAS按量付费
企业级分布式应用服务(按量付费)
应用身份服务
弹性公网IP
图像识别
云盘
函数计算
对象存储OSS
密钥管理服务
PolarDB 备份
容器服务ACK
开放搜索包年包月
开放搜索包年包月
RDS只读实例
负载均衡
Prometheus监控服务
智能用户增长
大数据计算服务MaxCompute(按量付费)
Serverless 工作流
内容安全（按量付费）
全站加速日志投递服务
API网关
DAS专业版
云数据库KvStore-包年包月
云数据库KvStore-包年包月

## 参考

[网络规划](https://help.aliyun.com/document_detail/54095.html?spm=5176.21213303.J_6704733920.7.461a3eda15WTxx&scm=20140722.S_help%40%40%E6%96%87%E6%A1%A3%40%4054095.S_hot%2Bos0.ID_54095-RL_%E7%BD%91%E7%BB%9C%E8%A7%84%E5%88%92-LOC_helpmain-OR_ser-V_2-P0_0)