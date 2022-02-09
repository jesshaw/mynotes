# Ubuntu20.04搭建NFS服务

## NFS概述

NFS 即网络文件系统（Network File-System），可以通过网络让不同机器、不同系统之间可以实现文件共享。通过 NFS，可以访问远程共享目录，就像访问本地磁盘一样。NFS 只是一种文件系统，本身并没有传输功能，是基于 RPC（远程过程调用）协议实现的，采用 C/S 架构。

## Kubernetes服务器清单

之前玩[Kubernetes](https://so.csdn.net/so/search?from=pc_blog_highlight&q=Kubernetes)需要数据持久化，考虑到Kubernetes是在自己虚拟机里面跑的，所以用NFS的存储方案来解决。
顺便记录下NFS的搭建过程，比较简单。

| 主机名 | IP | 角色 | 目录 |
| --- |  --- |  --- |  --- |
| kmaster | 172.42.42.100 | NFS Server | /nfs |
| kworker1 | 172.42.42.101 | NFS Client | /mnt |
| kworker2 | 172.42.42.102 | NFS Client | /mnt |

## 搭建NFS Server

```bash
# kmaster
## 1.安装 NFS服务器端
sudo apt-get install nfs-kernel-server

## 2.把/nfs目录设置为共享目录共享目录
sudo cat /etc/exports
# * 表示允许任何网段 IP 的系统访问该 NFS 目录
/nfs *(rw,sync,no_root_squash)

sudo mkdir /nfs
sudo chmod -R 777 /nfs
## vinson为当前用户
sudo chown -R vinson:vinson /nfs/

## 3.启动NFS服务
sudo /etc/init.d/nfs-kernel-server restart

## 4.测试,在/nfs目录下创建文件
echo "test" >> /nfs/test.txt
```

### 查看NFS服务状态

```bash
showmount -e [hostip]
```

## NFS Client配置

```bash
## kworker1、kworker2
# 1.安装 NFS客户端
sudo apt-get install nfs-common
sudo mount -t nfs 192.168.204.129:/nfs /mnt -o nolock

# 2.开机自动挂载，在/etc/fstab里添加
192.168.204.129:/nfs   /mnt   nfs  rw 0 0

# 3. 测试：在Clietn端cat一下/mnt/test.txt,可以看到文件说明可以了

```

## 参考

[Ubuntu20.04搭建NFS服务](https://blog.csdn.net/baidu_33032485/article/details/114496376)
