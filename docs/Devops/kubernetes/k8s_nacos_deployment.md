# k8s nacos部署

## 参考

[k8s部署单机版nacos](https://blog.csdn.net/xingzuo_1840/article/details/119675103)

[官方Kubernetes Nacos](https://github.com/nacos-group/nacos-k8s/blob/master/README-CN.md)

## k8s单机部署nacos

mysql 初始化sql : https://github.com/alibaba/nacos/blob/develop/distribution/conf/nacos-mysql.sql

https://raw.githubusercontent.com/alibaba/nacos/develop/distribution/conf/nacos-mysql.sql

nacos.yaml

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: nacos
  namespace: nacos
spec:
  serviceName: nacos-headless
  replicas: 1
  template:
    metadata:
      labels:
        app: nacos
      annotations:
        pod.alpha.kubernetes.io/initialized: "true"
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: "app"
                    operator: In
                    values:
                      - nacos
              topologyKey: "kubernetes.io/hostname"
      containers:
        - name: nacos
          imagePullPolicy: Always
          image: nacos/nacos-server:latest
          resources:
            requests:
              memory: "2Gi"
              cpu: "500m"
          ports:
            - containerPort: 8848
              name: client-port
            - containerPort: 7848
              name: rpc
          env:
            - name: NACOS_REPLICAS
              value: "1"
            - name: MYSQL_SERVICE_DB_NAME
              valueFrom:
                configMapKeyRef:
                  name: nacos-cm
                  key: mysql.db.name
            - name: MYSQL_SERVICE_PORT
              valueFrom:
                configMapKeyRef:
                  name: nacos-cm
                  key: mysql.port
            - name: MYSQL_SERVICE_USER
              valueFrom:
                configMapKeyRef:
                  name: nacos-cm
                  key: mysql.user
            - name: MYSQL_SERVICE_PASSWORD
              valueFrom:
                configMapKeyRef:
                  name: nacos-cm
                  key: mysql.password
            - name: NACOS_SERVER_PORT
              value: "8848"
            - name: NACOS_APPLICATION_PORT
              value: "8848"
            - name: PREFER_HOST_MODE
              value: "hostname"
            - name: TZ
              value: Asia/Shanghai
            - name: MODE
              value: standalone
          volumeMounts:
            - name: datadir
              mountPath: /home/nacos/data
            - name: logdir
              mountPath: /home/nacos/logs
  volumeClaimTemplates:
    - metadata:
        name: datadir
        annotations:
          volume.beta.kubernetes.io/storage-class: "nfs-client"
      spec:
        accessModes: [ "ReadWriteMany" ]
        resources:
          requests:
            storage: 10Gi
    - metadata:
        name: logdir
        annotations:
          volume.beta.kubernetes.io/storage-class: "nfs-client"
      spec:
        accessModes: [ "ReadWriteMany" ]
        resources:
          requests:
            storage: 10Gi
  selector:
    matchLabels:
      app: nacos
---
apiVersion: v1
kind: Service
metadata:
  name: nacos
  namespace: nacos
  labels:
    app: nacos
spec:
  type: NodePort
  ports:
    - port: 8848
      name: server
      targetPort: 8848
      nodePort: 30018
    - port: 7848
      name: rpc
      targetPort: 7848
      nodePort: 30019
  selector:
    app: nacos
```
