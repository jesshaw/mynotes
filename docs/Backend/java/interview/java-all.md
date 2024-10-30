# java面试题集



102，谈谈微服务注册中心zookeeper&Eureka

首先，大家要明确一点微服务注册中心是一个重要的组件，解决的是服务的注册和发现的问题，而zookeeper，Eureka都只是其中一款落地实现的产品，再比如Nacos也是如此，所以关键是掌握注册中心的工作原理，组件的使用，诸如配置，安装，这些都是常规步骤，没有什么特别的。
那下面，我们来谈谈这两个注册中心的工作原理，如果对nacos刚兴趣，可以直接查看官网即可。
1，zookeeper
zookeeper的核心主要是包含两个部分：服务信息的管理和变更通知机制（watch）
所谓的服务注册，就是在zookeeper的服务器上创建一个节点，而且是临时节点，保存着服务的地址信息
为什么是临时节点？
因为一旦服务节点宕机，则zookeeper可以自动将该节点删除
所谓的服务发现，就是去获取zookeeper上面的节点信息，获取到提供该服务的地址列表信息
这样当消费者去调用服务提供者，就可以采用负载均衡策略，去访问其中一个提供者。
所谓监听机制，当服务提供者某个节点发生故障，这个时候服务端的临时节点会被删除，上层的父节点就相当发生了变化，所以可以基于监听机制通知客户端（服务消费者）当前服务列表发生变化了，客户端再次去获取最新的服务列表信息。
下面，我们以图片来说明

2，Eureka
1，包含两个组件
Eureka Server 注册中心服务端，提供了服务的注册和发现（相当于zookeeper的作用）
Eureka Client 注册中心客户端（相当于之前的生产者和消费者）， 需要将本身提供的服务注册到EurekaServer
2，两个关键的时间参数
一个是每隔30s，客户端会发送心跳包给EurekaServer，告知健康状态，表示还活着；
一个是每隔30s，客户端会去找EurekaServer拉取最新的注册表信息，刷新本地的缓存列表；

3，两者集群模型的差别
注册中心作为微服务架构中非常关键的组件，所以其可用性非常重要，所以我们来简单说说其集群架构的区别
zookeeper，奇数台做集群，CP（强一致性）
eureka，只需要两台以上即可，AP（可用性）
CAP是分布式系统的基本参考原则，如果你之前对这个原则不了解，我们后续会再一篇文章来谈谈CAP

101，谈谈互联网常见的负载均衡

负载均衡是我们对应高并发流量的一种常见处理方式
我们分两个方面来聊这个问题，一个是负载均衡的分类，一个是负载均衡的常见算法。
1，负载均衡的分类
基本我们可以分为客户端负载均衡和服务端负载均衡
服务端负载均衡，表示其负载均衡算法是在服务端实现的，比如我们常见的nginx，通过nginx我们可以来管理背后的多台tomcat服务器，从而实现多台tomcat服务共同对外提供服务的效果，如图所示：

客户端负载均衡：
就是表示其负载均衡算法是由调用者来维护，比如Dubbo的Proxy，SpringCloud的Ribbon
2，负载均衡的常见方式
1，轮询
即按照固定顺序，顺序循环访问后台的服务器，比如上述的tomcat1，tomcat2
2，权重
即可以根据后台服务器的硬件差异，配置权重，让性能好的服务器多处理请求
3，最小活跃数
根据服务器的压力，动态调整对请求的处理
4，ip_hash
根据客户端的ip地址做hash运算，找到对应的服务器进行处理
5，一致性hash
相同参数的请求总是发到同一提供者。
当某一台提供者挂时，原本发往该提供者的请求，基于虚拟节点，平摊到其它提供者，不会引起剧烈变动。
算法参见：
http://en.wikipedia.org/wiki/Consistent_hashingen.wikipedia.org

100，谈谈单体架构和微服务架构的区别？一般依据怎样的原则进行微服务的拆分？

首先，微服务架构并非就一定比单体架构好，我一直反对这种没有独立思考的人云亦云的答案，每种架构都有其适用场景。
第一，我们来看看单体架构适用的场景
单体架构特别适合初创公司的初创项目，可以小成本快速试错，且系统模块之间的调用，是进程内的通信，所以整体的性能表现会非常好，所以这类型的项目，我推荐采用单体架构足以，在市场还没有打开之前，采用各类看似高大上的技术，除非是为了卖弄技术，否则毫无意义。
做产品，需要考虑MVP模式，架构除了考虑技术，更应该考虑成本，成本意识是很关键的。
第二，我们来看看，微服务架构适合的场景
当系统经过一段时间的运营之后，如果运气不错，用户量有了一定的增量，业务也随着市场需求有了扩展，从而慢慢的整个系统的业务变得复杂而庞大，这个时候一个系统的启动时间，重新编译的时间，都可能会非常耗时，一个功能的修改也需要做全盘的回归测试，所谓牵一发而动全身，这个时候就适合对系统进行服务拆分，拆分成多个服务子系统，每个子系统可以更灵活做升级。注意！此时原先的模块之间的通信，由原先的进程内通信变为进程间的通信，所以其响应速度会有所影响。
第三，我们再来看看，微服务拆分的原则
一般我们根据业务的边界来拆分，比如按照商品，购物车，订单等等业务边界进行服务的拆分，另外一个，系统中存在的共性基础服务，比如像短信，邮件，日志等等，我们也可以作为单独的服务进行拆分，作为基础服务层供上层服务复用。

99，谈谈自定义注解

