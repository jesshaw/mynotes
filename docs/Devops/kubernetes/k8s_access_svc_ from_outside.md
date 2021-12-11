# kubernets外部访问服务

## 将服务暴露给外部客户端的几种方式

- 通过`port-forward`转发, 这种方式在之前的文章中有提到过, 操作方便、适合调试时使用, 不适用于生产环境.
- 通过`NodePort`, 此时集群中每一个节点(Node)都会监听指定端口, 我们通过任意节点的端口即可访问到指定服务. 但过多的服务会开启大量端口难以维护.
- 通过`LoadBalance`来暴露服务. LoadBalance(负载均衡 LB)通常由云服务商提供, 如果云环境中不提供LB服务, 我们通常直接使用Ingress, 或使用MetalLB来自行配置LB.
- 通过`Ingress`公开多个服务. Ingress公开了从群集外部到群集内 services 的HTTP和HTTPS路由. 流量路由由Ingress资源上定义的规则控制. 在云服务商不提供LB服务的情况下, 我们可以直接使用Ingress来暴露服务. (另外, 使用LB + Ingress的部署方案可以避免过多LB应用带来的花费).

[参考](https://juejin.cn/post/6844903974206701575)