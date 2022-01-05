# 局域网（任一机器）访问virtalbox虚拟机

## 背景

公有云资源有限，利用现有资源搭建私有云平台。首先得确保虚拟机能被局域网访问。

## 方案

桥接+host only

桥接解决暴露和访问外网的问题

host only解决虚拟机互访

## 关键配置

桥接是指指定桥接网卡为连接的物理网卡（可以是无线，也可以有线）。

给对应网卡须指定网关，否则可能导致访问不了外网。**网关与局域网一致**。

```yaml
# soure 50-vagrant.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses:
      - 10.129.223.201/24
      dhcp4: no
      gateway4: 10.129.223.1
      nameservers:
         addresses:
         - 114.114.114.114
         - 8.8.8.8
```

应用新的配置

```bash
$ pwd
/etc/netplan
# 应用新的配置
$ netplan apply
# 查看当前解析配置
$ ll /etc/resolv.conf
lrwxrwxrwx 1 root root 39 Jul  7 23:49 /etc/resolv.conf -> ../run/systemd/resolve/stub-resolv.conf
# 查看当前在用的DNS服务
$ resolvectl status
# 全局DNS服务配置（无须配置）
/etc/systemd/resolved.conf
# 应用全局配置
$ systemctl restart systemd-resolved
```


network:
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
      - 10.129.223.208/24
      gateway4: 10.129.223.1
      nameservers:
         addresses:
         - 114.114.114.114
         - 8.8.8.8
  version: 2

## 参考

[VirtualBox 网络设置：完整指南](https://www.nakivo.com/blog/virtualbox-network-setting-guide/)
[virtual box中的ubantu的网址配置](https://www.jianshu.com/p/cd527a68e487)