注解的内容很多，本次的面试题讲解主要是针对以下几个问题：
1，注解是在编译期生效还是运行期生效？
2，有没有在编译期生效的注解？
3，编译期生效的注解和运行期生效的注解有什么区别？
我们的分析如下：
首先，第一个问题是给面试者挖坑，两者都存在，关键看注解的定义描述；
其次，第二个问题是有，比如我们JDK默认提供注解@Override
我们观察其注解的定义如下
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.SOURCE)
public @interface Override {
}
上面的两个注解说明做下解释：
@Target(ElementType.METHOD) ：表示该注解可以放到方法的定义上
@Retention(RetentionPolicy.SOURCE) ： 表示该注解在编译期有效
那什么是编译期有效？
就好比我们说的@Override，它的作用就是在编译期间，检查我们重写的代码有没有符合语法规则，如果不符合就会通过红线报错，编译失败，而真正到运行期间就没有作用了
最后，说第三个问题
就是运行期的注解有什么用，其实我们用过的很多框架，他们都会提供注解，这些都不是JDK提供的注解，我们统称为自定义注解
比如Springweb提供的 
@RestController
我们观察其注解的定义说明如下：
@Target(ElementType.TYPE) 
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Controller
@ResponseBody
public @interface RestController {
我们可以看到其关键点的描述为：
@Retention(RetentionPolicy.RUNTIME) ： 表示是运行期有效
为什么需要定义为运行期有效？
大家想想，我们创建Controller是不是在服务运行期间才正式对外提供服务的，而Spring容器需要去检查到底哪些Controller可以对外提供服务，那么以这个自定义注解为暗号，一看，咦，你小子有这个注解，行了，你就是可以对外提供服务的人，所以注解必须是在运行期间有效

98，谈谈SpringBoot的工作原理

对技术的探索，一切源于好奇心，保持好奇心，才能让人更年轻。
至今，我们已经有了很多创建SpringBoot项目的经验，比如我们要创建一个支持web开发的项目，我们只需要引入web-starter模块即可。
那么，SpringBoot为什么这么神奇？引入的依赖变少了，配置文件也不见了，但项目却可以正常运行。下面我们一起来探究这背后的逻辑：
1，为什么依赖的依赖变少了？SpringBoot是如何管理这些依赖的？
我们分两个点来看起
1.1 从pom文件出发
首先，是有一个父工程的引用

我们继续往里面跟踪，发现父工程又依赖于另一个父工程

继续跟踪，发现这是一个pom工程，统一控制版本

定义了一堆第三方jar包的版本

结论：
所有我们使用了SpringBoot之后，由于父工程有对版本的统一控制，所以大部分第三方包，我们无需关注版本，个别没有纳入SpringBoot管理的，才需要设置版本号
1.2 SpringBoot将所有的常见开发功能，分成了一个个场景启动器（starter），这样我们需要开发什么功能，就导入什么场景启动器依赖即可。
比如，我们现在要开发web项目，所以我们导入了spring-boot-starter-web

我们来跟踪看看，内部也复用一些starter

还有Springweb和SpringMVC，这也就是为什么，我们就可以开发SpringWeb程序的原因

结论：
	• 大家会发现，SpringBoot是通过定义各种各样的Starter来管理这些依赖的
	• 比如，我们需要开发web的功能，那么引入spring-boot-starter-web
	• 比如，我们需要开发模板页的功能，那么引入spring-boot-starter-thymeleaf
	• 我们需要整合redis，那么引入spring-boot-starter-data-redis
	• 我们需要整合amqp，实现异步消息通信机制，那么引入spring-boot-starter-amqp
	• 等等，就是这么方便

97，说说synchronized的底层原理

synchronized是由一对monitorenter和monitorexit指令来实现同步的，在JDK6之前，monitor的实现是依靠操作系统内部的互斥锁来实现的，所以需要进行用户态和内核态的切换，所以此时的同步操作是一个重量级的操作，性能很低。
但是，JDK6带来了新的变化，提供了三种monitor的实现方式，分别是偏向锁，轻量级锁和重量级锁，即锁会先从偏向锁再根据情况逐步升级到轻量级锁和重量级锁。
这就是锁升级
在锁对象的对象头里面有一个threadid字段，默认情况下为空，当第一次有线程访问时，则将该threadid设置为当前的线程id，我们称为让其获取偏向锁，当线程执行结束，则重新将threadid设置为空。
之后，如果线程再次进入的时候，会先判断threadid与该线程的id是否一致，如果一致，则可以获取该对象，如果不一致，则发生锁升级，从偏向锁升级为轻量级锁
轻量级锁的工作模式是通过自旋循环的方式来获取锁，看对方线程是否已经释放了锁，如果执行一定次数之后，还是没有获取到锁，则发生锁升级，从轻量级锁升级为重量级锁。
使用锁升级的目的是为了减少锁带来的性能消耗。
通过反编译查看字节码，就可以看到相关的指令
javap -verbose Test.class
源码：就是写了synchronized同步代码块控制线程安全
Code:
      stack=2, locals=4, args_size=1
         0: new           #2                  // class java/lang/Object
         3: dup
         4: invokespecial #1                  // Method java/lang/Object."<init>":()V
         7: astore_1
         8: aload_1
         9: dup
        10: astore_2
        11: monitorenter
        12: getstatic     #3                  // Field java/lang/System.out:Ljava/io/PrintStream;
        15: ldc           #4                  // String 获得锁
        17: invokevirtual #5                  // Method java/io/PrintStream.println:(Ljava/lang/String;)V
        20: aload_2
        21: monitorexit
        22: goto          30
        25: astore_3
        26: aload_2
        27: monitorexit
        28: aload_3
        29: athrow
        30: return
synchronized如何保证可见性的？
首先，我们需要知道可见性原理
两个线程如何保证变量信息的共享可见性？需要经历以下的流程
线程A-》本地内存A（共享变量副本）-》主内存（共享变量）
如果有变更，需要将本地内存的变量写到主内存，对方才可以获取到更新。
这个是提前知识。
那么，synchronized是如何保证可见性的
就是当获取到锁之后，每次读取都是从主内存读取，当释放锁的时候，都会将本地内存的信息写到主内存，从而实现可见性

96，Dubbo高频面试题

1，问：当zookeeper挂了之后，生产者和消费者之间还能通信吗？
答：可以。
因为当启动dubbo容器时，消费者会去zookeeper拉取注册的生产者地址列表，并将其缓存在本地。每次发起调用时，都会按照本地的地址列表，以负载均衡的策略去进行调用。
但是如果zookeeper挂掉了，则后续新的生产者无法被消费者发现。
2，问：当监控中心monitor挂了之后，生产者和消费者之间还能通信吗？
答：可以。
因为监控中心主要是起到一个收集数据的作用，监控中心宕机，只会影响采集数据，不影响生产者和消费者之间的通信。
3，问：zookeeper实际是如何存储生产者和消费者信息？
答：zookeeper采用树状结构来存储相关的信息，会创建相关的znode节点来存储信息。
如图所示：

流程说明：
• 服务提供者启动时: 向 /dubbo/com.foo.BarService/providers 目录下写入自己的 URL 地址
• 服务消费者启动时: 订阅 /dubbo/com.foo.BarService/providers 目录下的提供者 URL 地址。并向 /dubbo/com.foo.BarService/consumers 目录下写入自己的 URL 地址
• 监控中心启动时: 订阅 /dubbo/com.foo.BarService 目录下的所有提供者和消费者 URL 地址。
4，谈谈Dubbo的负载均衡策略
使用Dubbo，我们可以非常方便地做服务的水平扩展，集群部署。
那么问题来了，Dubbo的负载均衡策略是怎么样的？
Dubbo为我们提供了4种策略，默认是随机策略。
4种策略分别如下：
Random LoadBalance
随机，按权重设置随机概率。
在一个截面上碰撞的概率高，但调用量越大分布越均匀，而且按概率使用权重后也比较均匀，有利于动态调整提供者权重。
RoundRobin LoadBalance
轮询，按公约后的权重设置轮询比率。
存在慢的提供者累积请求的问题，比如：第二台机器很慢，但没挂，当请求调到第二台时就卡在那，久而久之，所有请求都卡在调到第二台上。
LeastActive LoadBalance
最少活跃调用数，相同活跃数的随机，活跃数指调用前后计数差。
使慢的提供者收到更少请求，因为越慢的提供者的调用前后计数差会越大。
ConsistentHash LoadBalance
一致性 Hash，相同参数的请求总是发到同一提供者。
当某一台提供者挂时，原本发往该提供者的请求，基于虚拟节点，平摊到其它提供者，不会引起剧烈变动。
算法参见：http://en.wikipedia.org/wiki/Consistent_hashing
缺省只对第一个参数 Hash，如果要修改，请配置 <dubbo:parameter key="hash.arguments" value="0,1" />
缺省用 160 份虚拟节点，如果要修改，请配置 <dubbo:parameter key="hash.nodes" value="320" />

实验步骤：
1，服务提供方开启多个实例
2，消费方通过设置负载均衡策略，重复调用服务接口，观察其执行结果。
3，注意要将服务提供方部署在多个服务器，不同的ip，才可以看到正确的效果
调用方程序：
/**
 * @author huangguizhao
 */
@Controller
@RequestMapping("user")
public class UserController {
    @Reference(loadbalance="roundrobin")
    private IUserService userService;
@RequestMapping("hello")
    @ResponseBody
    public String hello(){
        return userService.hello();
    }
}
通过多次访问接口测试接口：
http://localhost:8080/user/hellolocalhost:8080
也可以在配置文件统一配置
dubbo：
  provider:
    loadbalance: roundrobin
之前配置文件的配置方式：
<dubbo:referenceinterface="..."loadbalance="roundrobin" />

5，谈谈采用注册中心和直连的区别？
首先，生产者和消费者可以采用直连的方式进行通信，即点对点的通信方式，但是我们更推荐采用注册中心的方式，因为注册中心在这其中，起到了一个解耦的作用，而消费者只需要获取到生产者的地址列表，就可以采用负载均衡的方式去调用。

6，谈谈Dubbo底层的通信原理
Dubbo底层通信，默认采用高性能的Netty通信框架，实现网络通信，Netty是一个高性能的NIO通信框架，所以聊到底层原理，就要从NIO的特点来聊起。
NIO是如何做到多路复用机制的，以及Netty在此基础之后，又增加了主从线程池来进行优化，结合这两方面进行讲解即可。

96，集合面试题分析
面试题如下：
面试官问：
有集合A和集合B，现在需要将两个集合中重复的元素放入到集合C中，请问你会怎么编程实现？
这道题，简单想到的是循环遍历两个集合A和B，然后将重复的元素放入到集合C中，我们来看看怎么实现？
        List<String> list1 = Arrays.asList("a","b","c");
        List<String> list2 = Arrays.asList("a","b");
        List<String> list3 = new ArrayList<>();
               for (String a : list1) {
            for (String b : list2) {
                if(a.equals(b)){
                    list3.add(a);
                }
            }
        }
        System.out.println(list3);
上述这个方案好吗？
我们先直观分析下，假设两个集合都是存放100个元素，那么就需要100*100，比较10000次，然后从时间复杂度来分析，时间复杂度为O(n²)。
那么，我们可以怎么优化？
来看看，一个时间复杂度为O(n)的写法
        Set<String> set = new HashSet<>();
        for (String a : list1) {
            set.add(a);
        }
        for (String b : list2) {
            if(set.contains(b)){
                list3.add(b);
            }
        }
        System.out.println(list3);

94，谈谈JVM的垃圾回收算法及JVM参数

1，如何判断一个对象是垃圾
在谈JVM的垃圾回收算法之前，我们再来回顾下两个关键问题：
1，什么是垃圾回收？
2，如何判断一个对象是垃圾？
所谓的垃圾回收，是指回收哪些死亡的对象所占据的堆空间。
而如何判断一个对象已经死亡，有两种方式，引用计数法和可达性分析算法；
引用计数法，需要额外的空间来存储计数器，如果有一个引用指向某一个对象，则该对象的引用计数器+1，如果该引用指向另一个对象，则原先的对象计算器-1.
但这种算法，会存在循环引用的bug问题，存在内存溢出的风险。
可达性分析算法，是以GC Root作为起点，能够引用到的对象则是有用对象，反之则是死亡的。
那么，什么是GC Root，一般可以理解为堆外指向堆内的引用，包括以下常见的两种：
1，java方法栈帧中的局部变量
2，已被加载的类静态变量
下面，我们开始来谈垃圾回收算法！
1，标记清除算法
是现在垃圾算法的思想基础，它将垃圾回收分为两个阶段：
标记阶段和清除阶段。
首先，是通过根节点GC Root，标记所有从根节点开始的可达对象。
因此，未被标记的对象都是垃圾对象。
然后，在清除节点，则删除所有未被标记的对象。



标记清除算法的缺点：
1，效率不高
2，该算法会产生不连续的内存碎片，当我们需要分配较大对象时，会因为无法找到足够的连续内存空间，而不得不再次提前触发垃圾回收，如果内存还是不够，则报内存不足异常。

2，标记压缩算法
标记压缩算法是老年代的一种回收算法
首先，标记阶段跟“标记清除算法”一致
区别在于清理阶段，为了避免内存碎片产生，所有的存活对象会被压缩到内存的一端




这个算法解决之前标记清除算法的碎片问题
但是标记和压缩的效率依然不高

3，复制算法
复制算法是为了解决效率问题，它将内存一分为二，每次只使用其中一块，
这样，当这一块内容用完了，就将存活的对象复制到另一个块上，然后将另一块内存一次清理掉，这样回收的效率也就提升了，也不存在内存碎片的问题。



算法优点是回收效率高，不存在内存碎片，但是浪费内存一半的内存空间，另外在对象存活率高的情况下，采用复制算法，效率将会变低。
4，分代收集算法
目前，主流的虚拟机大都采用分代收集算法，它根据对象存活周期的不同，而将内存划分为多块区域。一般就是我们耳熟能详的新生代和老年代，然后再各自采用不同的回收算法。
新生代（Eden），对象的存活率低，所以采用复制算法
老年代（Old），对象的存活率高，所以采用标记清除或标记整理算法
对象会优先分配到新生代，如果长时间存活或者对象过大会直接分配到老年代（新生代空间不够）。
算法细节：
1，对象新建，将存放在新生代的Eden区域，注意Suvivor区又分为两块区域，FromSuv和ToSuv

2，当年轻代Eden满时，将会触发Minor GC，如果对象仍然存活，对象将会被移动到Fromsuvivor空间，对象还是在新生代

3，再次发生minor GC，对象还存活，那么将会采用复制算法，将对象移动到ToSuv区域，此时对象的年龄+1

4，再次发生minor GC，对象仍然存活，此时Survivor中跟对象Object同龄的对象还没有达到Surivivor区的一半，所以还是会继续采用复制算法，将fromSuv和ToSuv的区域进行互换

5，当多次发生minorGC后，对象Object仍然存活，且此时，此时Survivor中跟对象Object同龄的对象达到Surivivor区的一半，那么对象Object将会移动到老年代区域，或者对象经过多次的回收，年龄达到了15岁，那么也会迁移到老年代。


5，JVM配置的相关参数
• -Xms2g：初始化推大小为 2g；
• -Xmx4g：堆最大内存为 4g；
• -XX:NewRatio=4：设置年轻的和老年代的内存比例为 1:4；
• -XX:SurvivorRatio=8：设置新生代 Eden 和 Survivor 比例为 8:2；

6，垃圾回收器有哪些？
做垃圾回收的时候，都有一个统一的特点，叫stop the world.
往回收效率越来越高的方向来走的，垃圾回收的时间（stop the world）在变短
1，单线程回收器
采用单个线程的方式来进行回收，效率一般。服务器是多核CPU，资源无法得到更好利用
2，多线程回收器
可以充分利用CPU资源
3，CMS回收器
3.1 初始化标记
GCRoot
public class Gc{
      private static SomeObject = new SomeObject();
}
class SomeObject{
      
}
这个时候会stop the world，但是由于我们只是标记GCRoot，所以花费的时间很短
3.2 并发标记
一边可以继续往下跟踪，做可达性分析，相比比较耗时 100
一边可以让程序继续运行，可能重新创建对象，也可能创造垃圾 20
3.3 重新标记
处理在并发标记过程中，再次产生新的垃圾，stop the world 20
3.4 并发回收
一边针对我们刚才的垃圾对象进行回收
一边程序继续运行
4，G1垃圾回收器
将内存划分多个块 ，每个块再独立进行回收

93，谈谈java的垃圾回收机制

我们通常指的垃圾回收，指的就是回收堆的内存。
我们创建的对象都保存在堆中，java虚拟机通过垃圾自动回收机制，简称GC，简化了程序员的工作。
在java中，我们可以调用System.gc()来表示要进行垃圾回收，不过不建议使用，因为使用之后，虽然不会立即触发Full GC（堆内存全扫描），而是由虚拟机来决定执行时机，但是一旦执行，还是会停止所有的活动（stop the world），对应用影响很大。
我们一般建议，在一个对象不需要再被使用时，将其设置为null，这样GC虽然不会立即回收该对象的内存，但是会在下一次GC循环中被回收。
最后，说说finalize()方法，它是在释放对象内存前，由GC调用，该方法有且仅被调用一次，一般不建议重写该方法

92，谈谈如何判断一个对象是否可以被回收？

目前是两种方式：
方式一：引用计数器：为每个对象创建一个引用计数，当有对象引用时，计数器+1，
当引用释放时，计数器-1，所以，当计数器为0时，就认为可以被回收。
但这种算法，存在一个问题，存在循环引用的问题。
来，看代码，但一般是为
    public static void main(String[] args){
        One one = new One();
        Tow tow = new Tow();
        one.tow = tow;
        tow.one = one;
one = null;
        tow = null;
    }
}
class One{
    public Tow tow;
}
class Tow{
    public One one;
}
方式二：可达性分析
从GC Roots开始向下搜索，搜索所走过的路径称为引用链。
当一个对象到GC Roots没有任何引用链时，则认为此对象可以被回收。
大家可以认为就是一个树的根节点开始计算引用情况。

91，谈谈类的装载步骤

总共分为：加载，检查，准备，解析，初始化五个步骤
来，看图


引用孙卫琴《Java面向对象编程》的一段描述，帮助大家更好理解符号引用和直接引用的区别
在类的加载过程中的解析阶段，Java虚拟机会把类的二进制数据中的符号引用 替换为 直接引用，如Worker类中一个方法：
public void gotoWork(){      
     car.run(); //这段代码在Worker类中的二进制表示为符号引用         
}
在Worker类的二进制数据中，包含了一个对Car类的run()方法的符号引用，它由run()方法的全名 和 相关描述符组成。在解析阶段，Java虚拟机会把这个符号引用替换为一个指针，该指针指向Car类的run()方法在方法区的内存位置，这个指针就是直接引用。

90，谈谈类加载过程的双亲委托机制？

面试场景：
面试官第一问：
请问，我现在编写一个类，类全名如下：java.lang.String,
我们知道JDK也给我们听过了一个java.lang.String，
那么，我们编写的这个String类能否替换到JDK默认提供，也就是说程序实际运行的时候，会加载我们的String还是JDK的String？为什么？
如果，你无法确定？那么第二问：
了解类的加载机制吗？知道JDK的类加载器吗？双亲委托机制说说看
如果，你还不了解，那么我们聊聊今天的天气吧！

1，首先，什么是类的加载机制？
JVM使用Java类的流程如下：
1，Java源文件----编译---->class文件
2，类加载器ClassLoader会读取这个.class文件，并将其转化为java.lang.Class的实例。有了该实例，JVM就可以使用他来创建对象，调用方法等操作了。
那么ClassLoader是以一种什么机制来加载Class的？
这就是我们要谈的类的加载机制！
2，搞清楚这个问题，首先要知道，我们用到的Class文件都有哪些来源？
1，Java内部自带的核心类，位于$JAVA_HOME/jre/lib，其中最著名的莫过于rt.jar
2，Java的扩展类，位于$JAVA_HOME/jre/lib/ext目录下
3，我们自己开发的类或项目开发用到的第三方jar包，位于我们项目的目录下，比如WEB-INF/lib目录
3，那么，针对这些Class，JDK是怎么分工的？谁来加载这些Class？
针对不同的来源，Java分了不同的ClassLoader来加载
1，Java核心类，这些Java运行的基础类，由一个名为BootstrapClassLoader加载器负责加载。这个类加载器被称为“根加载器或引导加载器”
注意：BootstrapClassLoader不继承ClassLoader，是由JVM内部实现。法力无边，所以你通过java程序访问不到，得到的是null。
2，Java扩展类，是由ExtClassLoader负责加载，被称为“扩展类加载器”。
3，项目中编写的类，是由AppClassLoader来负责加载，被称为“系统类加载器”。
4， 那凭什么，我就知道这个类应该由老大BootStrapClassLoader来加载？
这里面就要基于双亲委托机制？
所谓双亲委托机制，就是加载一个类，会先获取到一个系统类加载器AppClassLoader的实例，然后往上层层请求，先由BootstarpClassLoader去加载，
如果BootStrapClassLoader发现没有，再下发给ExtClassLoader去加载，还是没有，才由AppClassLoader去加载。
如果还是没有，则报错
5，所以，上述问题的答案你清楚了吗？
JDK提供java.lang.String类，默认在rt.jar这个包里面，所以，默认会由BootstarpClassLoader加载，
所以，我们自己编写的java.lang.String，都没有机会被加载到
6，给两段程序看看，类加载器的关系
案例1：创建一个自己的类，然后打印其类加载器
public class ClassLoaderTest {
	public static void main(String[] args) throws ClassNotFoundException {
		Class<?> clazz = Class.forName("com.huangguizhao.thread.client.Programmer");
		ClassLoader classLoader = clazz.getClassLoader();
		System.out.println(classLoader.getClass().getSimpleName());
	}
}
案例2：打印其双亲类加载器信息
while(classLoader.getParent() != null){
       classLoader = classLoader.getParent();
       System.out.println("-->"+classLoader.getClass().getSimpleName());
}

