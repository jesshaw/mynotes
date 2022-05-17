# K8S存储

## pv

StorageClass是pv的一种抽象，可以认定他为pv的模板，在创建pv时候我们可以主动进行绑定。

pv是集群级别的基础资源，声明pv时候，使用apply 进行创建是不需要指定命名空间的，而PersistentVolumeClaim需要指定命名空间，因为用户定义的需要进行环境隔离，pvc从pv中申请存储卷.

pv 不需要指定namespace

pvc 需要指定namespace

Unable to update instance pid: Unable to create directory /nexus-data/instances

给指定目录授权

```bash
chmod 777 nexus
```

```yaml
apiVersion: v1
kind: List
items:
- apiVersion: v1
  kind: PersistentVolumeClaim
  metadata:
    name: wws-registry-claim
    namespace: std
  spec:
    # volumeName: registry-pvc
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
        storage: 1Gi
    storageClassName: microk8s-hostpath
```

## [Kubernetes]安装local-path-provisioner基于HostPath使用动态PV

获取[local-path-provisioner](https://github.com/rancher/local-path-provisioner)

```bash
git clone https://github.com/rancher/local-path-provisioner.git

```

修改local-path-storage.yaml

```bash
vi local-path-provisioner/deploy/local-path-storage.yaml
```

修改前（修改部分）：

```yml
kind: ConfigMap
apiVersion: v1
metadata:
  name: local-path-config
  namespace: local-path-storage
data:
  config.json: |-
        {
                "nodePathMap":[
                {
                        "node":"DEFAULT_PATH_FOR_NON_LISTED_NODES",
                        "paths":["/opt/local-path-provisioner"]
                }
                ]
        }`

```

修改后（修改部分）：

```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: local-path-config
  namespace: local-path-storage
data:
  config.json: |-
        {
                "nodePathMap":[
                {
                        "node":"DEFAULT_PATH_FOR_NON_LISTED_NODES",
                        "paths":["/u01/local-path-provisioner"]
                }
                ]
        }`

```

#### 创建文件路径

```bash
mkdir -p /u01/local-path-provisioner
```

```bash
chmod 777 /u01/local-path-provisioner
```

#### 创建namespace

```bash
kubectl create ns local-path-storage
```

#### 发布local-path-storage

```bash
kubectl apply -f local-path-provisioner/deploy/local-path-storage.yaml -n local-path-storage
```

#### 确认发布结果

确认结果：

```bash
# 获取所有空间的pods
kubectl get pods --all-namespaces

kubectl get po -n local-path-storage
```

结果如下：

```bash
NAME                                      READY   STATUS    RESTARTS   AGE
local-path-provisioner-54bbdbb5cc-7d8kw   1/1     Running   0          18m
```

确认结果：

```bash
kubectl get storageclass
```

结果如下：

```bash
NAME         PROVISIONER             AGE
local-path   rancher.io/local-path   18m

```

#### 创建PVC和POD进行测试

pvc.yam如下：

```bash
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-path-pvc
  namespace: default
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: local-path
  resources:
    requests:
      storage: 2Gi

```

pod.yaml如下：

```bash
apiVersion: v1
kind: Pod
metadata:
  name: volume-test
  namespace: default
spec:
  containers:
  - name: volume-test
    image: nginx:stable-alpine
    imagePullPolicy: IfNotPresent
    volumeMounts:
    - name: volv
      mountPath: /data
    ports:
    - containerPort: 80
  volumes:
  - name: volv
    persistentVolumeClaim:
      claimName: local-path-pvc

```

发布PVC和POD：

```bash
kubectl create -f local-path-provisioner/examples/pvc.yaml
```

```bash
kubectl create -f local-path-provisioner/examples/pod.yaml
```

确认结果：

```bash
kubectl get pv
```

结果如下：

```bash
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                                   STORAGECLASS      REASON   AGE
pvc-adeb9540-5ad8-11ea-9cf7-02001700ae85   2Gi        RWO            Delete           Bound       default/local-path-pvc                  local-path                 18m


```

确认结果：

```bash
kubectl get pvc
```

结果如下：

```bash
$ kubectl get pvc -n default
NAME                        STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
local-path-pvc              Bound     pvc-adeb9540-5ad8-11ea-9cf7-02001700ae85   2Gi        RWO            local-path     21m`

```

删除测试的PVC和POD：

```bash
kubectl delete -f local-path-provisioner/examples/pod.yaml
```

```bash
kubectl delete -f local-path-provisioner/examples/pvc.yaml
```

#### 设置为默认的storageclass

```bash
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

#### 卸载

```bash
kubectl delete -f local-path-provisioner/deploy/local-path-storage.yaml
```

## 参考

[为pvc创建默认存储类--官网](https://kubernetes.io/zh/docs/tasks/administer-cluster/change-default-storage-class/)
[k8s持久化存储方案](https://www.jianshu.com/p/4cbc9edef18d)
