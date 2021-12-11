# Seata部署

## 参考

[Seata自定义配置](http://seata.io/zh-cn/docs/ops/deploy-by-kubernetes.html)

## Seata

seata.yml

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: seata-server-config
data:
  registry.conf: |
    # 注册到服务器
    registry {
        type = "nacos"
        nacos {
            application = "seata-server"
            serverAddr = "192.168.0.123:8848"
            username = "nacos"
            password = "nacos"
        }
    }
    # 从nacos读取seata的相关配置
    config {
        type = "nacos"
        nacos {
            serverAddr = "192.168.0.123:8848"
            group = "SEATA_GROUP"
            username = "nacos"
            password = "nacos"
        }
    }
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: seata-server
  labels:
    k8s-app: seata-server
spec:
  replicas: 1
  selector:
    matchLabels:
      k8s-app: seata-server
  template:
    metadata:
      labels:
        k8s-app: seata-server
    spec:
      containers:
        - name: seata-server
          image: docker.io/seataio/seata-server:1.4.2
          imagePullPolicy: IfNotPresent
          env:
            - name: SEATA_CONFIG_NAME
              value: file:/root/seata-config/registry
          ports:
            - name: http
              containerPort: 8091
              protocol: TCP
          volumeMounts:
            - name: seata-config
              mountPath: /root/seata-config
      volumes:
        - name: seata-config
          configMap:
            name: seata-server-config
---
apiVersion: v1
kind: Service
metadata:
  name: seata-server
  labels:
    k8s-app: seata-server
spec:
  type: NodePort
  ports:
    - port: 8091
      nodePort: 30091
      protocol: TCP
      name: http
  selector:
    k8s-app: seata-serve
```