89，说说JVM的运行时数据区

具体来说，每个虚拟机在实际实现时，略有不同。
不过基本都符合虚拟机的规范，虚拟机规范将这个区域划分为5部分：
1，Java虚拟机栈
存储局部变量，操作数栈，方法出口等，为每个被执行的方法创建一个栈帧，是线程私有的，这一点跟堆是不同的
2，java堆
java虚拟机中内存最大的一块，所有new的对象，都在这里分配内存，被所有线程共享。
3，程序计数器
保存当前线程执行的字节码行号指示器，通过改变该值，来实现执行下一条字节码指令。
分支，循环，线程恢复等操作，都需要依赖这个计数器来实现。
4，方法区
存储类信息，常量，静态变量，即时编译的代码等数据
5，本地方法栈
与java虚拟机栈类似，只不过java虚拟机栈是服务java方法的，本地方法区栈服务虚拟机调用Native方法的。

88，说说JVM的主要组成部分

主要分为4部分：
1，类加载器
2，运行时数据区
3，执行引擎
4，本地库接口
这几个分别的作用，我们用一张图来描述下：


87，说说MyBatis分页插件的原理是什么？

首先，在MyBatis内部定义了一个拦截器接口
所有的插件都要实现该接口，来，我们看看这个接口的定义
public interface Interceptor {
	Object intercept(Invocation invocation) throws Throwable;
	Object plugin(Object target);
	void setProperties(Properties properties);
}
那么其中一个关键的方法就是intercept，从而实现拦截
分页插件的原理就是使用MyBatis提供的插件接口，实现自定义插件，在插件的拦截方法内，拦截待执行的SQL，然后根据设置的dialect（方言），和设置的分页参数，重写SQL ，生成带有分页语句的SQL，执行重写后的SQL，从而实现分页
所以原理还是基于拦截器

86，MyBatis有哪些分页方式？

正常人，一般使用物理分页。
分为逻辑分页和物理分页
所谓逻辑分页，是指使用MyBatis自带的RowBounds进行分页，它会一次性查出多条数据，然后再检索分页中的数据，具体一次性查询多少条数据，受封装jdbc配置的fetch-size决定
而物理分页，是从数据库中查询指定条数的数据，而我们用的分页插件PageHelper实现的就是物理分页
那么问题来了，你清楚分页插件背后的原理吗？

85，说说synchronized底层原理（重要）

这个我们要分情况来分析：
1，JDK1.6之前
synchronized是由一对monitor-enter和monitor-exit指令实现的。
这对指令的实现是依靠操作系统内部的互斥锁来实现的，期间会涉及到用户态到内存态的切换，所以这个操作是一个重量级的操作，性能较低。
2，JDK1.6之后
JVM对synchronized进行了优化，改了三个经历的过程
偏向锁-》轻量级锁-》重量级锁
偏向锁：
在锁对象保存一个thread-id字段，刚开始初始化为空，当第一次线程访问时，则将thread-id设置为当前线程id，此时，我们称为持有偏向锁。
当再次进入时，就会判断当前线程id与thread-id是否一致
如果一致，则直接使用此对象
如果不一致，则升级为轻量级锁，通过自旋锁循环一定次数来获取锁
如果执行了一定次数之后，还是没能获取锁，则会升级为重量级锁。
锁升级是为了降低性能的消耗。

84，从浏览器输入URL到页面加载完毕，都经历了什么？

首先，需要经过DNS（域名解析服务）将URL转换为对应的ip地址，实际上域名只是方便我们记忆，在网络上的每台主机交互的地址都是IP。
其次，我们需要通过这个ip地址跟服务器建立TCP网络连接，随后向我们的服务器发出http请求。注意，http协议是tcp的上层协议
最后，服务器接收到我们的请求，处理完毕之后，将响应数据放入到http的响应信息中，然后返回给客户端。
客户端浏览器完成对服务器响应信息的渲染，将信息展现在用户面前。
常见的响应状态码：
200,500,404,400,405,301这些你知道什么意思吗？

83，谈谈什么是TCP的四次挥手？

大家可以思考一个问题，为什么要四次挥手，原因是TCP连接是一种双工的通信模式。


82，谈谈什么是TCP的三次握手

来，看图，个人觉得很完美的一张图，不接受反驳


81，MyBatis的XML映射文件都有哪些标签

这道题，主要是看看你是否知道常用的标签，如果没记住，不用慌，翻开XML文件看看即可。
来，我们罗列下：
1，基本的CRUD标签，select|insert|updae|delete
2，<resultMap>、<parameterMap>、<sql>、<include>、<selectKey>
3，动态SQL标签：trim | where | set | foreach | if | choose | when | otherwise | bind等，其中<sql>为sql片段标签，通过<include>标签引入sql片段

80，MyBatis-缓存机制，从一级缓存到二级缓存⬚("在此处键入公式。" )

缓存，主要作用是提高了查询性能，减少了跟数据库交互的次数，从而也减轻了数据库承受的压力。

适用于读多写少的场景，如果数据变化频率非常高，则不适用。
MyBatis的缓存分为一级缓存和二级缓存。

下面，我们通过做实验，来掌握MyBatis的一级缓存和二级缓存的特点：
1，来，关门，上一级缓存


观察执行结果：


再做一次实验，中间修改对象的信息


再做一次实验，中间新增记录



一级缓存总结：
1，一级缓存模式是开启状态
2，一级缓存作用域在于SqlSession（大家可以关闭SqlSession，然后创建一个新的，再获取对象，观察实验结果）
3，如果中间有对数据的更新操作，则将清空一级缓存。

下面，我们来看二级缓存（重点）
要使用二级缓存，需要经历两个步骤
1，开启二级缓存（默认处于开启状态）
<setting name="cacheEnabled" value="true"/>
2，在Mapper.xml中，配置二级缓存（也支持在接口配置）
在标签<mapper>下面添加<cache/>标签即可
默认的二级缓存配置会有如下特点：
2.1 所有的Select语句将会被缓存
2.2 所有的更新语句（insert、update、delete）将会刷新缓存
2.3 缓存将采用LRU（Least Recently Used 最近最少使用）算法来回收
2.4 缓存会存储1024个对象的引用
回收算法建议采用LRU，当然，还提供了FIFO（先进先出），SOFT（软引用），WEAK（弱引用）等其他算法。


3，做实验，验证二级缓存的效果：


观察结果：


二级缓存关键说明：
当关闭了SqlSession之后，才会将查询数据保存到二级缓存中（SqlSessionFactory）中，所以才有了上述的缓存命中率。MyBatis的二级缓存默认采用的是Map的实现。
4，衍生
其实，我们在开发中，可以集成第三方的缓存来保存MyBatis的二级缓存，常用的有EhCache和Redis
4.1 EhCache
MyBatis提供了一个项目实现，ehcache-cache
学习地址：https://github.com/mybatis/ehcache-cache


ehcache的配置可以参照：http://www.ehcache.org/ehcache.xml
4.2 整合Redis
同样，也提供了项目：https://github.com/mybatis/redis-cache
不过，目前还只有测试版本，等有稳定版了，推荐采用Redis的方式。
声明下，图片来自头条号也是我个人的头条号

79，谈谈MyBatis跟Hibernate的区别？

1，灵活性，MyBatis我们一般是自己写SQL，所以更灵活，更方便做优化
2，可移植性，正因为MyBatis我们是自己写SQL，而每个数据库都有自己的SQL扩展，所以在可移植性方面，MyBatis会较差
所以，在技术的选型上，其实，有时候就是一种取舍。
一般，我们在追求性能的方面会更倾向选择MyBatis。

78，hibernate的对象有几种状态？

1，瞬时状态，刚new出来的对象，该对象没有被持久化，也不受session管理
2，持久状态，比如，当调用了session的save方法之后
3，游离状态，当session关闭之后

77，谈谈hibernate的缓存机制

一级缓存：session级别的缓存，也称为线程级别的缓存，只在session的范围内有效
二级缓存：sessionFactory级别的缓存，也称为进程级别的缓存，在所有的session中都有效
一般需要配置第三方的缓存支持，比如EhCache
查询缓存：依赖于二级缓存，在HQL的查询语句中生效

76，什么是悲观锁，什么是乐观锁？

1，悲观锁是利用数据库本身的锁机制来实现，会锁记录。
实现的方式为：select * from t_table where id = 1 for update
2，乐观锁是一种不锁记录的实现方式，采用CAS模式，采用version字段来作为判断依据。
每次对数据的更新操作，都会对version+1，这样提交更新操作时，如果version的值已被更改，则更新失败。
3，乐观锁的实现为什么要选择version字段，如果选择其他字段，比如业务字段store（库存），那么可能会出现所谓的ABA问题
如下图所示：

75，什么是事务的传播特性及Spring支持的特性有哪些？

1，什么是事务的传播特性？
我们一般都是将事务的边界设置在Service层，
那么当我们调用Service层的一个方法的时，它能够保证我们的这个方法中执行的所有的对数据库的更新操作保持在一个事务中，
在事务层里面调用的这些方法要么全部成功，要么全部失败。那么事务的传播特性也是从这里说起的。
如果你在你的Service层的这个方法中，还调用了本类的其他的Service方法，那么在调用其他的Service方法的时候，这个事务是怎么规定的呢？
必须保证在我方法里调用的这个方法与我本身的方法处在同一个事务中，否则无法保证事物的一致性。
事务的传播特性就是解决这个问题的

2，Spring支持的事务传播特性
在Spring中，针对传播特性的多种配置，我们大多数情况下只用其中的一种:PROPGATION_REQUIRED：
这个配置项的意思是说当我调用service层的方法的时候，开启一个事务,
那么在调用这个service层里面的其他的方法的时候,如果当前方法产生了事务就用当前方法产生的事务，否则就创建一个新的事务。
这个工作是由Spring来帮助我们完成的。

3，Spring支持的事务传播特性
PROPAGATION_REQUIRED：支持当前事务，如果当前没有事务，就新建一个事务。这是最常见的选择。
PROPAGATION_SUPPORTS：支持当前事务，如果当前没有事务，就以非事务方式执行。
PROPAGATION_MANDATORY：支持当前事务，如果当前没有事务，就抛出异常。
PROPAGATION_REQUIRES_NEW：新建事务，如果当前存在事务，把当前事务挂起
PROPAGATION_NOT_SUPPORTED：以非事务方式执行操作，如果当前存在事务，就把当前事务挂起。
PROPAGATION_NEVER：以非事务方式执行，如果当前存在事务，则抛出异常。

74，SpringMVC有哪些常用的注解？有什么作用？

@RequestMapping：做请求的URL跟我们controller或者方法的映射关系
@RequestParam：做请求参数的匹配，当请求参数名称跟我们方法的参数名不一致的时候，可以做匹配
@GetMapping: 请求方式为GET
@PostMapping:请求方式为POST
@PathVariable:获取URL中携带的参数值，处理RESTful风格的路径参数
@CookieValue：获取浏览器传递cookie值
@RequestBody：接收请求中的参数信息，一般来说，接收一个集合或数组，或者以post方式提交的数据
@ResponseBody: 改变返回逻辑视图的默认行为，返回具体的数据，比如json
@Controller：Spring定义的，作用就是标明这是一个controller类
@RestController：@Controller+@ResponseBody的组合

73，Spring+SpringMVC的父子容器关系

SpringMVC+Spring这种开发模式的时候，会有两个容器
• SpringMVC容器管理，controller，Handlermapping，ViewResolver
• Spring容器管理，service，datasource，mapper，dao

• Spring容器是父容器，SpringMVC容器是子容器
• 子容器可以访问父容器上面的资源，所以我们会在看Controller可以注入Service

72，谈谈SpringMVC的工作流程

如图所示：

1，首先，将请求分给前端控制器DispatcherServlet
2，DispatcherServlet查询HandlerMapping（映射控制器），从而找到处理请求的Controller（处理器）
3，Controller执行业务逻辑处理后，返回一个ModelAndView（模型和视图）
4，DispatcherServlet查询一个或多个ViewResolver（视图解析器），找到ModelAndView对应的视图对象，视图对象负责渲染返回给客户端

71，Spring的bean是线程安全的吗？

大家可以回顾下线程不安全构成的三要素：
1，多线程环境
2，访问同一个资源
3，资源具有状态性
那么Spring的bean模式是单例，而且后端的程序，天然就处于一个多线程的工作环境。
那么是安全的吗？
关键看第3点，我们的bean基本是无状态的，所以从这个点来说，是安全的。
所谓无状态就是没有存储数据，即没有通过数据的状态来作为下一步操作的判断依据

