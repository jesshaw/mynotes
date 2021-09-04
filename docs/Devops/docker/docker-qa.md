# Docker日常问题

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