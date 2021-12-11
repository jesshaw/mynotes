# k8s xxl-job部署

## 参考

[xxl-job部署](https://github.com/foxiswho/k8s-nacos-sentinel-rocketmq-zipkin-elasticsearch-redis-mysql/tree/master/job-xxl-job)

[db初始化](https://github.com/xuxueli/xxl-job/blob/master/doc/db/tables_xxl_job.sql)

[分布式任务调度平台XXL-JOB文档](http://www.xuxueli.com/xxl-job/)

初始用户名和密码：`admin/123456`

## xxl-job

[DB数据初始化](https://github.com/xuxueli/xxl-job/blob/master/doc/db/tables_xxl_job.sql)

xxl-job.cm.yml

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: xxl-job-cm
data:
  PARAMS: "--spring.datasource.url=jdbc:mysql://mariadb-0.mariadb.default.svc.cluster.local:3306/xxl_job?Unicode=true&characterEncoding=UTF-8 --spring.datasource.username=root --spring.datasource.password=root "
```

xxl-job.yml

```yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: xxl-job
  labels:
    app: xxl-job
spec:
  serviceName: xxl-job
  replicas: 1
  selector:
    matchLabels:
      app: xxl-job
  template:
    metadata:
      labels:
        app: xxl-job
    spec:
      containers:
        - name: xxl-job
          image: xuxueli/xxl-job-admin:2.2.0
          imagePullPolicy: IfNotPresent
          resources:
            limits:
              cpu: 450m
              memory: 1024Mi
            requests:
              cpu: 400m
              memory: 1024Mi
          env:
            - name: TZ
              value: Asia/Shanghai
            - name: PARAMS
              valueFrom:
                configMapKeyRef:
                  name: xxl-job-cm
                  key: PARAMS
          ports:
            - containerPort: 8080
          volumeMounts:
            - name: vol-logs
              mountPath: /data/applogs
      volumes:
        - name: vol-logs
          hostPath:
            path: /www/k8s/foxdev/job-xxl-job/logs
            type: Directory
---
apiVersion: v1
kind: Service
metadata:
  name: xxl-job
  labels:
    app: xxl-job
spec:
  type: NodePort
  ports:
    - port: 8080
      targetPort: 8080
      nodePort: 30820
      name: web
  selector:
    app: xxl-job
```
