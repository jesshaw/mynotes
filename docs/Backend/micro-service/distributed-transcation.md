# 分布式事务

## 事务

![事务](./assets/transcation.drawio.svg)

https://www.cnblogs.com/crazymakercircle/p/13917517.html

## 内存模型和GC算法

https://www.cnblogs.com/crazymakercircle/p/14365820.html  搜索 说一下 JVM 有哪些垃圾回收算法

### JVM内存模型

![JVM内存模型图](../java/core-java/assets/jvm.drawio.svg)

### GC算法

#### 标记-清除算法

标记无用对象，然后进行清除回收。缺点：效率不高，无法清除垃圾碎片。

#### 复制算法

按照容量划分二个大小相等的内存区域，当一块用完的时候将活着的对象复制到另一块上，然后再把已使用的内存空间一次清理掉。缺点：内存使用率不高，只有原来的一半。

#### 标记-整理算法

标记无用对象，让所有存活的对象都向一端移动，然后直接清除掉端边界以外的内存。

#### 分代算法

根据对象存活周期的不同将内存划分为几块，一般是新生代和老年代，新生代基本采用复制算法，老年代采用标记整理算法。

#### G1

分成多个回收块，每个回收按分代算法回收

## Java鉴权与安全机制

https://cloud.tencent.com/developer/article/1638035

因为 http 协议，它是一种无状态的协议，在服务器端并不知道客户端的那一头，是谁在请求服务器。而服务器上的资源，有时候并不是向所有人开放的，而是仅对部分人开放的，在这种情况下，实现用户的登陆鉴权，就成了一种必要的需求。目前，我们在开发中主要使用过 4 种鉴权方式。

### Authentication

第 1 种方式，是最简单的 Authentication，这种方式，在客户端会弹出一个登录窗口，由用户输入用户名和密码，进行登录。但这种方式使用基本的 base64 加密，账号很容易泄露。在十几年前还能看到有人使用，现在已经很少使用了。

### session-cookie

第 2 种方式，是使用 session-cookie 机制。这种方式 session 是在服务器端创建的，可以存在内存里面，也可以持久化到数据库里面。而 cookie 是存在用户浏览器里的 sessionId。这个 sessionId 一经创建，就在后面的每次 http 请求中，都带在请求头当中。服务器就是靠这种标识，来区别客户端是哪一个的。

### Token

第 3 种方式，就是 Token 验证。在这里 Token 是令牌的意思。这种验证是在 App 兴起以后发展起来的，因为在 App 里没有浏览器环境，没有 cookie，那么客户端在进行了权限验证以后，就把这个登录凭证，也就是 Token 直接存在了客户端，并且在每次请求服务器的时候都把它带上。最常用的 Token 验证方式，就是 JWT，它是 Json Web Token 的简写。

### OAuth

第 4 种方式，就是 OAuth 验证。这种方式在今天是非常常见了。我们经常看到一些网站登录的时候，可以使用 QQ 或者微信登录，这种登录方式本身就是 OAuth 验证。还有我们在小程序里面，使用微信一键登录的时候，就是这种验证方式。

在第 4 种方式中，我们先向鉴权服务器请求，拿到了一个 code。这个 code 代表的是用户的许可，然后再以这个 code，加上开发者自己的 appId 与 appSecret，再请求鉴权服务器拿到一个 Access Token，这个才是一个真正的 Token。有了这个 Token，才可以把加密的用户信息解密出来。

其实在手机上除了以上 4 种验证方式，还有人脸识别、声纹识别、指纹验证等新的验证方式。但这些方式，和前面的第 4 种方式其实并没有本质区别。

这 4 种方式，反映了互联网的发展历程。

第 1 种方式，这是一种最简单的用户名密码验证方式，反映了人们对信息私有化的需求，这是在互联网出现以后产生的需求。

第 2 种方式，以及加密算法的出现，反映了在公开的互联网上，人们对隐私、对信息保密的重视。这个时期单点登陆技术的出现，标志着互联网向分布式发展，开始出现海量用户产品。

第 3 种方式代表了移动互联网的崛起。

第 4 种方式代表了大平台作为基础账号存在，已经变成了一种事实，像 QQ、微信、Facebook 等等。

接下来随着 5G 网络的发展，随着物联网的崛起，可能会出现一种新的验证方式。这种新的鉴权方式，可能是一种综合的生物验证。当你进入一个环境，你的容貌、声音、气味等生物特征，自动为你完成了权限验证，这种验证是无感知的，无打扰的和无阻塞的。

## Docker

### Dockerfile的主要指令

https://www.cnblogs.com/tianyamoon/articles/10192776.html

