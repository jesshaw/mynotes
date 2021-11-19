# 基于virtualbox的k8s集群搭建

## 背景

运维资源没有，公司有些项目需要k8s部署，搭建环境记录下来，供学习用

## 目前

一master节点，2个work节点。

root权限下操作。

| 软件列表          | 用途                   |
| ----------------- | ---------------------- |
| VirtualBox-6.1.22 | 虚拟机                 |
| vagrant_2.2.16    | 快速搭建虚拟环境       |
| vagrant-vbguest   | 解决挂载共享失败的问题 |
| Centos 7          | 虚拟环境               |

## 步骤

安装VirtualBox, vagrant

vagrant plugin install vagrant-vbguest

```bash
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# 将 SELinux 设置为 permissive 模式（相当于将其禁用）
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet


```

# 执行配置k8s阿里云源
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

## 下载到指定文件

```bash
curl.exe -Lo ubuntu-trusty64-vagrant.box https://app.vagrantup.com/ubuntu/boxes/trusty64/versions/20190514.0.0/providers/virtualbox.box

```

## ERROR umount: /mnt: not mounted 问题解决

```bash
vagrant plugin uninstall vagrant-vbguest
vagrant plugin install vagrant-vbguest --plugin-version 0.21
```
