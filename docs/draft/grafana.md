# Grafana

原文：https://cloud.tencent.com/developer/article/1807679

## Grafana 是什么

Grafana 是一个监控仪表系统，它是由 Grafana Labs 公司开源的的一个系统监测 (System Monitoring) 工具。它可以大大帮助你简化监控的复杂度，你只需要提供你需要监控的数据，它就可以帮你生成各种可视化仪表。同时它还有报警功能，可以在系统出现问题时通知你。

Grafana 不对数据源作假设，它支持以下各种数据，也就是说如果你的数据源是以下任意一种，它都可以帮助生成仪表。同时在市面上，如果 Grafana 称第二，那么应该没有敢称第一的仪表可视化工具了。因此，如果你搞定了 Grafana，它几乎是一个会陪伴你到各个公司的一件称心应手的兵器。

### Grafana 支持的数据源

- Prometheus 本文中的例子，你没听过也没关系不影响阅读，把它想象成带时间戳的 MySQL 就好
- Graphite
- OpenTSDB
- InfluxDB
- MySQL/PostgreSQL
- Microsoft [SQL Server](https://cloud.tencent.com/product/sqlserver?from=10680)
- 等等

## 什么情况下会用到 Grafana 或者监控仪表盘

通常来说，对于一个运行时的复杂系统，你是不太可能在运行时一边检查代码一边调试的。因此，你需要在各种关键点加上监控。

用开车作为例子：车子本身是一个极其复杂的系统，而当你的车在高速上以 120 公里的速度狂奔时出现了噪音，你是不可能这时候边开车边打开发动机盖子来查原因的。通常来说，好一点的车会有内置电脑，在车子出问题时，告诉你左边轮胎胎压有问题，或是发动机缺水了之类。而这些检测，就是系统监控的一个例子。

对于驾驶员来说，他们开车时只关心几个指标：

1. 我的位置是哪里，在路中间么（当然这个无法通过监控系统实现，得看路）
2. 我的速度是多少 - 速度仪表盘
3. 我的油、发动机水温等等关键指标是多少 - 其它仪表盘

通过仪表盘，你不一定能清楚地了解车子出问题的具体原因，但至少可以给你一个大概的方向。比如说，如果水温很高时出现了问题，你大概率可以尝试加点水降温来尝试是否解决问题。

把上面的车换成计算机系统或者一个软件系统也是一样：仪表盘就是你的速度表和水温表，通过这些表盘你可以实时了解你的系统运行情况。

仪表盘应用极广，我能想到的一些例子：

1. 阿里在双十一控制室用了监控仪表盘，因此所有双十一的新闻基本上都可以看到这个仪表盘
2. 各酷炫公司大厅里常常放一个仪表盘来展示实力（用户数啦、营收啦之类）
3. 你的 PC 上的资源管理器、Mac 上的 Activity Monitor 都是某种意义上的仪表盘

用一个卡拉搜索的实践作例子：

我们希望卡拉搜索能提供游戏级的搜索性能，比 Elastic Search 还快十倍。那么这就要求我们 99% 的搜索结果在 5-10 毫秒内要完成。因此，我们就需要添加这么一个仪表盘，能实时知道用户搜索的延迟，并且当搜索延迟超过 10 毫秒时通知到我们。

综上，在任何需要监控系统运行状况的地方就大概率会用到仪表盘，而用到仪表盘的时候就可以用 Grafana （不管你用什么语言）

## 安装和配置 Grafana

为了简化各种系统不一致的乱七八糟问题，我们用 Docker 来安装 Grafana。（如果还没有安装 Docker 可以参考我们的教程 [如何安装 Docker](/tutorials/how-to-install-and-use-docker-on-ubuntu）。

Docker 的配置文件如下，就算你从来没用过 docker 也不用操心，我会在下文里一行一行讲明白。请不要复制粘贴代码，直接到本文的 GitHub 页 clone 代码即可，我会保证 GitHub 上的代码处理最新状态：**https://github.com/Kalasearch/grafana-tutorial[5]**

```yml
version: '3.4'
services:
  prometheus:
    image: prom/prometheus
    container_name: prometheus
    hostname: prometheus
    ports:
      - 9090:9090
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
  prometheus-exporter:
    image: prom/node-exporter
    container_name: prometheus-exporter
    hostname: prometheus-exporter
    ports:
      - 9100:9100
  grafana:
    image: grafana/grafana
    container_name: grafana
    hostname: grafana
    ports:
      - 3000:3000
    volumes:
      - ./grafana.ini:/etc/grafana/grafana.ini
```

在这里我们启动了三个服务

- Prometheus 普罗米修斯时序数据库，用来存储和查询你的监控数据
- Promethues-exporter 一个模拟数据源，用来监控你本机的状态，比如有几个 CPU，CPU 的负载之类
- Grafana 本尊

在 clone 了代码之后，在你的本地运行 `docker-compose up`，应该会看到类似：

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/5l70vw7s93.png?imageView2/2/w/1620)</figure>

那么就说明服务已经跑起来了。注意，在之后的所有步骤中，你的 docker 应该处于运行状态。

在跑起来服务之后，到你的浏览器中，复制 `http://localhost:3000` 应该就可以看到 Grafana 跑起来的初始登录界面。初始的用户名是 `admin`，密码也是 `admin`。输入之后，会要求你改密码

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/o23qyhy87w.png?imageView2/2/w/1620)</figure>

