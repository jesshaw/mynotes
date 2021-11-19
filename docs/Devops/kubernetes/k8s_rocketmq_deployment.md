# k8s rocketmq部署

## 参考

[生产版rocketmq部署](https://github.com/homilly/rocketmq-k8s)

[KUBERNETES部署ROCKETMQ单节点](https://sre.ink/deploy-rocketmq-standalone-on-kubernetes/)

## nameserv

### StatefulSet nameserv

```yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: rocketmq-nameserv
  labels:
    app: rocketmq
spec:
  serviceName: rocketmq
  replicas: 1
  selector:
    matchLabels:
      app: rocketmq
  template:
    metadata:
      labels:
        app: rocketmq
    spec:
      containers:
        - name: rocketmq
          image: registry.cn-hangzhou.aliyuncs.com/sre_pub/rocketmq:server
          imagePullPolicy: IfNotPresent
          resources:
            limits:
              cpu: 450m
              memory: 2000Mi
            requests:
              cpu: 400m
              memory: 2000Mi
          env:
            - name: TZ
              value: Asia/Shanghai
            - name: JAVA_OPT
              value: -Duser.home=/opt
            - name: JAVA_OPT_EXT
              value: -server -Xms2000m -Xmx2000m -Xmn256m
          ports:
            - containerPort: 9876
          volumeMounts:
#            - name: vol-logs
#              mountPath: /opt/logs
            - name: vol-init-d
              mountPath: /opt/store
#      volumes:
#        - name: vol-logs
#          hostPath:
#            path: /www/k8s/foxdev/rocketmq/logs
#            type: Directory
#        - name: vol-init-d
#          hostPath:
#            path: /www/k8s/foxdev/rocketmq/store
#            type: Directory
  volumeClaimTemplates:
  - metadata:
      name: vol-init-d
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 128Gi
      #使用storageclass
      volumeName:
      storageClassName: nfs
```

### svc rocketmq nameserv

```yml
apiVersion: v1
kind: Service
metadata:

  name: rocketmq
  labels:
    app: rocketmq
spec:
  ports:
    - port: 9876
      targetPort: 9876
  selector:
    app: rocketmq
```

## broker

### cm broker.conf

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: broker-config
data:
  broker.conf: | #所属集群名字
        brokerClusterName=DefaultCluster

        #broker名字，注意此处不同的配置文件填写的不一样，如果在broker-a.properties使用:broker-a,
        #在broker-b.properties使用:broker-b
        brokerName=broker-a

        #0 表示Master，>0 表示Slave
        brokerId=0

        #nameServer地址，分号分割
        #namesrvAddr=rocketmq-0:9876;rocketmq-1:9876
        namesrvAddr=rocketmq:9876

        #启动IP,如果 docker 报 com.alibaba.rocketmq.remoting.exception.RemotingConnectException:         connect to <192.168.0.120:10909> failed
        # 解决方式1 加上一句producer.setVipChannelEnabled(false);，解决方式2 brokerIP1 设置宿主机IP，        不要使用docker 内部IP
        #brokerIP1=192.168.0.254

        #在发送消息时，自动创建服务器不存在的topic，默认创建的队列数
        defaultTopicQueueNums=4

        #是否允许 Broker 自动创建Topic，建议线下开启，线上关闭 ！！！这里仔细看是false，false，false
        #原因下篇博客见~ 哈哈哈哈
        autoCreateTopicEnable=true

        #是否允许 Broker 自动创建订阅组，建议线下开启，线上关闭
        autoCreateSubscriptionGroup=true

        #Broker 对外服务的监听端口
        listenPort=10911
        #haService中使用  默认值为：listenPort + 1
        #haListenPort=10912
        #主要用于slave同步master  listenPort - 2
        #fastListenPort=10909

        #删除文件时间点，默认凌晨4点
        deleteWhen=04

        #文件保留时间，默认48小时
        fileReservedTime=120

        #commitLog每个文件的大小默认1G
        mapedFileSizeCommitLog=1073741824

        #ConsumeQueue每个文件默认存30W条，根据业务情况调整
        mapedFileSizeConsumeQueue=300000

        #destroyMapedFileIntervalForcibly=120000
        #redeleteHangedFileInterval=120000
        #检测物理文件磁盘空间
        diskMaxUsedSpaceRatio=88
        #存储路径
        storePathRootDir=/opt/store
        #commitLog 存储路径
        #storePathCommitLog=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/commitlog
        #消费队列存储
        #storePathConsumeQueue=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/consumequeue
        #消息索引存储路径
        #storePathIndex=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/index
        #checkpoint 文件存储路径
        #storeCheckpoint=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/checkpoint
        #abort 文件存储路径
        #abortFile=/home/ztztdata/rocketmq-all-4.1.0-incubating/store/abort
        #限制的消息大小
        maxMessageSize=65536

        #flushCommitLogLeastPages=4
        #flushConsumeQueueLeastPages=2
        #flushCommitLogThoroughInterval=10000
        #flushConsumeQueueThoroughInterval=60000

        #Broker 的角色
        #- ASYNC_MASTER 异步复制Master
        #- SYNC_MASTER 同步双写Master
        #- SLAVE
        brokerRole=ASYNC_MASTER

        #刷盘方式
        #- ASYNC_FLUSH 异步刷盘
        #- SYNC_FLUSH 同步刷盘
        flushDiskType=ASYNC_FLUSH

        #发消息线程池数量
        #sendMessageThreadPoolNums=128
        #拉消息线程池数量
        #pullMessageThreadPoolNums=128
```

### StatefulSet rmqbroker

```yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: rmqbroker
  labels:
    app: rmqbroker

spec:
  serviceName: rmqbroker
  replicas: 1
  selector:
    matchLabels:
      app: rmqbroker
  template:
    metadata:
      labels:
        app: rmqbroker
    spec:
      containers:
        - name: rmqbroker
          image: registry.cn-hangzhou.aliyuncs.com/sre_pub/rocketmq:broker
          imagePullPolicy: IfNotPresent
          resources:
            limits:
              cpu: 440m
              memory: 2000Mi
            requests:
              cpu: 400m
              memory: 2000Mi
          env:
            - name: TZ
              value: Asia/Shanghai
            - name: JAVA_OPT_EXT
              value:  -Duser.home=/opt -server -Xms1700m -Xmx1700m
          command: ["/bin/bash","mqbroker","-c","/etc/rocketmq/broker.conf","-n","rocketmq:9876","autoCreateTopicEnable=true"]
          ports:
            - containerPort: 10909
            - containerPort: 10911
            - containerPort: 10912
          volumeMounts:
#            - name: vol-logs
#              mountPath: /opt/logs
            - name: vol-store
              mountPath: /opt/store
            - name: vol-broker-config
              mountPath: /etc/rocketmq
#      volumes:
#        - name: vol-logs
#          hostPath:
#            path: /www/k8s/foxdev/rocketmq/logs-b
#            type: Directory
#        - name: vol-store
#          hostPath:
#              path: /www/k8s/foxdev/rocketmq/store-b
#              type: Directory
#        - name: vol-broker
#          hostPath:
#            path: /www/k8s/foxdev/rocketmq/conf/broker.conf
#            type: File
      volumes:
      - name: vol-broker-config
        configMap:
          name: broker-config
  volumeClaimTemplates:
  - metadata:
      name: vol-store
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 128Gi
      volumeName:
      storageClassName: nfs
```

### svc rmqbroker

```yml
apiVersion: v1
kind: Service
metadata:

  name: rmqbroker
  labels:
    app: rmqbroker
spec:
  ports:
    - port: 10909
      targetPort: 10909
      name: slave-master
    - port: 10911
      targetPort: 10911
      name: listen
    - port: 10912
      targetPort: 10912
      name: ha-service
  selector:
    app: rmqbroker
```

## ui 控制台

### StatefulSet rmqui

```yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: rmqui
  labels:
    app: rmqui

spec:
  serviceName: rmqui
  replicas: 1
  selector:
    matchLabels:
      app: rmqui
  template:
    metadata:
      labels:
        app: rmqui
    spec:
      containers:
        - name: rmqui
          image: registry.cn-hangzhou.aliyuncs.com/sre_pub/rocketmq-console-ng
          imagePullPolicy: IfNotPresent
          resources:
            limits:
              cpu: 350m
              memory: 1024Mi
            requests:
              cpu: 300m
              memory: 768Mi
          env:
            - name: TZ
              value: Asia/Shanghai
            - name: JAVA_OPTS
              value: -Drocketmq.namesrv.addr=rocketmq:9876 -Dcom.rocketmq.sendMessageWithVIPChannel=false -Duser.home=/root  -Xms512m -Xmx512m
          ports:
            - containerPort: 8080
#          volumeMounts:
#            - name: vol-logs
#              mountPath: /root/logs
#      volumes:
#        - name: vol-logs
#          hostPath:
#            path: /opt/logs-ui
#            type: Directory
```

### Service rmqui

```yml
apiVersion: v1
kind: Service
metadata:

  name: rmqui
  labels:
    app: rmqui
spec:
  type: NodePort
  ports:
    - port: 8080
      targetPort: 8080
      nodePort: 30014
  selector:
    app: rmqui
```

### Service rmqui aliyun LoadBalancer

```yml
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/alicloud-loadbalancer-address-type: "intranet"
  name: rmqui
  labels:
    app: rmqui
spec:
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 8080
  selector:
    app: rmqui
  type: LoadBalancer
```
