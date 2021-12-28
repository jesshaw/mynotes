# ingress-nginx-controlle部署和自签名TLS实现

## ingress-nginx-controlle部署

### 前置条件

kubernetes版本>=v1.19, [ingress-nginx v1.1.0](https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/cloud/deploy.yaml)最新版

### 部署

1. 下载，修改改镜像版本

    image: liangjw/ingress-nginx-controller:v1.1.0
    image: liangjw/kube-webhook-certgen:v1.1.1

    ```bash
    wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/cloud/deploy.yaml

    ```

2. 部署

    因ingress-nginx-controller默认是LoadBalancer类型，因此通过指定externalIPs外网IP暴露
    增加externalIPs，指定为ingress-nginx-controller运行的对应的节点IP172.42.42.101

    ```yaml
    # Source: ingress-nginx/templates/controller-service.yaml
    apiVersion: v1
    kind: Service
    metadata:
    annotations:
    labels:
        helm.sh/chart: ingress-nginx-4.0.10
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.0
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: controller
    name: ingress-nginx-controller
    namespace: ingress-nginx
    spec:
    type: LoadBalancer
    externalTrafficPolicy: Local
    ipFamilyPolicy: SingleStack
    ipFamilies:
        - IPv4
    ports:
        - name: http
        port: 80
        protocol: TCP
        targetPort: http
        appProtocol: http
        - name: https
        port: 443
        protocol: TCP
        targetPort: https
        appProtocol: https
    externalIPs:
        - 172.42.42.101
    selector:
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/component: controller
    ```

    ```bash
    kubectl apply -f deploy.yaml
    ```

3. 查看运行状态

显示Completed状态的是两个已经完成任务Job，属正常状态。

```bash
# kubectl get pods -n ingress-nginx
NAME                                       READY   STATUS      RESTARTS   AGE
ingress-nginx-admission-create-gsllw       0/1     Completed   0          94m
ingress-nginx-admission-patch-7bvsd        0/1     Completed   0          94m
ingress-nginx-controller-f54b4c9bd-tk7fn   1/1     Running     0          94m

#查看 service
# kubectl get svc -n ingress-nginx
NAME                                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller             NodePort    10.0.0.124   <none>        80:30220/TCP,443:32164/TCP   102m
ingress-nginx-controller-admission   ClusterIP   10.0.0.130   <none>        443/TCP                      102m</code>
```

到此 ingress-nginx 就可以正常运行,配置好映射即可访问ingress。

## TSL

## 创建key

openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout tls.key -out tls.crt -subj "/CN=www.lexiangmiao.dev/O=www.lexiangmiao.dev" -days 365

## 创建加密tls

kubectl create secret tls ingress-local-tls --cert=./tls.crt --key=./tls.key

若出现权限问题，确保tls.key为可读权限

```bash
chmod 664 tls.key
```

配置ingress

```yml
# source ingress-https.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-http
spec:
  tls:
    - hosts:
        - '*.lexiangmiao.dev'
        - www.lexiangmiao.dev
      secretName: ingress-local-tls
  rules:
    - host: www.lexiangmiao.dev
      http:
        paths:
        - pathType: Prefix
          path: /
          backend:
            service:
              name: my-nginx
              port:
                number: 80
    - host: blog.lexiangmiao.dev
      http:
        paths:
        - pathType: Prefix
          path: /
          backend:
            service:
              name: demo
              port:
                number: 80
  ingressClassName: nginx
```

访问机器增加hosts映射后即可访问

172.42.42.101 www.lexiangmiao.dev blog.lexiangmiao.dev

chrome打开报不是私密连接的问题，在当前页键盘输入thisisunsafe即可显示。

## 参考

- [官网入门](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start)
- [服务概述](https://kubernetes.io/zh/docs/concepts/services-networking/service/)
- [ingress概述](https://kubernetes.io/zh/docs/concepts/services-networking/ingress/)
- [版本选择](https://github.com/kubernetes/ingress-nginx)
- [ingress-nginx-controller 部署以及优化](https://www.cnblogs.com/koala2020/p/15195450.html)
- [openssl生成自签名证书](https://www.jianshu.com/p/0e9ee7ed6c1d)
- [k8s ingress 自签名实现](https://michalwojcik.com.pl/2021/08/08/ingress-tls-in-kubernetes-using-self-signed-certificates/)
- [Chrome您的连接不是私密连接，解决办法](https://blog.csdn.net/qq_33957603/article/details/112300150)
- [NGINX Ingress Controller故障排除](https://kubernetes.github.io/ingress-nginx/troubleshooting/)