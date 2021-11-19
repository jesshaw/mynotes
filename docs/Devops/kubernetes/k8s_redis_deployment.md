# k8s redis部署

## 参考

[kubernetes部署redis5.0.6单机版 自定义配置文件、密码、日志路径等](https://blog.csdn.net/ll837448792/article/details/103310434)

## k8s单机部署redis

redis.yaml

```yaml
 apiVersion: v1
 kind: Deployment
 metadata:
   name: redis
 spec:
   replicas: 1
   selector:
     app: redis
   template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis
        resources:
          limits:
            cpu: 220m
            memory: 2000Mi
          requests:
            cpu: 200m              
            memory: 2000Mi
        ports:
        - containerPort: 6379
---
 apiVersion: v1
 kind: Service
 metadata:
   name: redis
 spec:
   type: NodePort
   ports:
   - port: 6379
     targetPort: 6379
     nodePort: 36379
   selector: # 选择app为redis的暴露
     app: redis
```

```bash
kubectl apply -f redis.yaml -n redis
```
