# K8S

## 指定Node的Pod

### 增加label

https://www.cnblogs.com/mcsiberiawolf/p/12220871.html

### 使用现有label

https://www.jianshu.com/p/bac45f6c8fab

## local token

```bash
eyJhbGciOiJSUzI1NiIsImtpZCI6IjJoQXVpcUExRWl5ZWdQRFg4NzdseUhFZGR4NmNNMHI2aUI4bG9CVjgtZWMifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLTRsc3R3Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIwYmU0NTE2MC1lMTFmLTQ1OWQtOTk3NS01NGQzZmZlNTMxZGYiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.d1iNr6lNgB_XsTA_zb-K1xfj_4GXYiwJRtfCvwinCh7VYnR2hOqOb4ztHGkG_BG5BeRraKom3Kg8sSvhrDfLB7JPMym4VHxdoie_Z0rxAE-hGVyslI4hUfMSdA65ZpUfMuNuKKmrDEfcQmsn08QeZgey-t095-U0gZBP9JkeMqgzHLtJeJT7bIVHe7eVuhDXmLqgt2ZuaBvQr6uKIBO_pHpkfj3SDKZxFR-2lNz-ZjUAHIsgpxa1RBjg3Ky4NM8N6L4g-UwfNNOMaNJnkjYLOA4aw03xf1jxC_Qt45i-P87mpsCXceM8DQVOdahZalvnafp0RmwdTzVpdmr2-7I7mQ
```

## Service Pod 的关系

Pod 是转瞬即逝的。 Pod 实际上拥有 生命周期。 pod即docker里面的容器

服务(Service)是一种抽象概念，它定义了 Pod 的逻辑集和访问 Pod 的协议。

尽管每个 Pod 都有一个唯一的 IP 地址，但是如果没有 Service ，这些 IP 不会暴露在群集外部。

Deployment

参考：https://kubernetes.io/zh/docs/tutorials/kubernetes-basics/expose/expose-intro/

## 部署应用

### 查看k8s版本

```bash
kubectl version
```

### 显示节点数

```bash
kubectl get nodes
```

### 创建一个部署应用

**前置工作** 因为google版本的拉取不到，改换jocatalin/kubernetes-bootcamp:v1版本

```bash
docker pull jocatalin/kubernetes-bootcamp:v1
```

```bash
kubectl create deployment kubernetes-bootcamp --image=jocatalin/kubernetes-bootcamp:v1
```

### 查看部署应用

```bash
kubectl get deployments
```

### 创建代理转发

**新开**窗口启动代理

```bash
kubectl proxy
```

查看转发是否成功

```bash
curl http://localhost:8001/version
```

查看pod详情

```bash

export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')

echo Name of the Pod: $POD_NAME

curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/
```

## 了解应用

```bash
# 查看pods概述
kubectl get pods

# 查看所有pods详情
kubectl get pods

# 据label查看所有pods详情
kubectl describe po -l name=myLabel

# 据 replication controller 查看所有pods详情
kubectl describe pods frontend
```

### 查看存储方法

```bash
# storageclass
kubectl get sc

# 查看pv
kubectl get pv
```

## 暴露应用

使用 Service 暴露。 ReplicaSet会保证副本数符合指定数。

Service 也可以用在 ServiceSpec 标记type的方式暴露

- ClusterIP (默认) - 在集群的内部 IP 上公开 Service 。这种类型使得 Service 只能从集群内访问。
- NodePort - 使用 NAT 在集群中每个选定 Node 的相同端口上公开 Service 。使用<NodeIP>:<NodePort> 从集群外部访问 Service。是 ClusterIP 的超集。
- LoadBalancer - 在当前云中创建一个外部负载均衡器(如果支持的话)，并为 Service 分配一个固定的外部IP。是 NodePort 的超集。
- ExternalName - 通过返回带有该名称的 CNAME 记录，使用任意名称(由 spec 中的externalName指定)公开 Service。不使用代理。这种类型需要kube-dns的v1.7或更高版本。

Service 匹配一组 Pod 是使用 标签(Label)和选择器(Selector), 它们是允许对 Kubernetes 中的对象进行逻辑操作的一种分组原语。

### 查看services概述

```bash
kubectl get services
```

### NodePort类型方式暴露应用

```bash
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
```

### 查看服务说情

```bash
kubectl describe services/kubernetes-bootcamp
```

### 创建一个NODE_PORT的环境变量

```bash
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
```

### 据label获取pods

```bash
kubectl get pods -l app=kubernetes-bootcamp
```

### 创建一个POD_NAME的环境变量

```bash
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
```

### 据label获取services

```bash
kubectl get services -l app=kubernetes-bootcamp
```

### 通过节点和端口访问应用

```bash
curl nodeip:port
eg. curl kworker2:31990
```

### 添加新标签到指定pods上

```bash
kubectl label pods $POD_NAME version=v1

# 据新标签查看pods
kubectl get pods -l version=v1
```

### 删除服务

```bash
kubectl delete service -l  app=kubernetes-bootcamp

# 查看执行结果
kubectl get services
# 查看暴露节点是否能访问
curl kworker2:31990
```

## 扩缩容应用

**扩展** Deployment 将创建新的 Pods，并将资源调度请求分配到有可用资源的节点上。
**收缩** 会将 Pods 数量减少至所需的状态。

Kubernetes 还支持 Pods 的自动缩放，也可以将Pods 数量收缩到0，但这会终止 Deployment 上所有已经部署的 Pods。

运行应用程序的多个实例需要在它们之间分配流量。服务 (Service)有一种负载均衡器类型，可以将网络流量均衡分配到外部可访问的 Pods 上。

### 查看rs

```bash
kubectl get rs
```

### 扩缩容到3个复本

```bash
kubectl scale deployments/kubernetes-bootcamp --replicas=3

# 查看pods概述
kubectl get pods -o wide
# 查看部署后的详情
kubectl describe deployments/kubernetes-bootcamp
# NodePort方式暴露应用
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
```

## 滚动更新

升级或回滚适用

### 执行滚动更新

```bash
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2

# 查看更新进度
kubectl get pods
# 查看详情服务是否正常暴露
kubectl describe services/kubernetes-bootcamp
# 查看是否能正常访问
curl kworker1:31866
# 查看镜像是否变化
kubectl describe pods

kubectl rollout status deployments/kubernetes-bootcamp

# 更新一个不存在的镜像，并不影响现有的应用，但deployment中的镜像有变化, pods没有（更新成功后才会变化）
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v10

# 查看deployment指向了哪个版本的镜像了
kubectl get deployments -o wide

# 回滚到上一版本
kubectl rollout undo deployments/kubernetes-bootcamp

# 查看历史版本
kubectl rollout history deployment/kubernetes-bootcamp

# 查看1号版本详情
kubectl rollout history deployment/kubernetes-bootcamp --revision=1

# 回滚指定版本
kubectl rollout undo deployments/kubernetes-bootcamp --to-revision=1

```
