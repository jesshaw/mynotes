# K8S配置

## 创建ConfigMaps和Secrets

docker 容器设置环境变量有几种不同的方式，比如： Dockerfile、kubernetes.yml、Kubernetes ConfigMaps 和 Kubernetes Secrets。 后两种方便在多个容器间复用。

从名便知ConfigMaps用于存**非机密键值对**的 API 对象。

Secrets 尽管**也用来存储键值对**，但区别于 ConfigMaps 的是：它针对**机密/敏感**数据，且存储格式为 Base64 编码。

## 从代码外部化配置

外部化应用配置之所以有用处，是因为配置常常根据环境的不同而变化。 为了实现此功能，我们用到了 Java 上下文和依赖注入（Contexts and Dependency Injection, CDI）、MicroProfile 配置。

仓库地址：https://github.com/OpenLiberty/sample-kubernetes-config

### 微服务部署

1. 先打包成镜像

    ```bash
    mvn 创建镜像
    # 或
    mvn 打包
    # 然后
    docker build -t tag:version .
    ```

2. 使用yaml部署应用

    两部署类型，两服务用于对外暴露

    yaml文件部署应用

    ```bash
    kubectl apply -f kubernetes.yaml
    ```

    kubernetes.yaml

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: system-deployment
    labels:
        app: system
    spec:
    selector:
        matchLabels:
        app: system
    template:
        metadata:
        labels:
            app: system
        spec:
        containers:
        - name: system-container
            image: system:1.0-SNAPSHOT
            ports:
            - containerPort: 9080
            readinessProbe:
            httpGet:
                path: /health/ready
                port: 9080
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 3
            failureThreshold: 1
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: inventory-deployment
    labels:
        app: inventory
    spec:
    selector:
        matchLabels:
        app: inventory
    template:
        metadata:
        labels:
            app: inventory
        spec:
        containers:
        - name: inventory-container
            image: inventory:1.0-SNAPSHOT
            ports:
            - containerPort: 9080
            readinessProbe:
            httpGet:
                path: /health/ready
                port: 9080
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 3
            failureThreshold: 1
    ---
    apiVersion: v1
    kind: Service
    metadata:
    name: system-service
    spec:
    type: NodePort
    selector:
        app: system
    ports:
    - protocol: TCP
        port: 9080
        targetPort: 9080
        nodePort: 31000
    ---
    apiVersion: v1
    kind: Service
    metadata:
    name: inventory-service
    spec:
    type: NodePort
    selector:
        app: inventory
    ports:
    - protocol: TCP
        port: 9080
        targetPort: 9080
        nodePort: 32000
    ```

3. 检查应用启动状态

   ```bash
   kubectl wait --for=condition=ready pod -l app=inventory
   kubectl wait --for=condition=ready pod -l app=system
   ```

   一旦看到输出**condition met**说明应用准备就绪

   验证

   ```bash
   curl -u bob:bobpwd http://kworker2:31000/system/properties
   curl http://kworker1:32000/inventory/systems/system-service
   ```

## 创建ConfigMap

部署一个名sys-app-name的ConfigMap到集群，值为name=my-system。

--from-literal 允许你指定个性化的键值对存储在ConfigMap中。另外还有其他类型，如 --from-file 和 --from-env-file

```bash
kubectl create configmap sys-app-name --from-literal name=my-system
```

## 创建Secrets

部署一个名sys-app-credentials的ConfigMap到集群，值为password=bobpwd

generic为通用类型的密文。与ConfigMap类似只是存储的是密码。

```bash
kubectl create secret generic sys-app-credentials --from-literal username=bob --from-literal password=bobpwd
```

## 使用ConfigMap和Secrets

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: system-deployment
  labels:
    app: system
spec:
  selector:
    matchLabels:
      app: system
  template:
    metadata:
      labels:
        app: system
    spec:
      containers:
      - name: system-container
        image: system:1.0-SNAPSHOT
        ports:
        - containerPort: 9080
        # Set the APP_NAME environment variable
        env:
        - name: APP_NAME
          valueFrom:
            configMapKeyRef:
              name: sys-app-name
              key: name
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inventory-deployment
  labels:
    app: inventory
spec:
  selector:
    matchLabels:
      app: inventory
  template:
    metadata:
      labels:
        app: inventory
    spec:
      containers:
      - name: inventory-container
        image: inventory:1.0-SNAPSHOT
        ports:
        - containerPort: 9080
        # Set the SYSTEM_APP_USERNAME and SYSTEM_APP_PASSWORD environment variables
        env:
        - name: SYSTEM_APP_USERNAME
          valueFrom:
            secretKeyRef:
              name: sys-app-credentials
              key: username
        - name: SYSTEM_APP_PASSWORD
          valueFrom:
            secretKeyRef:
              name: sys-app-credentials
              key: password
---
apiVersion: v1
kind: Service
metadata:
  name: system-service
spec:
  type: NodePort
  selector:
    app: system
  ports:
  - protocol: TCP
    port: 9080
    targetPort: 9080
    nodePort: 31000
---
apiVersion: v1
kind: Service
metadata:
  name: inventory-service
spec:
  type: NodePort
  selector:
    app: inventory
  ports:
  - protocol: TCP
    port: 9080
    targetPort: 9080
    nodePort: 32000
````