结论： 不是线程安全的
Spring容器中的Bean是否线程安全，容器本身并没有提供Bean的线程安全策略，因此可以说Spring容器中的Bean本身不具备线程安全的特性，但是具体还是要结合具体scope的Bean去研究。
Spring 的 bean 作用域（scope）类型
1、singleton:单例，默认作用域。
2、prototype:原型，每次创建一个新对象。
3、request:请求，每次Http请求创建一个新对象，适用于WebApplicationContext环境下。
4、session:会话，同一个会话共享一个实例，不同会话使用不用的实例。
5、global-session:全局会话，所有会话共享一个实例。
线程安全这个问题，要从单例与原型Bean分别进行说明。
原型Bean
对于原型Bean,每次创建一个新对象，也就是线程之间并不存在Bean共享，自然是不会有线程安全的问题。
单例Bean
对于单例Bean,所有线程都共享一个单例实例Bean,因此是存在资源的竞争。
如果单例Bean,是一个无状态Bean，也就是线程中的操作不会对Bean的成员执行查询以外的操作，那么这个单例Bean是线程安全的。比如Spring mvc 的 Controller、Service、Dao等，这些Bean大多是无状态的，只关注于方法本身。
 
 
spring单例，为什么controller、service和dao确能保证线程安全？
Spring中的Bean默认是单例模式的，框架并没有对bean进行多线程的封装处理。
实际上大部分时间Bean是无状态的（比如Dao） 所以说在某种程度上来说Bean其实是安全的。
但是如果Bean是有状态的 那就需要开发人员自己来进行线程安全的保证，最简单的办法就是改变bean的作用域 把 "singleton"改为’‘protopyte’ 这样每次请求Bean就相当于是 new Bean() 这样就可以保证线程的安全了。
有状态就是有数据存储功能
无状态就是不会保存数据
controller、service和dao层本身并不是线程安全的，只是如果只是调用里面的方法，而且多线程调用一个实例的方法，会在内存中复制变量，这是自己的线程的工作内存，是安全的。
想理解原理可以看看《深入理解JVM虚拟机》，2.2.2节：
Java虚拟机栈是线程私有的，它的生命周期与线程相同。虚拟机栈描述的是Java方法执行的内存模型：每个方法在执行的同时都会创建一个栈帧用于存储局部变量表、操作数栈、动态链接、方法出口等信息。
 
《Java并发编程实战》第3.2.2节：
局部变量的固有属性之一就是封闭在执行线程中。
它们位于执行线程的栈中，其他线程无法访问这个栈。
所以其实任何无状态单例都是线程安全的。
Spring的根本就是通过大量这种单例构建起系统，以事务脚本的方式提供服务
 
也可以看看这篇加深理解： 关于Spring的@Controller @Service等的线程安全问题
首先问@Controller @Service是不是线程安全的？
答：默认配置下不是的。为啥呢？因为默认情况下@Controller没有加上@Scope，没有加@Scope就是默认值singleton，单例的。意思就是系统只会初始化一次Controller容器，所以每次请求的都是同一个Controller容器，当然是非线程安全的。举个栗子：

@RestController
public class TestController {
private int var = 0;
    
    @GetMapping(value = "/test_var")
    public String test() {
        System.out.println("普通变量var:" + (++var));
        return "普通变量var:" + var ;
    }
}

在postman里面发三次请求，结果如下：
1	普通变量var:1
2	普通变量var:2
3	普通变量var:3
说明他不是线程安全的。怎么办呢？可以给他加上上面说的@Scope注解，如下：

@RestController
@Scope(value = "prototype") // 加上@Scope注解，他有2个取值：单例-singleton 多实例-prototype
public class TestController {
private int var = 0;
    
    @GetMapping(value = "/test_var")
    public String test() {
        System.out.println("普通变量var:" + (++var));
        return "普通变量var:" + var ;
    }
}

这样一来，每个请求都单独创建一个Controller容器，所以各个请求之间是线程安全的，三次请求结果：
1	普通变量var:1
2	普通变量var:1
3	普通变量var:1
加了@Scope注解多的实例prototype是不是一定就是线程安全的呢？

@RestController
@Scope(value = "prototype") // 加上@Scope注解，他有2个取值：单例-singleton 多实例-prototype
public class TestController {
    private int var = 0;
    private static int staticVar = 0;
@GetMapping(value = "/test_var")
    public String test() {
        System.out.println("普通变量var:" + (++var)+ "---静态变量staticVar:" + (++staticVar));
        return "普通变量var:" + var + "静态变量staticVar:" + staticVar;
    }
}

看三次请求结果：
1	普通变量var:1---静态变量staticVar:1
2	普通变量var:1---静态变量staticVar:2
3	普通变量var:1---静态变量staticVar:3
虽然每次都是单独创建一个Controller但是扛不住他变量本身是static的呀，所以说呢，即便是加上@Scope注解也不一定能保证Controller 100%的线程安全。所以是否线程安全在于怎样去定义变量以及Controller的配置。所以来个全乎一点的实验，代码如下：

@RestController
@Scope(value = "singleton") // prototype singleton
public class TestController {
private int var = 0; // 定义一个普通变量
private static int staticVar = 0; // 定义一个静态变量
@Value("${test-int}")
    private int testInt; // 从配置文件中读取变量
ThreadLocal<Integer> tl = new ThreadLocal<>(); // 用ThreadLocal来封装变量
@Autowired
    private User user; // 注入一个对象来封装变量
@GetMapping(value = "/test_var")
    public String test() {
        tl.set(1);
        System.out.println("先取一下user对象中的值："+user.getAge()+"===再取一下hashCode:"+user.hashCode());
        user.setAge(1);
        System.out.println("普通变量var:" + (++var) + "===静态变量staticVar:" + (++staticVar) + "===配置变量testInt:" + (++testInt)
                + "===ThreadLocal变量tl:" + tl.get()+"===注入变量user:" + user.getAge());
        return "普通变量var:" + var + ",静态变量staticVar:" + staticVar + ",配置读取变量testInt:" + testInt + ",ThreadLocal变量tl:"
                + tl.get() + "注入变量user:" + user.getAge();
    }
}

补充Controller以外的代码：
config里面自己定义的Bean:User

@Configuration
public class MyConfig {
    @Bean
    public User user(){
        return new User();
    }
}

我暂时能想到的定义变量的方法就这么多了，三次http请求结果如下：
1	先取一下user对象中的值：0===再取一下hashCode:241165852
2	普通变量var:1===静态变量staticVar:1===配置变量testInt:1===ThreadLocal变量tl:1===注入变量user:1
3	先取一下user对象中的值：1===再取一下hashCode:241165852
4	普通变量var:2===静态变量staticVar:2===配置变量testInt:2===ThreadLocal变量tl:1===注入变量user:1
5	先取一下user对象中的值：1===再取一下hashCode:241165852
6	普通变量var:3===静态变量staticVar:3===配置变量testInt:3===ThreadLocal变量tl:1===注入变量user:1
可以看到，在单例模式下Controller中只有用ThreadLocal封装的变量是线程安全的。为什么这样说呢？我们可以看到3次请求结果里面只有ThreadLocal变量值每次都是从0+1=1的，其他的几个都是累加的，而user对象呢，默认值是0，第二交取值的时候就已经是1了，关键他的hashCode是一样的，说明每次请求调用的都是同一个user对象。
下面将TestController 上的@Scope注解的属性改一下改成多实例的：@Scope(value = "prototype")，其他都不变，再次请求，结果如下：


1	先取一下user对象中的值：0===再取一下hashCode:853315860
2	普通变量var:1===静态变量staticVar:1===配置变量testInt:1===ThreadLocal变量tl:1===注入变量user:1
3	先取一下user对象中的值：1===再取一下hashCode:853315860
4	普通变量var:1===静态变量staticVar:2===配置变量testInt:1===ThreadLocal变量tl:1===注入变量user:1
5	先取一下user对象中的值：1===再取一下hashCode:853315860
6	普通变量var:1===静态变量staticVar:3===配置变量testInt:1===ThreadLocal变量tl:1===注入变量user:1
分析这个结果发现，多实例模式下普通变量，取配置的变量还有ThreadLocal变量都是线程安全的，而静态变量和user（看他的hashCode都是一样的）对象中的变量都是非线程安全的。也就是说尽管TestController 是每次请求的时候都初始化了一个对象，但是静态变量始终是只有一份的，而且这个注入的user对象也是只有一份的。静态变量只有一份这是当然的咯，那么有没有办法让user对象可以每次都new一个新的呢？当然可以：


public class MyConfig {
    @Bean
    @Scope(value = "prototype")
    public User user(){
        return new User();
    }    
}

在config里面给这个注入的Bean加上一个相同的注解@Scope(value = "prototype")就可以了，再来请求一下看看：
1	先取一下user对象中的值：0===再取一下hashCode:1612967699
2	普通变量var:1===静态变量staticVar:1===配置变量testInt:1===ThreadLocal变量tl:1===注入变量user:1
3	先取一下user对象中的值：0===再取一下hashCode:985418837
4	普通变量var:1===静态变量staticVar:2===配置变量testInt:1===ThreadLocal变量tl:1===注入变量user:1
5	先取一下user对象中的值：0===再取一下hashCode:1958952789
6	普通变量var:1===静态变量staticVar:3===配置变量testInt:1===ThreadLocal变量tl:1===注入变量user:1
可以看到每次请求的user对象的hashCode都不是一样的，每次赋值前取user中的变量值也都是默认值0。
下面总结一下：
1、在@Controller/@Service等容器中，默认情况下，scope值是单例-singleton的，也是线程不安全的。
2、尽量不要在@Controller/@Service等容器中定义静态变量，不论是单例(singleton)还是多实例(prototype)他都是线程不安全的。
3、默认注入的Bean对象，在不设置scope的时候他也是线程不安全的。
4、一定要定义变量的话，用ThreadLocal来封装，这个是线程安全的


70，Spring的bean作用域有哪些？

1，默认是singleton，即单例模式
2，prototype，每次从容器调用bean时都会创建一个新的对象，比如整合Struts2框架的时候，spring管理action对象则需要这么设置。
3，request，每次http请求都会创建一个对象
4，session，同一个session共享一个对象
5，global-session

69，谈谈你对Spring的认识

这类问题，非常宽，来吧我们说说看
1，概览图如下：

2，说说上面的模块
核心的IOC容器技术（控制反转），帮助我们自动管理依赖的对象，不需要我们自己创建和管理依赖对象，从而实现了层与层之间的解耦，所以重点是解耦！
核心的AOP技术（面向切面编程），方便我们将一些非核心业务逻辑抽离，从而实现核心业务和非核心业务的解耦，比如添加一个商品信息，那么核心业务就是做添加商品信息记录这个操作，非核心业务比如，事务的管理，日志，性能检测，读写分离的实现等等
spring Dao，Spring web模块，更方便集成各大主流框架，比如ORM框架，hibernate，mybatis，比如MVC框架，struts2，SpringMVC

69，如何实现动态代理？

SpringAOP（面向切面编程），AOP分离核心业务逻辑和非核心业务逻辑，其背后动态代理的思想，
主要的实现手段有两种
1，JDK的动态代理，是基于接口的实现。继承自Proxy类
2，基于CGLIB的动态代理，是基于继承当前类的子类来实现的（所以，这个类不能是final）。我们项目结构是没有接口的情况下，如果实现动态代理，那么就需要使用这种方法。
所以，我们的Spring默认会在以上两者根据代码的关系自动切换，当我们采用基于接口的方式编程时，则默认采用JDK的动态代理实现。如果不是接口的方式，那么会自动采用CGLIB。
SpringAOP的背后实现原理就是动态代理机制。

如何去验证这个结论：
1，搭建一个Spring项目
2，创建有接口的方式
3，创建无接口的方式
4，打印输出动态生成的代理对象（完整类名）

@Autowire
private IMiaoShaService miaoShaService;
比如，miaoshaService真正运行的时候就是一个代理对象

68，什么是反射？可以解决什么问题？

反射是指程序在运行状态中，
1，可以对任意一个类，都能够获取到这个类的所有属性和方法。
2，对于任意一个对象，都可以调用它的任意一个方法和属性

反射是一种能力
一种在程序运行时，动态获取当前类对象的所有属性和方法的能力，可以动态执行方法，给属性赋值等操作的能力
Class代表的就是所有的字节码对象的抽象，类
反射，让我们的java程序具备动态性
这种动态获取类信息及调用对象方法的功能称为反射

在java中，Class类就是关键API
public class Reflection {
        public static void main(String[] args) throws ClassNotFoundException, NoSuchFieldException, NoSuchMethodException {
        //1.以class对象为基础
        Class<?> clazz = Class.forName("com.hgz.reflection.Student");
        System.out.println(clazz);
        //2.类中每一部分，都有对应的类与之匹配
        //表示属性的类
        Field nameField =
                clazz.getField("name");
        //表示方法的类
        Method helloMethod = clazz.getDeclaredMethod("hello", String.class);
        //表示构造方法的类
        Constructor<?>[] constructors = clazz.getConstructors();
    }
}

这种能力带来很多的好处，在我们的许多框架的背后实现上，都采用了反射的机制来实现动态效果。
框架是提供一种编程的约定
比如@Autowrie 就能实现自动注入
@Autowrie
private IUserService userService;
注解的解析程序，来扫描当前的包下面有哪些属性加了这个注解，一旦有这个注解，就要去容器里面获取对应的类型的实现，然后给这个属性赋值。

思考题：如何实现一个IOC容器？

67，什么是死锁？如何防止死锁？

1，什么是死锁
死锁最初由一个悲惨的故事说起，话说一群哲学家一起聚餐，然后在每个人的左边和右边分别放着一根筷子，而只有同时抓到两根筷子，才能正常吃饭，于是，不幸的故事发生了，每位哲学家都只抓到一根筷子，且都不愿意释放手中的筷子，于是，最终一桌的饭菜就这么浪费了。
不知道这个故事是谁发明的，但确实形象说明了死锁的情况。
转换到线程的场景，就是线程A持有独占锁资源a，并尝试去获取独占锁资源b
同时，线程B持有独占锁资源b，并尝试去获取独占锁资源a
这样线程A和线程B相互持有对方需要的锁，从而发生阻塞，最终变为死锁。

