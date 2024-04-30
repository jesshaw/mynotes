# 安装kubernetes集群

## 安装前置条件

1. 1台管理机，3台K8S集群受控机。
    > 基于docker容器的ansible方式安装，控制机须安装docker。
2. 打通

管理机运行 Ansible 的服务器必须且只需要安装有 Python 2.7+ 或者 Python 3.5+。 Red Hat, Debian, CentOS, macOS, 任一 BSD 系列的系统均可。 但`Windows` 不能用于管理机。docker容器同样可以。

受管节点需要和外界正常通信，默认使用 SSH 协议。 默认使用 SFTP 。 如果 SFTP 无法使用，你可以在 ansible.cfg 中将其修改为 SCP . 同样，受管机需要有 Python 2.6+ 或 Python 3.5以上的环境。

## 一、配置免密登录

配置控制机至各机器的免密登录。

```bash
docker run --rm -it -v $PWD/.ssh:/root/.ssh   quay.io/kubespray/kubespray:v2.23.1 bash

ssh-keygen # 生成密钥,选择不带二次加密的认证
ssh-copy-id # 复制公钥到目标机器实现免密认证
ssh username@host # 验证连通性
```

## 二、创建集群配置信息

机器      | 功能         | 名称
----------|--------------|---
10.0.0.10 | control,etcd | c1
10.0.0.20 | node         | n1
10.0.0.21 | node         | n2

etcd若资源不够则跟control节点安装在一起，充足时单独安装，奇数节点。etcd本持是键值对用于存储K8S资源的相关状态。

hosts中的所有hostaname必须全小写，且以小写字母开头。

```bash
docker run --rm -it -v $PWD/k8scluster:/kubespray/inventory/k8scluster \
-v $PWD/.ssh:/root/.ssh   quay.io/kubespray/kubespray:v2.23.1 bash

cp -rfp inventory/sample/* inventory/k8scluster

declare -a IPS=(10.0.0.10 10.0.0.20 10.0.0.21)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```

### 网址规划

规划原则就是不冲突

**网段**：192.168.0.0/24，**24**：表示从左起24个为1的二进制码

名称     | 结果
-------|--------------
掩码     | 255.255.255.0
网络     | 192.168.0.0
第一个IP | 192.168.0.1
最后IP   | 192.168.0.254
广播     | 192.168.0.255

### 证书过期时间

ca证书默认为10年，其它证书可以设置自动更新，具体参看下文

kubespray默认配置如下：

```yml
# roles/kubespray-defaults/defaults/main/main.yml
certificates_duration: 36500
```

#### 查看证书过期时间

参考：https://www.cnblogs.com/LiuChang-blog/p/15347791.html

```bash
$ kubeadm certs check-expiration

[check-expiration] Reading configuration from the cluster...
[check-expiration] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
W0424 09:34:23.504196   60638 utils.go:69] The recommended value for "clusterDNS" in "KubeletConfiguration" is: [10.96.0.10]; the provided value is: [169.254.25.10]

CERTIFICATE                EXPIRES                  RESIDUAL TIME   CERTIFICATE AUTHORITY   EXTERNALLY MANAGED
admin.conf                 Apr 23, 2025 09:52 UTC   364d            ca                      no      
apiserver                  Apr 23, 2025 09:52 UTC   364d            ca                      no      
apiserver-kubelet-client   Apr 23, 2025 09:52 UTC   364d            ca                      no      
controller-manager.conf    Apr 23, 2025 09:52 UTC   364d            ca                      no      
front-proxy-client         Apr 23, 2025 09:52 UTC   364d            front-proxy-ca          no      
scheduler.conf             Apr 23, 2025 09:52 UTC   364d            ca                      no      

CERTIFICATE AUTHORITY   EXPIRES                  RESIDUAL TIME   EXTERNALLY MANAGED
ca                      Apr 21, 2034 09:52 UTC   9y              no      
front-proxy-ca          Apr 21, 2034 09:52 UTC   9y              no 
```

### 打开其它配置

```yml
# group_var\k8s_cluster\addons.yml
dashboard_enabled: true
helm_enabled: true
metrics_server_enabled: true
ingress_nginx_enabled: true

# create mirror
# group_var\all\mirror.yml
cp inventory/mycluster/group_vars/all/offline.yml inventory/mycluster/group_vars/all/mirror.yml
sed -i -E '/# .*\{\{ files_repo/s/^# //g' inventory/mycluster/group_vars/all/mirror.yml
tee -a inventory/mycluster/group_vars/all/mirror.yml <<EOF
gcr_image_repo: "gcr.m.daocloud.io"
kube_image_repo: "k8s.m.daocloud.io"
docker_image_repo: "docker.m.daocloud.io"
quay_image_repo: "quay.m.daocloud.io"
github_image_repo: "ghcr.m.daocloud.io"
files_repo: "https://files.m.daocloud.io"
EOF
```

### 开始安装集群

```bash
ansible-playbook -i inventory/mycluster/hosts.yaml --user=ops \
--become --become-user=root -v cluster.yml
```

升级

如何升级：https://kubespray.io/#/docs/upgrades

可单独指定的升级标签：https://kubespray.io/#/docs/ansible?id=ansible-tags

```bash
ansible-playbook -i inventory/mycluster/hosts.yaml --user=ops \
--become --become-user=root -v upgrade-cluster.yml
```

## 三、验证

### 访问集群

安装完成后默认路径为/usr/local/bin，因此设置一下环境变量。

```bash
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc # 立即生效

# 查看控制节点和工作节点是否正常
kubectl get node 
```

### 冒烟测试

```bash
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc # 立即生效

# 查看控制节点和工作节点是否正常
kubectl get node 
```

### 网络

开2个窗口，验证连通性

```bash
kubectl run myshell1 -it --rm --image busybox -- sh
hostname -i
# launch myshell2 in separate terminal (see next code block) and ping the hostname of myshell2
ping <hostname myshell2>

kubectl run myshell2 -it --rm --image busybox -- sh
hostname -i
ping <hostname myshell1>
```

### 生成客户端访问token

参考：https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

创建用户

```yml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
```

创建用户角色绑定

```yml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
```

为 ServiceAccount 获取长期持有者令牌

使用绑定服务帐户的 Secret 创建一个令牌，该令牌将保存在 Secret 中

```yml
apiVersion: v1
kind: Secret
metadata:
  name: admin-user
  namespace: kube-system
  annotations:
    kubernetes.io/service-account.name: "admin-user"   
type: kubernetes.io/service-account-token
```

获取令牌

```bash
kubectl get secret admin-user -n kube-system -o jsonpath={".data.token"} | base64 -d
```

### dashborad验证

通过当前机器实现转化到services的功能，实现从集群外访问dashboard

集群外输入转化节点IP:8000 -> service -> pod

```bash
kubectl -n kube-system port-forward --address 0.0.0.0  services/kubernetes-dashboard 8000:443
```