**FROM** 通常情况下，你要创建的镜像是基于另外一个镜像的，这就需要使用FROM，当然也可以完全从头创建。
**MAINTAINER** 该镜像的维护人。
**RUN** 这里可以定义一些需要运行的命令。例如npm install，dotnet restore等等。
**COPY** 开发的时候，可以把源码放在Volumes里。而在生产环境下，经常需要把源码复制到容器里面，使用COPY就可以做到这点。
**ENTRYPOINT** 它可以定义容器的入口，把容器配置成像exe一样的运行文件。通常是一些例如dotnet 命令，node命令等等。
**CMD** 设置容器运行的默认命令和参数。当容器运行的时候，这个可以在命令行被覆盖。
**WORKDIR** 设定容器运行的工作目录。
**EXPOSE** 暴露端口。
**ENV** 设定环境变量。
**VOLUME** 定义Volume，并控制如何在宿主中进行存储。

## 主流架构模式和微服务理论

### 主流架构模式

https://www.cnblogs.com/IcanFixIt/p/7518146.html

| 名称 | 场景 | 优点 | 缺点 |
| --- |  --- |--- |  --- |
| 分层模式 |桌面应用程序，电商web应用程序 | 一个较低的层可以被不同的层所使用。层使标准化更容易，因为我们可以清楚地定义级别。可以在层内进行更改，而不会影响其他层。 | 不是普遍适用的。在某些情况下，某些层可能会被跳过。 |
| 客户端-服务器模式 | 电子邮件，文件共享 | 很好地建立一组服务，用户可以请求他们的服务。 | 请求通常在服务器上的单独线程中处理。由于不同的客户端具有不同的表示，进程间通信会导致额外开销。 |
| 主从设备模式 | 高可用数据库 | 准确性------将服务的执行委托给不同的从设备，具有不同的实现。 | 从设备是孤立的：没有共享的状态。主-从通信中的延迟可能是一个问题，例如在实时系统中。这种模式只能应用于可以分解的问题。 |
| 管道-过滤器模式 |linux的管道命令，生物信息学的工作流 | 展示并发处理。当输入和输出由流组成时，过滤器在接收数据时开始计算。轻松添加过滤器，系统可以轻松扩展。过滤器可重复使用。 可以通过重新组合一组给定的过滤器来构建不同的管道。 | 效率受到最慢的过滤过程的限制。从一个过滤器移动到另一个过滤器时的数据转换开销。 |
| 代理模式 |消息代理，如RocketMQ,Kafka等 | 允许动态更改、添加、删除和重新定位对象，这使开发人员的发布变得透明。 | 要求对服务描述进行标准化。 |
| 点对点模式 |多媒体协议，如P2PTV | 支持分散式计算。对任何给定节点的故障处理具有强大的健壮性。在资源和计算能力方面具有很高的可扩展性。 | 服务质量没有保证，因为节点是自愿合作的。安全是很难得到保证的。性能取决于节点的数量。 |
| 事件总线模式 |APP开发，通知服务 | 新的发布者、订阅者和连接可以很容易地添加。对高度分布式的应用程序有效。 | 可伸缩性可能是一个问题，因为所有消息都是通过同一事件总线进行的。 |
| 模型-视图-控制器模式 |Spring MVC框架 | 可以轻松地拥有同一个模型的多个视图，这些视图可以在运行时连接和断开。 | 增加复杂性。可能导致许多不必要的用户操作更新。 |
| 黑板模式 |语音识别，车辆识别和跟踪，蛋白质结构识别 | 很容易添加新的应用程序。扩展数据空间的结构很简单。 | 修改数据空间的结构非常困难，因为所有应用程序都受到了影响。可能需要同步和访问控制。 |
| 解释器模式 |SQL，描述通信协议的语言 | 高度动态的行为是可行的。对终端用户编程性提供好处。提高灵活性，因为替换一个解释程序很容易。 | 由于解释语言通常比编译后的语言慢，因此性能可能是一个问题。 |

### 微服务理论

https://cloud.tencent.com/developer/article/1573096

1. 组织沟通方式决定系统设计
2. 敏捷开发解决能解决的问题
3. 做独立自治的系统
4. 分而冶之

#### 康威定律

第一定律

Communication dictates design
组织沟通方式会通过系统设计表达出来

第二定律

There is never enough time to do something right, but there is always enough time to do it over
时间再多一件事情也不可能做的完美，但总有时间做完一件事情

第三定律

There is a homomorphism from the linear graph of a system to the linear graph of its design organization
线型系统和线型组织架构间有潜在的异质同态特性

第四定律

The structures of large systems tend to disintegrate during development, qualitatively more so than with small systems
大的系统组织总是比小系统更倾向于分解

#### 衡量微服务的标准

再对应下衡量微服务的标准，我们很容易会发现他们之间的密切关系：

- 分布式服务组成的系统
- 按照业务而不是技术来划分组织
- 做有生命的产品而不是项目
- Smart endpoints and dumb pipes（我的理解是强服务个体和弱通信）
- 自动化运维（DevOps）
- 容错
- 快速演化
