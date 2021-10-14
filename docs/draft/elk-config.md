# ELK

[ELK基础知识](https://www.cnblogs.com/fbtop/p/11005469.html)

[ELK基础知识大同小异](https://blog.csdn.net/u011665991/article/details/109494752)

[Beats之FileBeat+Logstash读取Spring boot日志](https://www.cnblogs.com/victorbu/p/13046532.html)
[Logstash日期时区指定](https://www.zybuluo.com/StrGlee/note/1179723)

[Beats之FileBeat+Redis+Logstash读取Spring boot日志](https://www.jianshu.com/p/a55dee5aecd2)

[LogStash-JDBC 同步篇](https://juejin.cn/post/6987574937338773541)

[使用docker-compose创建安全的ELK](https://github.com/swimlane/elk-tls-docker)

[官网](https://www.elastic.co/)

### ELK是由 Elasticsearch、Logstash和Kibana 三部分组件组成 

Elasticsearch 是个开源分布式搜索引擎，它的特点有：分布式，零配置，自动发现，索引自动分片，索引副本机制，restful风格接口，多数据源，自动搜索负载等。

Logstash 是一个完全开源的工具，它可以对你的日志进行收集、分析，并将其存储供以后使用 

kibana 是一个开源和免费的工具，它可以为 Logstash 和 ElasticSearch 提供的日志分析友好的 Web 界面，可以帮助您汇总、分析和搜索重要数据日志。

Filebeat 是用于单用途数据托运人的平台。它们以轻量级代理的形式安装，并将来自成百上千台机器的数据发送到 Logstash 或 Elasticsearch。

Metricbeat是一个开源和免费的工具，定期收集操作系统或应用服务的指标数据，存储到Elasticsearch中，进行实时分析。Metricbeat组成：Metricbeat有2部分组成，一部分是Module，另一部分为Metricset。

 Docker 镜像统一从 <https://hub.docker.com/> 下载 **（安装时请使用统一版本） 用的是目前最新的版本 7.9.3**

**本环境部署在测试服务器，关于docker的一些使用请自行百度，安装的时候注意防火墙的端口，我这里直接关闭了防火墙**

### <a name="t1"></a>**一**、Docker 安装 Elasticsearch

官网镜像地址：<https://hub.docker.com/_/elasticsearch>

> ```
> **# 下载镜像 查看镜像**
> docker pull logstash:7.9.3
>
> docker images
> ```

### <a name="t2"></a>![](https://img-blog.csdnimg.cn/20201104172456205.png)

> **在工作目录建立一个 docker 目录 并在里面创建了 logstash 目录，用来存放所有配置**

![](https://img-blog.csdnimg.cn/20201104172705222.png)

> **# 创建自定义的网络(用于连接到连接到同一网络的其他服务(例如Kibana))**
> docker network create somenetwork
>
> **# 运行 elasticsearch**
> docker run -d --name elasticsearch --net somenetwork -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:7.9.3
>
> **# 查看容器状态**
> docker ps

![](https://img-blog.csdnimg.cn/20201104173014494.png) 

> **# 检测 elasticsearch 是否启动成功**
>
> curl 127.0.0.1:9200

![](https://img-blog.csdnimg.cn/20201104173259290.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE2NjU5OTE=,size_16,color_FFFFFF,t_70)

```
**Elasticsearch 安装启动完成**
```

二、Docker 安装 Kibana

官网镜像地址：<https://hub.docker.com/_/kibana>

使用和 elasticsearch 相同版本镜像 7.9.3 （不一样可能会出现问题）

> ```
> **# 下载镜像 查看镜像**
> docker pull kibana:7.9.3
>
> docker images
> ```

![](https://img-blog.csdnimg.cn/20201104172456205.png)

注意:在本例中，Kibana使用默认配置，并希望连接到正在运行的Elasticsearch实例http://localhost:9200 (建议将localhost替换为本机IP)

```
 `1.  # 运行 kibana
2.  docker run -d --name kibana --net somenetwork -p 5601:5601 kibana:7.9.3

4.  # 查看容器启动状态
5.  docker ps`
```

 ![](https://img-blog.csdnimg.cn/20201104181529863.png)

访问 http://服务器IP:5601  （启动可能会较慢，如失败等几秒再尝试刷新一下）

![](https://img-blog.csdnimg.cn/img_convert/8713c42a679a9b87f24d033a10dd5537.png)

Kibana 安装启动完成

> PS：默认 kibana的界面是英文，设置过程也比较简单：
>
> 修改kibana的配置文件（config/kibana.yml），在最下方将原先的
>
> i18n.locale: "en" 改为 i18n.locale: "zh-CN"
>
> 设置好后重启kibana的docker。

![](https://img-blog.csdnimg.cn/20201105105005182.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE2NjU5OTE=,size_16,color_FFFFFF,t_70)

三、Docker 安装 Logstash

官网镜像地址：<https://hub.docker.com/_/logstash>

使用同版本镜像 7.9.3

> ```
> **# 下载镜像 查看镜像**
> docker pull logstash:7.9.3
>
> docker images
> ```

![](https://img-blog.csdnimg.cn/20201104182206697.png)

```
我在工作目录建立一个 docker 目录 并在里面创建了 logstash 目录，用来存放所有配置
```

![](https://img-blog.csdnimg.cn/20201104172705222.png)

> **`里面放了 logstash 的配置文件`**

 ![](https://img-blog.csdnimg.cn/20201104182334937.png)

> ```
> **logstash.yml (文件内容)**
>
> ```

```
 `1.  path.config: /zhxxxxg/docker/logstash/conf.d/*.conf
2.  path.logs: /var/zhxxxxg/dokcer/log/logstash
3.  pipeline.ordered: auto`
```

> ```
> **conf.d/test.conf (文件内容)**
>
> ```

```
 `1.  input {
2.  gelf {
3.  port => 9200
4.  }
5.  }
6.  output {
7.  stdout{codec =>rubydebug}
8.  elasticsearch {
9.  hosts => ["192.168.100.175:9200"]
10. index => "logstash-log4j2-%{+YYYY.MM.dd}"
11. #    user => "elastic"
12. #    password => "elastic"
13. }
14. }`
```

> **启动 Logstash**
>
> docker run -it -d -p 5044:5044 --name logstash --privileged=true  --net somenetwork -v /zhxxxxxg/docker/logstash/logstash.yml:/usr/share/logstash/config/logstash.yml -v /zhxxxxxg/docker/logstash/conf.d/:/usr/share/logstash/conf.d/ logstash:7.9.3 bash
>
> **查看容器运行状态**
> docker ps

![](https://img-blog.csdnimg.cn/20201104182753863.png)

```
启动成功
```

> **PS:**此处有个注意点，启动会提示找不到 **/usr/share/logstash/config/logstash.yml** 文件，注意需要添加-**-privileged=true**参数

四、Docker 安装Metricbeat

官网镜像地址：<https://hub.docker.com/_/metricbeat>

*使用同版本镜像 7.9.3*

> **# 下载镜像 查看镜像**
> docker pull docker.elastic.co/beats/metricbeat:7.9.3
>
> docker images

![](https://img-blog.csdnimg.cn/2020110418422417.png)

> # 下载默认官方配置文件 (暂时在当前目录创建一个 filebeat 目录 用来放 filebeat 配置文件)
>
> curl -L -O https://raw.githubusercontent.com/elastic/beats/7.9/deploy/docker/metricbeat.docker.yml

> PS: 这里有时这个配置文件下载不下来，这里提供下配置文件内容
>
> vim metricbeat.docker.yml

```bash
 metricbeat.modules:
 - module: system
 period: 10s
 metricsets:
 - cpu
 - load
 - memory
 - network
 - process
 - process_summary
 #- core
 #- diskio
 #- socket
 processes: ['.*']
 process.include_top_n:
 by_cpu: 5      # include top 5 processes by CPU
 by_memory: 5   # include top 5 processes by memory
 - module: system
 period: 1m
 metricsets:
 - filesystem
 - fsstat
 processors:
 - drop_event.when.regexp:
 system.filesystem.mount_point: '^/(sys|cgroup|proc|dev|etc|host|lib)($|/)'
 - module: system
 period: 15m
 metricsets:
 - uptime
 # 直接发送elasticsearch
 output.elasticsearch:
 hosts: ["192.168.100.175:9200"]
 # 要加载仪表板，可以在metricbeat设置中启用仪表板加载。当仪表板加载被启用时，Metricbeat使用Kibana API来加载样本仪表板。只有当Metricbeat启动时，才会尝试仪表板加载。
 # 设置kibana服务地址
 setup.kibana.host: "192.168.100.175:5601"
 # 加载默认的仪表盘样式
 setup.dashboards.enabled: true
 # 设置如果存在模板，则不覆盖原有模板
 setup.template.overwrite: false`
```

> **启动metricBeat**
>
> 进入到  **metricbeat.docker.yml** 所在路径，执行如下命令

```bash
 docker run -d --privileged=true\
 --net somenetwork\
 --name=metricbeat\
 --user=root\
 --volume="$(pwd)/metricbeat.docker.yml:/usr/share/metricbeat/metricbeat.yml:ro"\
 --volume="/var/run/docker.sock:/var/run/docker.sock:ro"\
 --volume="/sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro"\
 --volume="/proc:/hostfs/proc:ro"\
 --volume="/:/hostfs:ro"\
 docker.elastic.co/beats/metricbeat:7.9.3`
```

> **查看容器运行状态**
> docker ps | grep me

![](https://img-blog.csdnimg.cn/20201105105143279.png)

启动成功

-   检查metricbeat是否正常运行：curl -XGET '<http://192.168.100.175:9200/metricbeat-*/_search?pretty>'（返回索引对应内容）

-   配置仪表盘

![](https://img-blog.csdnimg.cn/20201105110718459.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE2NjU5OTE=,size_16,color_FFFFFF,t_70)

![](https://img-blog.csdnimg.cn/20201105110822810.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE2NjU5OTE=,size_16,color_FFFFFF,t_70)

五、Docker 安装 Filebeat 

PS: filebeat采集了所在服务的日志情况，单独部署在另外一台服务器上面

官网镜像地址：<https://hub.docker.com/_/filebeat>

使用同版本镜像 7.9.3

> **# 下载镜像 查看镜像**
> docker pull store/elastic/filebeat:7.9.3
>
> docker images

![](https://img-blog.csdnimg.cn/20201105105303662.png)

> # 下载默认官方配置文件 (暂时在当前目录创建一个 filebeat 目录 用来放 filebeat 配置文件)
>
> curl -L -O https://raw.githubusercontent.com/elastic/beats/7.1/deploy/docker/filebeat.docker.yml
>
> # 打开配置文件 vim filebeat.docker.yml

![](https://img-blog.csdnimg.cn/20201105105647174.png)

> # 增加下面的配置 (收集 .log 数据 把数据发送到当前网络5044端口 (logstash 端口) )
> # 这个地方的 .log 要保证有几条测试数据

```bash
 filebeat.config:
 modules:
 path: ${path.config}/modules.d/*.yml
 reload.enabled: false
 filebeat.autodiscover:
 providers:
 - type: docker
 hints.enabled: true
 processors:
 - add_cloud_metadata: ~
 #output.elasticsearch:
 #  hosts: ['192.168.100.175:9200']
 #  username: '${ELASTICSEARCH_USERNAME:}'
 #  password: '${ELASTICSEARCH_PASSWORD:}'
 #
 filebeat.inputs:
 - type: log
 enabled: true
 paths:
 - /opt/financials/logs/financials.log #项目服务的日志
 output.logstash:
 hosts: ['192.168.100.175:5044']`
```

> ```
> **# 运行Filebeat**
>
> ```

```bash
 docker run
 --name filebeat
 --user=root -d  --volume="/opt/financials/logs/:/var/log/financials/"
 --volume="/root/elk/docker/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro"
 --volume="/var/run/docker.sock:/var/run/docker.sock:ro" store/elastic/filebeat:7.9.3`
```

```
`**# 查看容器启动状态**docker ps`
```

![](https://img-blog.csdnimg.cn/20201105110302908.png)

```
启动成功

现在去 Kibana 查看数据，已经有数据了
```

![](https://img-blog.csdnimg.cn/img_convert/a80326da21b55da123079337c5dcd084.png)


