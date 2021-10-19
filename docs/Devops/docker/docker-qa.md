# Docker日常问题

## docker-compose和docker网络的区别

docker-compose不指定网络会创建以服务名命名的网络

docker不指定网络会使用名为bridge的网络

## Java应用不能获取到Host的IP

指定hostname和add-host即可

```bash
docker run  **.jar --add-host hostname:10.10.0.5 --hostname hostname
```

[引用]( https://stackoverflow.com/questions/27087786/java-application-cannot-get-ip-address-of-the-host-in-docker-container-with-stat)

## docker ps 为什么看不到端口

[详细解答点击跳转](docker_network.md)

## Docker中的COPY和ADD的区别

`COPY`命令是为最基本的用法设计的，概念清晰，操作简单。而 `ADD` 命令基本上是 `COPY` 命令的超集(**除了 multistage 场景**)，可以实现一些方便、酷炫的拷贝操作。ADD 命令在增加了功能的同时也增加了使用它的复杂度，比如从 url 拷贝压缩文件时弊大于利。

[参考](https://www.cnblogs.com/sparkdev/p/9573248.html)

## Docker执行build时超慢

考虑是否由于引用国外的文件下载慢的原因，使用**国内镜像**

```bash
#### alpine指定镜像

# 阿里云
sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 中国科技大学的源
sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# 清华源
sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories


#### python插件指定镜像

# 阿里源
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/

# 清华源
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple


# 腾讯源
pip config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple

# 豆瓣源
pip config set global.index-url http://pypi.douban.com/simple/
```