public class Deadlock {
        private static final Object a = new Object();
    private static final Object b = new Object();
        public static void main(String[] args){
        new Thread(new Task(true)).start();
        new Thread(new Task(false)).start();
    }
        static class Task implements Runnable{
        private boolean flag;
                public Task(boolean flag){
            this.flag = flag;
        }
                @Override
        public void run() {
            if(flag){
                synchronized (a){
                    System.out.println(Thread.currentThread().getName()+"->获取到a资源");
                    synchronized (b){
                        System.out.println(Thread.currentThread().getName()+"->获取到b资源");
                    }
                }
            }else{
                synchronized (b){
                    System.out.println(Thread.currentThread().getName()+"->获取到b资源");
                    synchronized (a){
                        System.out.println(Thread.currentThread().getName()+"->获取到a资源");
                    }
                }
            }
}
    }
}
//有可能会出现死锁，如果第一个线程已经走完，第二个线程才获取到执行权限，那么就不会出现死锁

2，如何防止死锁？（重点）
减少同步代码块嵌套操作
降低锁的使用粒度，不要几个功能共用一把锁
尽量采用tryLock（timeout）的方法，可以设置超时时间，这样超时之后，就可以主动退出，防止死锁（关键）

66，说说TCP和UDP的区别

首先，两者都是传输层的协议。
其次，
tcp提供可靠的传输协议，传输前需要建立连接，面向字节流，传输慢
udp无法保证传输的可靠性，无需创建连接，以报文的方式传输，效率高

65，什么是XSS攻击？

XSS攻击，俗称跨站点脚本攻击，
其原理是往网页添加恶意的执行脚本，比如js脚本。
当用户浏览该网页时，嵌入其中的脚本就会被执行，从而达到攻击用户的目的。
比如盗取客户的cookie，重定向到其他有毒的网站等等。
比如写一段js脚本（这还是很有善意的脚本）
for(var i=1;i<100;i++){
    alert("努力不一定成功，但不努力一定很舒服！");
}
这个时候的解决办法，是采用拦截器或过滤器对输入的信息做过滤处理。比如将执行脚本的符号做一些替换处理。

64，深拷贝和浅拷贝的区别是什么？

深拷贝：除了对象本身被复制外，对象所包含的所有成员变量都会被复制，包括引用类型的成员对象
浅拷贝：只复制对象其中包含的值类型的成员变量，而引用类型的成员对象没有被复制

63，synchronized和lock的区别
1 原始构成
	synchronized是关键字属于JVM层面
		monitorenter
		monitorexit
	Lock是具体类是API层的锁
2 使用方法
	synchronized不需要用户去手动释放锁，当synchronized代码执行完后系统会自动让线程释放对锁的占用
	ReentrantLock则需要用户去手动释放锁，若没有主动释放锁，就可能导致出现死锁的现象。
		需要lock()各unlock()方法配合try/finally语句块来完成。
3 等待是否可中断
	synchronized不可中断，除非抛出异常或者正常运行完成
	ReentrantLock可中断，
		1. 设置超时方法trylock(long timeout,TimeUnit unit)
		2. lockInterruptibly()放代码块中，调用interrput()方法中断
4 加锁是否公平
	synchronized非公平锁
	ReentrantLock两者都可以，默认为非公平锁
5 锁绑定多个条件Condition
	synchronized没有
	ReentrantLock用来实现分组唤醒的线程们，可以精确唤醒，而不是synchronized要么随机唤醒一个线程要么唤醒全部线程

62，synchronized和volatile的区别

1，作用的位置不同
synchronized是修饰方法，代码块
volatile是修饰变量
2，作用不同
synchronized，可以保证变量修改的可见性及原子性，可能会造成线程的阻塞
volatile仅能实现变量修改的可见性，但无法保证原子性，不会造成线程的阻塞

61，谈谈事务的隔离级别

有以下4个级别：
l READ UNCOMMITTED 读未提交，脏读、不可重复读、幻读有可能发生。
l READ COMMITTED 读已提交，可避免脏读的发生，但不可重复读、幻读有可能发生。
l REPEATABLE READ 可重复读，可避免脏读、不可重复读的发生，但幻读有可能发生。
l SERIALIZABLE 串行化，可避免脏读、不可重复读、幻读的发生，但性能会影响比较大。
特别说明：
幻读，是指在本地事务查询数据时只能看到3条，但是当执行更新时，却会更新4条，所以称为幻读
来一张汇总表：


60，谈谈事务的特点

原子性是基础，隔离性是手段，一致性 是约束条件，而持久性是我们的目的。
简称，ACID
原子性（ Atomicity ）、一致性（ Consistency ）、隔离性（ Isolation ）和持久性（ Durability ）
原子性：
事务是数据库的逻辑工作单位，事务中包含的各操作要么都完成，要么都不完成
(要么一起成功，要么一起失败)
一致性：
事务一致性是指数据库中的数据在事务操作前后都必须满足业务规则约束。
比如A转账给B，那么转账前后，AB的账户总金额应该是一致的。
隔离性：
一个事务的执行不能被其它事务干扰。即一个事务内部的操作及使用的数据对其它并发事务是隔离的，并发执行的各个事务之间不能互相干扰。
(设置不同的隔离级别，互相干扰的程度会不同)
持久性：
事务一旦提交，结果便是永久性的。即使发生宕机，仍然可以依靠事务日志完成数据的持久化。
日志包括回滚日志（undo）和重做日志(redo)，当我们通过事务修改数据时，首先会将数据库变化的信息记录到重做日志中，然后再对数据库中的数据进行修改。这样即使数据库系统发生奔溃，我们还可以通过重做日志进行数据恢复。

59，JDBC如何实现对事务的控制及事务边界

JDBC对事务的操作是基于Connection来进行控制的，具体代码如下：
try {
   //开启事务
   connection.setAutoCommit(false);
   //做业务操作
   //doSomething();
   //提交事务
   connection.commit();
}catch(Exception e){
   //回滚事务
   try {
      connection.rollback();
   } catch (SQLException e1) {
      e1.printStackTrace();
   }
}
但，注意，事务的边界我们是放在业务层进行控制，因为业务层通常包含多个dao层的操作。

58，如何解决SQL注入？

1，SQL注入，是指通过字符串拼接的方式构成了一种特殊的查询语句
比如：select * from t_user where usename='' and password=''
' or 1=1 #
select * from t_user where usename='' or 1=1 # ' and password=''
2，解决方案
采用预处理对象，采用PreparedStatement对象，而不是Statement对象
可以解决SQL注入的问题
另外也可以提高执行效率，因为是预先编译执行
SQL执行过程（语法校验->编译->执行）
延伸
MyBatis如何解决了SQL注入的问题？采用#
MyBatis的#和$的差异，#可以解决SQL注入，而？号不能解决


57，左连接，右连接，内连接，如何编写SQL，他们的区别是什么？

左连接：以左表为主
select a.*,b.* from a left join b on a.b_id = b.id;

右连接：以右表为主
select a.*,b.* from a right join b on a.b_id = b.id;

内连接：只列出两张表关联查询符合条件的记录
select a.*,b.* from a inner join b on a.b_id = b.id;

案例：
select t.id t_id,t.`name` t_name,c.id c_id,c.`name` c_name
from t_teacher t LEFT JOIN t_class c on t.id=c.t_id; #4条，以老师表为主

select t.id t_id,t.`name` t_name,c.id c_id,c.`name` c_name
from t_teacher t RIGHT JOIN t_class c on t.id=c.t_id; #4条，以班级表为主

select t.id t_id,t.`name` t_name,c.id c_id,c.`name` c_name
from t_teacher t INNER JOIN t_class c on t.id=c.t_id; #3条，只展示匹配条件的记录

56，说说常用的聚合函数有哪些及作用？

列表如下：

基本使用语法：
select max(age) from t_student;
select min(age) from t_student;
聚合函数经常会结合分组查询，出现在众多的SQL笔试题中，对于SQL笔试题，唯有多练

55，谈谈数据库设计的三大范式及反范式

1，数据库的三大范式
第一范式：列不可分
第二范式：要有主键
第三范式：不可存在传递依赖
比如商品表里面关联商品类别表，那么只需要一个关联字段product_type_id即可，其他字段信息可以通过表关联查询即可得到
如果商品表还存在一个商品类别名称字段，如product_type_name，那就属于存在传递依赖的情况，第三范式主要是从空间的角度来考虑，避免产生冗余信息，浪费磁盘空间
2，反范式设计：(第三范式)
为什么会有反范式设计？
原因一：提高查询效率（读多写少）
比如上述的描述中，显示商品信息时，经常需要伴随商品类别信息的展示，
所以这个时候，为了提高查询效率，可以通过冗余一个商品名称字段，这个可以将原先的表关联查询转换为单表查询

原因二：保存历史快照信息
比如订单表，里面需要包含收货人的各项信息，如姓名，电话，地址等等，这些都属于历史快照，需要冗余保存起来，
不能通过保存用户地址ID去关联查询，因为用户的收货人信息可能会在后期发生变更

54，什么是序列化？

序列化是为了保持对象在内存中的状态，并且可以把保存的对象状态再读出来。
什么时候需要用到java序列化？
1，需要将内存的对象状态保存到文件中
2，需要通过socket通信进行对象传输时
3，我们将系统拆分成多个服务之后，服务之间传输对象，需要序列化

53，并发和并行的区别

并发：
同一个CPU执行多个任务，按细分的时间片交替执行
并行：
在多个CPU上同时处理多个任务

52，Iterator和ListIterator的区别？

Iterator可以遍历Set和List，而ListIterator只能遍历List
Iterator只能单向遍历，而ListIterator可以双向遍历
ListIterator继承与Iterator接口

51，谈谈对MVC的理解（重要）

MVC是对Web层做了进一步的划分，更加细化
Model（模型） - 模型代表一个存取数据的对象或 JAVA POJO。
View（视图） - 视图代表模型包含的数据的可视化，比如HTML，JSP，Thymeleaf，FreeMarker等等
Controller（控制器） - 控制器作用于模型和视图上。它控制数据流向模型对象，并在数据变化时更新视图。它使视图与模型分离开，目前的技术代表是Servlet，Controller
常见的MVC框架有，Struts1，Struts2，SpringMVC
比如，SpringMVC分为两个控制器
DispatchServlet：前端控制器，由它来接收客户端的请求，再根据客户端请求的URL的特点，分发到对应的业务控制器，比如UserController



50，谈谈三层架构

1，JavaEE将企业级软件架构分为三个层次：
Web层：负责与用户交互并对外提供服务接口
业务逻辑层：实现业务逻辑模块
数据存取层：将业务逻辑层处理的结果持久化，方便后续查询
2，看图：


3，每个层都有各自的框架
WEB层：SpringMVC，Struts2，Struts1
业务逻辑层：Spring
数据持久层：Hibernate，MyBatis，SpringDataJPA，SpringJDBC

49，转发和重定向的区别

1，转发：
发生在服务器内部的跳转，所以，对于客户端来说，至始至终就是一次请求，所以这期间，保存在request对象中的数据可以传递
2，重定向：
发生在客户端的跳转，所以，是多次请求，这个时候，如果需要在多次请求之间传递数据，就需要用session对象
3，面试官的问题：
在后台程序，想跳转到百度，应该用转发还是重定向？
答案：重定向，因为转发的范围限制在服务器内部

48，描述Session跟Cookie的区别（重要）

1，存储的位置不同
Session：服务端
Cookie：客户端
存储的数据格式不同
Session：value为对象，Object类型
Cookie：value为字符串，如果我们存储一个对象，这个时候，就需要将对象转换为JSON
存储的数据大小
Session：受服务器内存控制
Cookie：一般来说，最大为4k
生命周期不同
Session：服务器端控制，默认是30分钟，注意，当用户关闭了浏览器，session并不会消失

Cookie：客户端控制，其实是客户端的一个文件，分两种情况
1，默认的是会话级的cookie，这种随着浏览器的关闭而消失，比如保存sessionId的cookie
2，非会话级cookie，通过设置有效期来控制，比如这种“7天免登录”这种功能，
就需要设置有效期，setMaxAge
cookie的其他配置
httpOnly=true：防止客户端的XSS攻击
path="/" ：访问路径
domain=""：设置cookie的域名
cookie跟session之间的联系
http协议是一种无状态协议，服务器为了记住用户的状态，我们采用的是Session的机制
而Session机制背后的原理是，服务器会自动生成会话级的cookie来保存session的标识，如下图所示：


47，JSP的4大域对象

4大域对象
ServletContext context域
HttpSession session域
HttpServletRequet request域
PageContext page
4大域对象的作用范围
page域: 只能在当前jsp页面使用 (当前页面)
request域: 只能在同一个请求中使用 (转发才有效，重定向无效)
session域: 只能在同一个会话(session对象)中使用 (私有的，多个请求和响应之间)
context域: 只能在同一个web应用中使用 (全局的)

46，描述JSP的9大内置对象（不重要）

首先，对于我们现在来说，用JSP的内置对象来直接开发的基本没有了，除非是比较老旧的项目，jsp的内置对象，则是不需要在jsp页面中创建，直接可以使用。
其实，我们通过观察jsp生成的java文件可以发现，其背后是帮我们创建了这些对象，所以对象的创建方式还是没有改变的。
我们去观察背后生成java类，那么里面是有给各个对象创建及初始化的代码(截取部分代码片段)
public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
....

来，如果面试官问到这个问题，记得多少回答多少即可。
内置对象名 类型
request （HttpServletRequest）
response （HttpServletResponse）
config （ServletConfig）
application （ServletContext）
session （HttpSession）
exception （Throwable）
page （Object(this)）
out （JspWriter）
pageContext （PageContext）

45，描述JSP和Servlet的区别