然后就可以进入 Grafana 的主界面了：

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/wlhy7bshf1.png?imageView2/2/w/1620)</figure>

到这里，你的 Grafana 就已经搭起来了。注意到 Docker 的配置文件中我们创建了三个服务，这三个服务之间分别有什么关系呢？

或者说，Grafana 和时序数据库，数据源之间有什么关系呢？请看下文 **Grafana 工作原理**

## Grfana 工作原理

上面说到，Grafana 是一个仪表盘，而仪表盘必然是用来显示数据的。

Grafana 本身并不负责数据层，它只提供了通用的接口，让底层的数据库可以把数据给它。而我们起的另一个服务，叫 Prometheus （中文名普罗米修斯数据库）则是负责存储和查询数据的。

也就是说，Grafana 每次要展现一个仪表盘的时候，会向 Prometheus 发送一个查询请求。

那么配置里的另一个服务 `Prometheus-exporter` 又是什么呢？

这个就是你真正监测的数据来源了，`Prometheus-exporter` 这个服务，会查询你的本地电脑的信息，比如内存还有多少、CPU 负载之类，然后将数据导出至普罗米修斯数据库。

在真实世界中，你的目的是监控你自己的服务，比如你的 Web 服务器，你的数据库之类。

那么你就需要在你自己的服务器中把数据发送给普罗米修斯数据库。当然，你完全可以把数据发送给 MySQL (Grafana 也支持)，但普罗米修斯几乎是标配的时序数据库，强烈建议你用。

用**一张图[6]**来说明它们之间的关系：
![cc](https://ask.qcloudimg.com/http-save/yehe-6849268/04gp0xam9c.png?imageView2/2/w/1620)

这里，最左边的 Docker 服务会将服务的数据发送给中间的普罗米修斯（对应上文的 `Prometheus-exporter`），而最右边的 Grafana 会查询中间的普罗米修斯，来展示仪表盘。

关于普罗米修斯本身也可以写一篇很长的教程了，这里我们先暂时略去不表。请关注我们的**技术博客[7]**或公众号 (**HiXieke**)，之后我们会继续展开讲。

## 搭建你的第一个仪表盘

现在我们来搭建你的第一个仪表盘。

### **第 1 步 - 设置数据源**

进入 Grafana 后，在左侧你会发现有一个 Data Source 即数据源选项

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/7rh9gtnq4v.png?imageView2/2/w/1620)</figure>

点击后进入，点 `Add Data Source` 即添加数据源，选择 `Prometheus`

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/bbg4qmh6t1.png?imageView2/2/w/1620)</figure>

之后设置数据源 URL。请注意，Promethues 的工作原理（下一个教程中会讲）是通过轮询一个 HTTP 请求来获取数据的，而 Grafana 在获取数据源的时候也是通过一个 HTTP 请求，因此这个地方你需要告诉 Grafana 你的 Prometheus 的数据端点是什么。

这里我们填入 `http://prometheus:9090` 就可以了。

> 你可能会问，为什么不是 `localhost:9090` 呢？原因是，我们用了 `docker-compose` 起的三个服务，可以把它们想象成三台独立的服务器，因此需要用一个域名来互相通信。我们在 docker-compose.yml 中设置的普罗米修斯服务器的名字就叫 `prometheus`，因此这里需要用前者。

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/fxk6k55xxz.png?imageView2/2/w/1620)</figure>

点确认时一定要确认出现 `Data source is working` 这个检测，这时表明你的 Grafana 已经跟普罗米修斯说上话了

### **第 2 步 - 导入 Dashboard**

在 Grafana 里，仪表盘的配置可以通过图形化界面进行，但配置好的仪表盘是以 JSON 存储的。这也就是说，如果你把你的 JSON 数据分享出去，别人导入就可以直接导入同样的仪表盘（前提是你们的监测数据一样）。

对于我们的例子来说，回忆一下，因为我们用了 `prometheus-exporter` 也就是本机的系统信息监控，那么我们可以先找一个同样用了这个数据源的仪表盘。在 Grafana 网站上，你其实可以找到很多别人已经做好的仪表，可以用来监测非常多标准化的服务。

Grafana 的仪表盘市场：**https://grafana.com/grafana/dashboards[8]**

比如说针对以下一些服务的标准仪表盘就可以在这里找到

-   JVM
-   Spring Boot
-   MySQL 监控
-   Laravel 监控

那么，这里我们就用一个标准的仪表盘：**https://grafana.com/grafana/dashboards/1860[9]**

在左侧的加号里，点 `Import` 即导入，在出现的界面中填入 `1860` 即我们要导入的仪表盘编号即可。

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/k11ppq033u.png?imageView2/2/w/1620)</figure>