技术的角度：
JSP本质就是一个Servlet
JSP的工作原理：JSP->翻译->Servlet(java)->编译->Class（最终跑的文件）
应用的角度：
JSP=HTML+Java
Servlet=Java+HTML
各取所长，JSP的特点在于实现视图，Servlet的特点在于实现控制逻辑

44，谈谈Servlet的生命周期

首先，要明确一点，Servlet是单实例的，这个很重要！
生命周期的流程：
创建对象-->初始化-->service()-->doXXX()-->销毁
创建对象的时机：
1，默认是第一次访问该Servlet的时候创建
2，也可以通过配置web.xml，来改变创建时机，比如在容器启动的时候去创建，DispatcherServlet(SpringMVC前端控制器)就是一个例子
<load-on-startup>1</load-on-startup>
执行的次数
对象的创建只有一次，单例
初始化一次
销毁一次
关于线程安全
构成线程不安全三个因素：
1，多线程的环境（有多个客户端，同时访问Servlet）
2，多个线程共享资源，比如一个单例对象（Servlet是单例的）
3，这个单例对象是有状态的（比如在Servlet方法中采用全局变量，并且以该变量的运算结果作为下一步操作的判断依据）
伪代码,演示线程不安全的操作方式
public class MyServlet extends HttpServlet{
     private int ticket = 100;

     public void doXXX(){
        if(ticket > 0){
          //......
          ticket--;
         }
       }
}
所以，我们要避免在Servlet中做上述类似的操作！
分析Servlet内部源码，关于Service对请求的分发处理逻辑，会调用相应的doXXX方法


43，浅谈JavaScript的原型机制

JavaScript的原型有一个关键的作用就是来扩展其原有类的特性，比如下面这段代码，给String扩展了hello方法。很多的框架就是采用这种方式来进行扩展，从而让框架更易用。


42，谈谈Ajax的工作原理

谈这个问题的关键三要素，异步交互，XMLHttpRequest对象，回调函数。
下面，看图，传统模式跟Ajax工作模式的对比：

早期，预计是以XML为主要的传输数据格式，所以Ajax的最后一个字母就是代表XML的意思，不过现在基本是json为主。

41，JavaScript如何处理兼容性问题？

什么是兼容性问题：
因为历史原因，不同浏览器支持的方法或属性有差异
解决办法：
1，判断当前是哪款浏览器内核，然后调用这个内核支持的方法，但获取内核的方式，通常会有误差
2，存在性检查的方式(推荐)
如果当前的对象或方法存在，则会是true，进入if，否则进入false
案例：比如判断当前浏览器是否支持trim()方法
if(email.value.trim){
    if(email.value.trim() == ""){
       email.value = "请输入邮箱地址";	
     }	
}else{
    //正则表达式-去除前后空格
   if(email.value.replace(/(^\s+)|(\s+$)/g,"") == ""){
       email.value = "请输入邮箱地址";	
   }
}

40，JavaScript提供了哪些定时器

定时器在js中的应用非常广泛，比如首页的轮播图效果，网页的时钟，秒杀倒计时等等
就是采用定时器来实现的。
那么主要提供了两种定时器：
<script type="text/javascript">
    //一次性的
    window.setTimeout(function () {
        alert(1);
    },1000)
//周期性的
    window.setInterval(function () {
        alert(2);
    },1000)
</script>

39，谈谈对CSS盒子模型的理解

来，一图胜千言

padding:内边距
border：边框
margin：外边距
div+css，通常就用于布局。

38，我们来谈谈类的加载机制

面试场景：
面试官第一问：
请问，我现在编写一个类，类全名如下：java.lang.String,
我们知道JDK也给我们听过了一个java.lang.String，
那么，我们编写的这个String类能否替换到JDK默认提供，也就是说程序实际运行的时候，会加载我们的String还是JDK的String？为什么？
如果，你无法确定？那么第二问：
了解类的加载机制吗？知道JDK的类加载器吗？双亲委托机制说说看
如果，你还不了解，那么我们聊聊今天的天气吧！

1，首先，什么是类的加载机制？
JVM使用Java类的流程如下：
1，Java源文件----编译---->class文件
2，类加载器ClassLoader会读取这个.class文件，并将其转化为java.lang.Class的实例。有了该实例，JVM就可以使用他来创建对象，调用方法等操作了。
那么ClassLoader是以一种什么机制来加载Class的？
这就是我们要谈的类的加载机制！
2，搞清楚这个问题，首先要知道，我们用到的Class文件都有哪些来源？
1，Java内部自带的核心类，位于$JAVA_HOME/jre/lib，其中最著名的莫过于rt.jar
2，Java的扩展类，位于$JAVA_HOME/jre/lib/ext目录下
3，我们自己开发的类或项目开发用到的第三方jar包，位于我们项目的目录下，比如WEB-INF/lib目录
3，那么，针对这些Class，JDK是怎么分工的？谁来加载这些Class？
针对不同的来源，Java分了不同的ClassLoader来加载
1，Java核心类，这些Java运行的基础类，由一个名为BootstrapClassLoader加载器负责加载。这个类加载器被称为“根加载器或引导加载器”
注意：BootstrapClassLoader不继承ClassLoader，是由JVM内部实现。法力无边，所以你通过java程序访问不到，得到的是null。
2，Java扩展类，是由ExtClassLoader负责加载，被称为“扩展类加载器”。
3，项目中编写的类，是由AppClassLoader来负责加载，被称为“系统类加载器”。
4， 那凭什么，我就知道这个类应该由老大BootStrapClassLoader来加载？
这里面就要基于双亲委托机制？
所谓双亲委托机制，就是加载一个类，会先获取到一个系统类加载器AppClassLoader的实例，然后往上层层请求，先由BootstarpClassLoader去加载，
如果BootStrapClassLoader发现没有，再下发给ExtClassLoader去加载，还是没有，才由AppClassLoader去加载。
如果还是没有，则报错
5，所以，上述问题的答案你清楚了吗？
JDK提供java.lang.String类，默认在rt.jar这个包里面，所以，默认会由BootstarpClassLoader加载，
所以，我们自己编写的java.lang.String，都没有机会被加载到
6，给两段程序看看，类加载器的关系
案例1：创建一个自己的类，然后打印其类加载器
public class ClassLoaderTest {
	public static void main(String[] args) throws ClassNotFoundException {
		Class<?> clazz = Class.forName("com.huangguizhao.thread.client.Programmer");
		ClassLoader classLoader = clazz.getClassLoader();
		System.out.println(classLoader.getClass().getSimpleName());
	}
}
案例2：打印其双亲类加载器信息
while(classLoader.getParent() != null){
       classLoader = classLoader.getParent();
       System.out.println("-->"+classLoader.getClass().getSimpleName());
}

37，谈谈你对ThreadLocal的理解

ThreadLocal解决了什么问题？内部源码是怎么样的？
作用：
为每个线程创建一个副本
实现在线程的上下文传递同一个对象，比如connection

第一个问题：证明ThreadLocal为每个线程创建一个变量副本
public class ThreadLocalTest {
private static ThreadLocal<Long> threadLocal = new ThreadLocal<>();
        public static void main(String[] args) throws InterruptedException {
        //开启多个线程来执行任务
        Task task = new Task();
        new Thread(task).start();
        Thread.sleep(10);
        new Thread(task).start();
    }
        static class Task implements Runnable{
        @Override
        public void run() {
            Long result = threadLocal.get();
            if(result == null){
                threadLocal.set(System.currentTimeMillis());
                System.out.println(Thread.currentThread().getName()+"->"+threadLocal.get());
            }
        }
    }
}
输出的结果是不同的
问题二：为什么可以给每个线程保存一个不同的副本
那我们来分析源码
Long result = threadLocal.get();
public T get() {
        //1.获取当前线程
        Thread t = Thread.currentThread();
        //2，获取到当前线程对应的map
        ThreadLocalMap map = getMap(t);
        
        if (map != null) {
            //3.以threadLocal为key，获取到entry
            ThreadLocalMap.Entry e = map.getEntry(this);
            if (e != null) {
                @SuppressWarnings("unchecked")
                //4.获取对应entry的value，就是我们存放到里面的变量的副本
                T result = (T)e.value;
                return result;
            }
        }
        return setInitialValue();
    }
我们需要结合set方法的源码分析，才可以更好理解
threadLocal.set(System.currentTimeMillis());
public void set(T value) {
        //1.获取到当前线程
        Thread t = Thread.currentThread();
        //2.获取当前线程对应的map
        ThreadLocalMap map = getMap(t);
        if (map != null)
            //3.往map存放一个键值对
            //this ThreadLocal
            //value 保存的副本
            map.set(this, value);
        else
            createMap(t, value);
    }
所以，我们得到结论：
每个线程都会有对应的map，map来保存键值对。

问题三：ThreadLocal这种特性，在实际开发中解决了什么问题？
比如：hibernate管理session，mybatis管理sqlsession，其内部都是采用ThreadLocal来实现的。
前提知识：不管是什么框架，最本质的操作都是基于JDBC，当我们需要跟数据库打交道的时候，都需要有一个connection。
那么，当我们需要在业务层实现事务控制时，该如何达到这个效果？
我们构建下代码如下：
public class UserService {
//省略接口的声明
    private UserDao userDao = new UserDao();
    private LogDao logDao = new LogDao();
//事务的边界放在业务层
    //JDBC的封装，connection
    public void add(){
        userDao.add();
        logDao.add();
    }
}
public class UserDao {
public void add(){
        System.out.println("UserDao add。。。");
        //创建connection对象
        //connection.commit();
        //connection.rollback();
    }
}
public class LogDao {
public void add(){
        System.out.println("LogDao add。。。");
        //创建connection对象
        //connection.commit();
        //connection.rollback();
    }
}
如果代码按上面的方式来管理connection，我们还可以保证service的事务控制吗？
这是不行的，假设第一个dao操作成功了，那么它就提交事务了，而第二个dao操作失败了，它回滚了事务，但不会影响到第一个dao的事务，因为上面这么写是两个独立的事务

那么怎么解决。
上面的根源就是两个dao操作的是不同的connection
所以，我们保证是同个connection即可
//事务的边界放在业务层
//JDBC的封装，connection
public void add(){
    Connection connection = new Connection();
    userDao.add(connection);
    logDao.add(connection);
}
上面的方式代码不够优雅
public class ConnectionUtils {
private static ThreadLocal<Connection> threadLocal = new ThreadLocal<>();
public static Connection getConnection(){
        Connection connection = threadLocal.get();
        if(connection == null){
            connection = new Connection();
            threadLocal.set(connection);
        }
        return connection;
    }
}
public class UserDao {
public void add(){
        System.out.println("UserDao add。。。");
        //创建connection对象
        //connection.commit();
        //connection.rollback();
        Connection connection = ConnectionUtils.getConnection();
        System.out.println("UserDao->"+connection);
    }
}
到此，我们可以保证两个dao操作的是同一个connection

36，谈谈你对线程安全的理解？

如果这个是面试官直接问你的问题，你会怎么回答？
一个专业的描述是，当多个线程访问一个对象时，如果不用进行额外的同步控制或其他的协调操作，调用这个对象的行为都可以获得正确的结果，我们就说这个对象是线程安全的
那么我们如何做到线程安全？
实现线程安全的方式有多种，其中在源码中常见的方式是，采用synchronized关键字给代码块或方法加锁，比如StringBuffer
查看StringBuffer的源码，你会看到是这样的：

那么，我们开发中，如果需要拼接字符串，使用StringBuilder还是StringBuffer？
场景一：
如果是多个线程访问同一个资源，那么就需要上锁，才能保证数据的安全性。
这个时候如果使用的是非线程安全的对象，比如StringBuilder，那么就需要借助外力，给他加synchronized关键字。或者直接使用线程安全的对象StringBuffer

场景二：
如果每个线程访问的是各自的资源，那么就不需要考虑线程安全的问题，所以这个时候，我们可以放心使用非线程安全的对象，比如StringBuilder

比如在方法中，创建对象，来实现字符串的拼接。
看场景，如果我们是在方法中使用，那么建议在方法中创建StringBuilder，这时候相当是每个线程独立占有一个StringBuilder对象，不存在多线程共享一个资源的情况，所以我们可以安心使用，虽然StringBuilder本身不是线程安全的。

什么时候需要考虑线程安全？
1，多个线程访问同一个资源
2，资源是有状态的，比如我们上述讲的字符串拼接，这个时候数据是会有变化的

35，JDK提供的线程池有哪些？实际开发我们该怎么使用？

1，JDK通过接口ExecutorService来表示线程池，通过工具类Executors来创建多种线程池对象

2，各种线程池的特点如下：
newSingleThreadExecutor 创建一个单线程化的线程池，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。
newFixedThreadPool 创建一个定长线程池，可控制线程最大并发数，超出的线程会在队列中等待。
newCachedThreadPool创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程。
newScheduledThreadPool 创建一个定长线程池，支持定时及周期性任务执行。
3，在实际开发中，我们是怎么使用的？（重点）
实际开发中，线程资源必须通过线程池提供，不允许在应用中自行显式创建线程
使用线程池的好处是减少在创建和销毁线程上所花的时间以及系统资源的开销，解决资源不足的问题。
如果不使用线程池，有可能造成系统创建大量同类线程而导致消耗完内存或者“过度切换”的问题
实际开发中，线程池不允许使用 Executors 去创建，而是通过 ThreadPoolExecutor 的方式
FixedThreadPool 和 SingleThreadPool，允许的请求队列长度为 Integer.MAX_VALUE，可能会堆积大量的请求，从而导致 OOM。
CachedThreadPool 和 ScheduledThreadPool，允许的创建线程数量为 Integer.MAX_VALUE，可能会创建大量的线程，从而导致 OOM
所以，综上所述，我们都会采用底层的方式来创建线程池，大家自己查阅各种线程池的源代码就可以看到他们都是采用了同一个类来创建。
自己查看，印象更深刻。

34，谈谈Sleep和wait的区别

1，所属的类不同：
sleep方法是定义在Thread上
wait方法是定义在Object上
2，对于锁资源的处理方式不同
sleep不会释放锁
wait会释放锁
3，使用范围：
sleep可以使用在任何代码块
wait必须在同步方法或同步代码块执行
4，与wait配套使用的方法
• void notify()
Wakes up a single thread that is waiting on this object’s monitor.
译：唤醒在此对象监视器上等待的单个线程
• void notifyAll()
Wakes up all threads that are waiting on this object’s monitor.
译：唤醒在此对象监视器上等待的所有线程
• void wait( )
Causes the current thread to wait until another thread invokes the notify() method or the notifyAll( ) method for this object.
译：导致当前的线程等待，直到其他线程调用此对象的notify( ) 方法或 notifyAll( ) 方法
生命周期
1，当线程调用wait()或者join时，线程都会进入到waiting状态，当调用notify或notifyAll时，或者join的线程执行结束后，会进入runnable状态
2，当线程调用sleep(time)，或者wait(time)时，进入timed waiting状态，

最后，留下一个思考题，为什么wait要定义在Object中，而不定义在Thread中？
来解释下，我们回想下，在同步代码块中，我们说需要一个对象锁来实现多线程的互斥效果，也就是说，Java的锁是对象级别的，而不是线程级别的。
为什么wait必须写在同步代码块中？
原因是避免CPU切换到其他线程，而其他线程又提前执行了notify方法，那这样就达不到我们的预期（先wait再由其他线程来唤醒），所以需要一个同步锁来保护

33，请描述线程的生命周期

一图胜千言！

灵魂画家出品。
上述的图有些简略，下面详细说明下，线程共有6种状态：
new，runnable，blocked，waiting，timed waiting，terminated
1，当进入synchronized同步代码块或同步方法时，且没有获取到锁，线程就进入了blocked状态，直到锁被释放，重新进入runnable状态
2，当线程调用wait()或者join时，线程都会进入到waiting状态，当调用notify或notifyAll时，或者join的线程执行结束后，会进入runnable状态
3，当线程调用sleep(time)，或者wait(time)时，进入timed waiting状态，
当休眠时间结束后，或者调用notify或notifyAll时会重新runnable状态。
4，程序执行结束，线程进入terminated状态

案例篇
/**
 * @author huangguizhao
 * 测试线程的状态
 */
public class ThreadStateTest {
    public static void main(String[] args) throws InterruptedException {
        Thread thread = new Thread(new Task());
        System.out.println(thread.getState());//NEW
        thread.start();
        System.out.println(thread.getState());//RUNNABLE
        //保险起见，让当前主线程休眠下
        Thread.sleep(10);
        System.out.println(thread.getState());//terminated
    }
}
class Task implements Runnable{
    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            System.out.println(i);
        }
    }
}