然后填入你需要的信息，比如仪表盘名字等

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/dlkuzf5t6u.png?imageView2/2/w/1620)</figure>

确认之后 Grafana 就会根据你的本机信息，生成类似 CPU 负载，内存和 I/O 之类的信息。我的磁盘状况如图：

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/gb639nfsbx.png?imageView2/2/w/1620)</figure>

要注意的是，这里的信息真正监控的是你的 Docker 中的系统信息。如果你只给你的 Docker 分配 1 个核和 2G 内存，那么这里应该看到的就是 1 个核和 2G 内存

### **第 3 步 - 生成和创建新的仪表盘**

最后，在上面导入信息的基础上，你就可以开始创建和你的服务、业务相关的仪表盘了。

但在这步之前，你需要先在你的服务中开始记录一些数据。

#### **如何在各种语言中记录你关注的数据？**

拿卡拉搜索举例子，我们关注用卡拉搜索的 APP 的搜索响应速度，所以自然我们需要在所有搜索请求处记录延迟。

对于你的服务，你需要根据自己的业务确认哪些数据是重要的，关于如何记录数据，如何思考运维等，我会在之后的博客中继续深入讨论。如果你想更深入地了解这个领域，推荐阅读 Google 运维手册这本书，英文名叫《Google SRE Book》，免费的书。

#### **包括如何用 Prometheus 查询数据**

普罗米修斯本身也是个非常大的话题，我们会在之后的博客中继续讨论。普罗米修斯包括所有其它时序数据库通常都会定义一个查询语言，比如说 PromQL，如果需要熟练地构建仪表盘的话，需要对这个查询语言有一定了解。

#### **如何手动生成一个仪表盘**

假设你已经按上面的步骤生成了一个基本的仪表盘，那么现在可以开始手动添加仪表盘了。同样是点左侧的加号，点 `Dashboard` 就可以进入添加仪表盘的界面。

这里我们选择一个数据叫 `scrape_duration_seconds`，先不用管它的含义是什么，就当它是双 11 的销售额好了：

<figure>![](https://ask.qcloudimg.com/http-save/yehe-6849268/hw0eh0pb0p.png?imageView2/2/w/1620)</figure>

添加好后点右上角的 `Apply` 或 `Save` 你的仪表盘就被保存了。这时候，用一个大屏幕展示一下，庆祝一下双十一又过了千亿吧

## 总结

这篇文章里我们从头到尾介绍了如何用 Grafana 生成仪表盘，如何配置和连接数据源，以及如何导入和创建一个仪表盘。

之后的文章中，我们会介绍在卡拉搜索，我们是怎样监测服务健康状态的，同时我们会介绍 Prometheus 即普罗米修斯时序数据库的用法，欢迎继续关注我们的博客和公众号 (HiXieke)。

如果你的 App 或小程序需要搜索功能，也可以到**卡拉搜索首页[10]**了解一下我们的托管搜索服务。花 5 分钟接入，我们就可以帮你为你的用户提供比 ElasticSearch 还快 10 倍的搜索体验，提高转化率和用户留存。

本文参考了以下文章：

- **How to explore prometheus with easy hello world projects[11]**
- **Node Exporter Guide[12]**
- **Grafana Tutorials[13]**
- **Grafana Simple Synthetic Monitoring[14]**
- **Grafana 快速入门[15]**

### **参考资料**

[1] 卡拉搜索: *https://kalasearch.cn/*

[2] 博客: *https://kalasearch.cn/blog*

[3] Demo: *https://kalasearch.cn/*

[4] Grafana 教程代码: *https://github.com/Kalasearch/grafana-tutorial*

[5] https://github.com/Kalasearch/grafana-tutorial: *https://github.com/Kalasearch/grafana-tutorial*

[6] 一张图: *https://medium.com/@bhargavshah2011/monitoring-docker-containers-using-cadvisor-and-prometheus-5350ae038f45*

[7] 技术博客: *https://kalasearch.cn/blog*

[8] https://grafana.com/grafana/dashboards: *https://grafana.com/grafana/dashboards*

[9] https://grafana.com/grafana/dashboards/1860: *https://grafana.com/grafana/dashboards/1860*

[10] 卡拉搜索首页: *https://kalasearch.cn/*

[11] How to explore prometheus with easy hello world projects: *https://grafana.com/blog/2019/12/04/how-to-explore-prometheus-with-easy-hello-world-projects/*

[12] Node Exporter Guide: *https://prometheus.io/docs/guides/node-exporter/*

[13] Grafana Tutorials: *https://grafana.com/tutorials/*

[14] Grafana Simple Synthetic Monitoring: *https://grafana.com/blog/2019/06/18/grafana-tutorial-simple-synthetic-monitoring-for-applications/*

[15] Grafana 快速入门: *https://ken.io/note/grafana-quickstart-influxdb-datasource-graph*

原文链接：https://kalasearch.cn/blog/grafana-with-prometheus-tutorial/