public class ThreadStateTest {
    public static void main(String[] args) throws InterruptedException {
        BlockTask task = new BlockTask();
        Thread t1 = new Thread(task);
        Thread t2 = new Thread(task);
        t1.start();
        t2.start();
        //从严谨的角度来说，t1线程不一定会先执行，此处是假设t1先执行
        System.out.println(t1.getState());//RUNNABLE
        System.out.println(t2.getState());//BLOCKED
        Thread.sleep(10);
        System.out.println(t1.getState());//TIMED_WAITING
        Thread.sleep(1000);
        System.out.println(t1.getState());//WAITING
    }
}
class BlockTask implements Runnable{
@Override
    public void run() {
        synchronized (this){
            //另一个线程会进入block状态
            try {
                //目的是让线程进入waiting time状态
                Thread.sleep(1000);
                //进入waiting状态
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
注意：
blocked，waiting，timed waiting 我们都称为阻塞状态
上述的就绪状态和运行状态，都表现为runnable状态

32，一个普通main方法的执行，是单线程模式还是多线程模式？为什么？

因为java有个重要的特性，叫垃圾自动回收机制，所以答案是多线程，这里面有两部分，主线程（用户线程），垃圾回收线程GC（守护线程）同时存在。

31，创建线程的方式

我们常说的方式有以下三种：
继承Thread
实现Runable接口
实现Callable接口（可以获取线程执行之后的返回值）
但实际后两种，更准确的理解是创建了一个可执行的任务，要采用多线程的方式执行，
还需要通过创建Thread对象来执行，比如 new Thread(new Runnable(){}).start();这样的方式来执行。
在实际开发中，我们通常采用线程池的方式来完成Thread的创建，更好管理线程资源。

案例：如何正确启动线程
class MyThread extends Thread{
    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName()+"：running.....");
    }
}
public static void main(String[] args){
        MyThread thread = new MyThread();
        //正确启动线程的方式
        //thread.run();//调用方法并非开启新线程
        thread.start();
}
案例：实现runnable只是创建了一个可执行任务，并不是一个线程
class MyTask implements Runnable{
@Override
    public void run() {
        System.out.println(Thread.currentThread().getName()+":running....");
    }
}
public static void main(String[] args){
        MyTask task = new MyTask();
        //task.start(); //并不能直接以线程的方式来启动
        //它表达的是一个任务，需要启动一个线程来执行
        new Thread(task).start();
    }
案例三：runnable vs callable
class MyTask2 implements Callable<Boolean>{
@Override
    public Boolean call() throws Exception {
        return null;
    }
}

明确一点：
本质上来说创建线程的方式就是继承Thread，就是线程池，内部也是创建好线程对象来执行任务。

30，一道关于try catch finally返回值的问题

以下这道题，在实际开发中，并不会这么写。
这个是面试官为了考察大家对finally的认识，而苦思冥想出来，我猜的。

结果是多少?你可以先想下。。。。。。。。



答案是：2，因为finally是无论如何都会执行，除非JVM关闭了

29，throw跟throws的区别

throw，作用于方法内，用于主动抛出异常
throws, 作用于方法声明上，声明该方法有可能会抛些某些异常

针对项目中，异常的处理方式，我们一般采用层层往上抛，最终通过异常处理机制统一处理（展示异常页面，或返回统一的json信息），自定义 异常一般继承RunntimeException，我们去看看Hibernate等框架，他们的异常体系都是最终继承自RunntimeException

28，罗列常见的5个非运行时异常

IOException，
SQLException，
FileNotFoundException,
NoSuchFileException，
NoSuchMethodException

27，罗列常见的5个运行时异常

此类异常，编译时没有提示做异常处理，因此通常此类异常的正确理解应该是“逻辑错误”
算数异常，
空指针，
类型转换异常，
数组越界，
NumberFormateException（数字格式异常，转换失败，比如“a12”就会转换失败）

26，请描述下Java的异常体系

异常体系如下：

Error是虚拟机内部错误
栈内存溢出错误：StackOverflowError(递归，递归层次太多或递归没有结束)
堆内存溢出错误：OutOfMemoryError(堆创建了很多对象)
Exception是我们编写的程序错误
RuntimeException：也称为LogicException
为什么编译器不会要求你去try catch处理？
本质是逻辑错误，比如空指针异常，这种问题是编程逻辑不严谨造成的
应该通过完善我们的代码编程逻辑，来解决问题
非RuntimeException：
编译器会要求我们try catch或者throws处理
本质是客观因素造成的问题，比如FileNotFoundException
写了一个程序，自动阅卷，需要读取答案的路径（用户录入），用户可能录入是一个错误的路径，所以我们要提前预案，写好发生异常之后的处理方式，这也是java程序健壮性的一种体现

25，serialVersionUID的作用是什么

当执行序列化时，我们写对象到磁盘中，会根据当前这个类的结构生成一个版本号ID
当反序列化时，程序会比较磁盘中的序列化版本号ID跟当前的类结构生成的版本号ID是否一致，如果一致则反序列化成功，否则，反序列化失败
加上版本号，有助于当我们的类结构发生了变化，依然可以之前已经序列化的对象反序列化成功

24，谈谈IO流的分类及选择

1，分类
按方向分：输入流，输出流
（注意，是站在程序的角度来看方向），输入流用于读文件，输出流用于写文件
按读取的单位分：字节流，字符流
按处理的方式分：节点流，处理流
比如，FileInputStream和BufferedInputStream(后者带有缓存区功能-byte[])
IO流的4大基类：InputStream，OutputStream，Reader，Writer
2，选择
字节流可以读取任何文件
读取文本文件的时候：选择字符流（假如有解析文件的内容的需求，比如逐行处理，则采用字符流，比如txt文件）
读取二进制文件的时候，选择字节流（视频，音频，doc，ppt）

23，开发一个自己的栈，你会怎么写？

来，思考下，然后再看下面的答案。。。。。
答案如下：我们分析下JDK里面的Stack源码，会发现其实非常简单
首先，栈的特点是FILO(First In Last Out)
其次，底层的数据结构我们采用数组的方式
来，看几个关键的源码，一目了然
存：



取：


22，ArrayList vs Vector

说句实话，对这种古老的Vector，之所以你在笔试题会遇到，我感觉是面试官偷懒了。
来吧，我们看看
ArrayList：线程不安全，效率高，常用
Vector：线程安全的，效率低
我们看Vector的源码：


21，谈谈ConcurrentHashMap，HashMap，Hashtable的区别

1，首先，来看看其他几个相关的类
Hashtable是线程安全的，但效率低
HashMap是线程不安全的，但效率高
Collections.synchronizedMap()，工具类提供了同步包装器的方法，来返回具有线程安全的集合对象
性能依然有问题
public static <K,V> Map<K,V> synchronizedMap(Map<K,V> m) {
return new SynchronizedMap<>(m);
}
//在这个类的内部方法实现上，也只是单纯加上了锁
public V put(K key, V value) {
synchronized (mutex) {return m.put(key, value);}
}
为解决这样的矛盾问题，所以JDK提供了并发包，来平衡这样的问题（java.util.concurrent）
2，ConcurrentHashMap（重点）
• 兼顾了线程安全和效率的问题
分析：HashTable锁了整段数据（用户操作是不同的数据段，依然需要等待）
解决方案：把数据分段，执行分段锁（分离锁），核心把锁的范围变小，这样出现并发冲突的概率就变小
在保存的时候，计算所存储的数据是属于哪一段，只锁当前这一段
• 注意：分段锁（分离锁）是JDK1.8之前的一种的方案，JDK1.8之后做了优化。
JDK1.7跟JDK1.8在ConcurrentHashMap的实现上存在以下区别：
1，数据结构
JDK1.7采用链表的方式，而JDK1.8则采用链表+红黑树的方式
2，发生hash碰撞之后
JDK1.7发生碰撞之后，会采用链表的方式来解决
JDK1.8发生碰撞之后，默认采用链表，但当链表的长度超过8，且数组容量超过64时，会转换为红黑树存储
3，保证并发安全
JDK1.7采用分段锁的方式，而JDK1.8采用CAS和synchronized的组合模式
4，查询复杂度
JDK1.7采用链表的方式，时间复杂度为O(n)，而JDK1.8在采用红黑树的方式时，时间复杂度为O(log(n))

题外话：
不过红黑树其实是一种兜底方案，因为当链表数量达到8个的时候，其发生的概率是千万分之几，所以作者考虑到这种极端情况下，需要用红黑树的方式来优化

20，谈谈LinkedHashMap和HashMap的区别（重点）

此处，我们好好谈谈HashMap
主要关注几个点：
1，初始化大小是16，如果事先知道数据量的大小，建议修改默认初始化大小。 减少扩容次数，提高性能 ，这是我一直会强调的点
2，最大的装载因子默认是0.75，当HashMap中元素个数达到容量的0.75时，就会扩容。 容量是原先的两倍
3，HashMap底层采用链表法来解决冲突。 但是存在一个问题，就是链表也可能会过长，影响性能
于是JDK1.8,对HashMap做了进一步的优化，引入了红黑树。
当链表长度超过8，且数组容量大于64时，链表就会转换为红黑树
当红黑树的节点数量小于6时，会将红黑树转换为链表。
因为在数据量较小的情况下，红黑树要维护自身平衡，比链表性能没有优势。
这3点非常重要！
其次，LinkedHashMap就是链表+散列表的结构，其底层采用了Linked双向链表来保存节点的访问顺序，所以保证了有序性。

18，谈谈HashSet的存储原理

HashSet的存储原理或者工作原理，主要是从如何保证唯一性来说起。
这里面主要有3个问题，需要回答？
第一，为什么要采用Hash算法？有什么优势，解决了什么问题？
第二，所谓哈希表是一张什么表？
第三，HashSet如何保证保存对象的唯一性？会经历一个什么样的运算过程？
大家可以先思考，晚些再补充答案！

首先，我们要明确一点，HashSet底层采用的是HashMap来实现存储，其值作为HashMap的key
public boolean add(E e) {
        return map.put(e, PRESENT)==null;
    }
具体关于hashmap的细节再说
第一，为什么要采用Hash算法？有什么优势，解决了什么问题？
解决的问题是唯一性
存储数据，底层采用的是数组
当我们往数组放数据的时候，你如何判断是否唯一？
可以采用遍历的方式，逐个比较，但是这种效率低，尤其是数据很多的情况下
所以，为了解决这个效率低的问题，我们采用新的方式
采用hash算法，通过计算存储对象的hashcode，然后再跟数组长度-1做位运算，得到我们要存储在数组的哪个下标下，如果此时计算的位置没有其他元素，直接存储，不用比较。
此处，我们只会用到hashCode
但是随着元素的不断添加，就可能出现“哈希冲突”，不同的对象计算出来的hash值是相同的，这个时候，我们就需要比较，才需要用到equals方法
如果equals相同，则不插入，不相等，则形成链表

第二，所谓哈希表是一张什么表？
本质是一个数组，而且数组的元素是链表

JDK1.7的版本实现
JDK1.8做了优化
随着元素不断添加，链表可能会越来越长，会优化红黑树

17，如何在双向链表A和B之间插入C？

可以使用伪代码的方式来实现，你的答案是什么？
假设我们定位到了A节点，那么A.next就是B节点，这个是前提。
你的答案是？可以思考过后，再看答案
C.pre = A;
C.next = A.next;
A.next.pre = C;
A.next = C;

16，谈谈ArrayList和LinkedList的区别


1，底层数据结构的差异
ArrayList，数组，连续一块内存空间
LinkedList，双向链表，不是连续的内存空间
2，一个常规的结论
虽然不严谨，但也可以应付很多面试了
ArrayList，查找快，因为是连续的内存空间，方便寻址，但删除，插入慢，因为需要发生数据迁移
LinkedList，查找慢，因为需要通过指针一个个寻找，但删除，插入块，因为只要改变前后节点的指针指向即可。
3，ArrayList细节分析
1，增加
• 添加到末尾，正常不需要做特别的处理，除非现有的数组空间不够了，需要扩容
• 数组初始化容量多大？10，当你知道需要存储多少数据时，建议在创建的时候，直接设置初始化大小
• 怎么扩容？
• 当发现容量不够之后，就进行扩容
• 按原先数组容量的1.5倍进行扩容，位运算，下面是关键的源码
int oldCapacity = elementData.length;
int newCapacity = oldCapacity + (oldCapacity >> 1);
• 再将原先数组的元素复制到新数组，Arrays
elementData = Arrays.copyOf(elementData, newCapacity)
• 添加到其他位置，这个时候需要做整体的搬迁
• 2，删除
• 删除末尾，并不需要迁移
• 删除其他的位置，这个时候也需要搬迁
• 3，修改
• 修改之前，必须先定位
• 定位-查找-ArrayList（数组是一段连续的内存空间，定位会特别快）
• 4，查找
• 如上所述
4，LinkedList细节分析
1，提供了的两个引用（first，last）
2，增加
添加到末尾，创建一个新的节点，将之前的last节点设置为新节点的pre，新节点设置为last
我们看下源码：
void linkLast(E e) {
    //获取到最后一个节点
    final Node<E> l = last;
    //构建一个新节点，将当前的last作为这个新节点的pre
    final Node<E> newNode = new Node<>(l, e, null);
    //把last指向新节点
    last = newNode;
    //如果原先没有最后一个节点
    if (l == null)
        //将first指向新节点
        first = newNode;
    else
        //否则，将原先的last的next指向新节点
        l.next = newNode;
    size++;
    modCount++;
}
Node节点的定义：内部类
private static class Node<E> {
    E item;
    Node<E> next;
    Node<E> prev;
    Node(Node<E> prev, E element, Node<E> next) {
        this.item = element;
        this.next = next;
        this.prev = prev;
    }
}
添加到其他位置，这个时候，就需要调整前后节点的引用指向
3，如何去定义一个双向链表的节点，如上述的源码所示
4，修改
修改最后一个节点或者第一个节点，那么就很快（first，last）
修改其他位置，如果是按坐标来定位节点，则会按照二分查找法，源码如下：
if (index < (size >> 1)) {
    Node<E> x = first;
    for (int i = 0; i < index; i++)
        x = x.next;
    return x;
} else {
    Node<E> x = last;
    for (int i = size - 1; i > index; i--)
        x = x.prev;
    return x;
}

5，一个思考题，假如我们可以确定要存储1000个元素，那么采用ArrayList和LinkedList，
哪个更耗内存，为什么？
6，LinkedList，要实现在A和B之间插入C，该如何实现，编写伪代码即可

15，List和Set的区别

这简直是一道送分题，简单到我都不好意思写出来，但居然有人会搞错，汗！
• List（有序，可重复）
• Set（无序，不可重复）

13，算法题-冒泡排序

排序算法，一般来说，让面试者当场手写还是挺考验功底的。
所以，我们以前会让面试者自己选择任意一个排序算法，所以你准备好了吗？
1，首先，冒泡排序的定义
每次冒泡排序都会对相邻的两个元素进行比较，
如果前面的元素比后面的元素大，则进行互换，
一次冒泡会至少让一个元素移动到它应该在的位置。
重复n次，就完成n个元素的排序工作。
2，图例


3，关于上面的优化思考
其实，当某次冒泡操作没有数据交换时，说明已经达到了完全有序，
不用再继续后续的冒泡操作。
4，所以，我们最终的冒泡排序可以这么写
public void bubbleSort(int[] array){
    if(array.length <= 1){
        return;
    }
//重复n次冒泡
    for(int i=0;i<array.length;i++){
        //是否可以提交退出冒泡的标记
        boolean flag = false;
        //相邻之间两两比较，并且每次减少一位参与比较
        for(int j=0;j<array.length-i-1;j++){
            if(array[j] > array[j+1]){
                //需要交换
                int temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
                //
                flag = true;//有数据交换，不能提前退出
            }
        }
        if(!flag){
            //没有数据交换，提前退出冒泡比较
            break;
        }
    }
}

12，方法的重写和重载的区别

一般出现在（笔试题-选择题），下面我们说下重点
• 重载：发生在一个类里面，方法名相同，参数列表不同（混淆点：跟返回类型没关系）
以下不构成重载
public double add(int a,int b)
public int add(int a,int b)
• 重写：发生在父类子类之间的，方法名相同，参数列表相同

11，Int和Integer的区别（重点）

1，来，先来一道考题，你看做对了吗？
Integer i1 = new Integer(12);
        Integer i2 = new Integer(12);
        System.out.println(i1 == i2);
Integer i3 = 126;
        Integer i4 = 126;
        int i5 = 126;
        System.out.println(i3 == i4);
        System.out.println(i3 == i5);
Integer i6 = 128;
        Integer i7 = 128;
        int i8 = 128;
        System.out.println(i6 == i7);
        System.out.println(i6 == i8);
以上这些输出的答案是什么？true or false？ why？
你可以自己先思考，再看后面的答案分析。

答案揭晓
分情况来比较
• 都定义为Integer的比较：
new：一旦new，就是开辟一块新内存，结果肯定是false
不new：
看范围
Integer做了缓存，-128至127，当你取值在这个范围的时候，会采用缓存的对象，所以会相等
当不在这个范围，内部创建新的对象，此时不相等
• Integer和int的比较：
实际比较的是数值，Integer会做拆箱的动作，来跟基本数据类型做比较
此时跟是否在缓存范围内或是否new都没关系
源码分析：
当我们写Integer i = 126,实际上做了自动装箱：Integer i = Integer.valueOf(126);
分析这段源码
public static Integer valueOf(int i) {
    if (i >= IntegerCache.low && i <= IntegerCache.high)
        return IntegerCache.cache[i + (-IntegerCache.low)];
    return new Integer(i);
}
//IntegerCache是Integer的内部类
private static class IntegerCache {
    static final int low = -128;
    static final int high;
    static final Integer cache[];
    static {
        // high value may be configured by property
        int h = 127;

10，什么是向上转型？什么是向下转型？

这道题目一般出现在（笔试-选择题）
举例说明即可：
向上转型：Person person = new Student(); 安全的
向下转型：Teacher teacher = (Teacher)person; 不安全的

9，算法题-求解斐波那切数列的第N个数是几？

如何实现递归求斐波那切数列第N个数字的值（传说中的不死神兔就是这个问题）
数字的规律：1,1,2,3,5,8,13,21....
所以，我们可以分析编写如下：


8，算法题-求N的阶乘

这道算法题一般考查的递归的编程技能，那么我们回顾下递归程序的特点：
1，什么是递归？
递归，就是方法内部调用方法自身
递归的注意事项：
找到规律，编写递归公式
找到出口（边界值），让递归有结束边界
注意：如果递归太多层，或者没有正确结束递归，则会出现“栈内存溢出Error”！
问题：为什么会出现栈内存溢出，而不是堆内存溢出？
2，这道题该怎么写？
规律：N!=（n-1）!*n;
出口：n==1或n==0 return 1;
public static int getResult(int n){
    if(n<0){
       throw new ValidateException("非法参数");
    }
    if(n==1 || n==0){
       return 1;
    }
    return getResult(n-1)*n;
}

7，接口和抽象类的区别

这个问题，要分JDK版本来区分回答：
• JDK1.8之前：
• 语法：
• 抽象类：方法可以有抽象的，也可以有非抽象, 有构造器
• 接口：方法都是抽象，属性都是常量，默认有public static final修饰
• 设计：
• 抽象类：同一类事物的抽取，比如针对Dao层操作的封装，如，BaseDao，BaseServiceImpl
• 接口：通常更像是一种标准的制定，定制系统之间对接的标准
• 例子：
• 1，单体项目，分层开发，interface作为各层之间的纽带，在controller中注入IUserService，在Service注入IUserDao
• 2，分布式项目，面向服务的开发，抽取服务service，这个时候，就会产生服务的提供者和服务的消费者两个角色
• 这两个角色之间的纽带，依然是接口
• JDK1.8之后：
• 接口里面可以有实现的方法，注意要在方法的声明上加上default或者static
最后区分几个概念：
• 多继承，多重继承，多实现
• 多重继承：A->B->C（爷孙三代的关系）
• 多实现：Person implements IRunable,IEatable（符合多项国际化标准）
• 多继承：接口可以多继承，类只支持单继承

6，String，StringBuffer，StringBuilder区别

String 跟其他两个类的区别是
String是final类型，每次声明的都是不可变的对象，
所以每次操作都会产生新的String对象，然后将指针指向新的String对象。
StringBuffer，StringBuilder都是在原有对象上进行操作
所以，如果需要经常改变字符串内容，则建议采用这两者。
StringBuffer vs StringBuilder
前者是线程安全的，后者是线程不安全的。
线程不安全性能更高，所以在开发中，优先采用StringBuilder.
StringBuilder > StringBuffer > String

5，String s = "java"与String s = new String("java")

String s = "java";
String s = new String("java");
这两者的内存分配方式是不一样的。
第一种方式，JVM会将其分配到常量池，而第二种方式是分配到堆内存

4，final的作用

final修饰类，表示类不可变，不可继承
比如，String，不可变性
final修饰方法，表示该方法不可重写
比如模板方法，可以固定我们的算法
final修饰变量，这个变量就是常量
注意：
修饰的是基本数据类型，这个值本身不能修改
修饰的是引用类型，引用的指向不能修改
比如下面的代码是可以的
final Student student = new Student(1,"Andy");
student.setAge(18);//注意，这个是可以的！

3，==和equals的区别

== 比较的是值
比较基本的数据类型，比较的是数值
比较引用类型：比较引用指向的值（地址）
equals
默认比较也是地址，因为这个方法的最初定义在Object上，默认的实现就是比较地址
自定义的类，如果需要比较的是内容，那么就要学String，重写equals方法
代码案例：测试以下的每道题，你是否能够正确得到答案？
String s1 = new String("zs");
String s2 = new String("zs");
System.out.println(s1 == s2);
String s3 = "zs";
String s4 = "zs";
System.out.println(s3 == s4);
System.out.println(s3 == s1);
String s5 = "zszs";
String s6 = s3+s4;
System.out.println(s5 == s6);
final String s7 = "zs";
final String s8 = "zs";
String s9 = s7+s8;
System.out.println(s5 == s9);
final String s10 = s3+s4;
System.out.println(s5 == s10);

2，Java的基本数据类型有哪些？

boolean,char,byte,short,int,long,float,double
注意：String是引用类型

1，JDK，JRE，JVM有什么区别？

JDK：Java Development Kit，Java开发工具包，提供了Java的开发环境和运行环境。
包含了编译Java源文件的编译器Javac，还有调试和分析的工具。
JRE：Java Runtime Environment，Java运行环境，包含Java虚拟机及一些基础类库
JVM：Java Virtual Machine，Java虚拟机，提供执行字节码文件的能力
所以，如果只是运行Java程序，只需要安装JRE即可。
另外注意，JVM是实现Java跨平台的核心，但JVM本身并不是跨平台的，
不同的平台需要安装不同的JVM


01_谈谈对面向对象思想的理解

这个问题，通常会让很多人有点不知所措，感觉我一直在编码，但是说到思想很难去阐述。
下面，我说说自己的想法，
首先，谈谈“面向过程”vs“面向对象”
我觉得这两者是思考角度的差异，面向过程更多是以“执行者”的角度来思考问题，而面向对象更多是以“组织者”的角度来思考问题，举个例子，比如我要产生一个0-10之间的随机数，如果以“面向过程”的思维，那我更多是关注如何去设计一个算法，然后保证比较均衡产生0-10的随机数，而面向对象的思维会更多关注，我找谁来帮我们做这件事，比如Random类，调用其中提供的方法即可。
所以，面向对象的思维更多的是考虑如何去选择合适的工具，然后组织到一起干一件事。
好比一个导演，要拍一场电影，那么首先要有男猪脚和女猪脚，然后还有其他等等，最后把这些资源组织起来，拍成一场电影。
再说回我们的程序世界，这个组织者的思维无处不在，比如，我们要开发项目，以三层架构的模式来开发，那么这个时候，我们不需要重复造轮子，只需要选择市面上主流的框架即可，比如SpringMVC，Spring，MyBatis，这些都是各层的主流框架。
