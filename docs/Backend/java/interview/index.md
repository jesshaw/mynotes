# Java面试问题分类

在Java面试中，通常会围绕不同的知识领域进行考察，以下是Java面试问题的常见分类：

## 1. [Java基础](./java-fundamentals.md)

- Java语言的基本语法、数据类型、关键字（如`final`、`static`、`this`、`super`等）
- 面向对象编程（封装、继承、多态、抽象类和接口的区别）
- 异常处理机制（try-catch-finally，throw与throws的区别）
- 常用类库（String、StringBuilder、ArrayList、HashMap、Collections等）

## 2. [集合框架](./java-collection-framework.md)

- Java集合框架的结构（List、Set、Map的区别）
- 常见集合类（ArrayList、LinkedList、HashSet、TreeSet、HashMap、ConcurrentHashMap等）的特点和实现原理
- 集合类的线程安全性和fail-fast机制

## 3. [多线程与并发](./multithreading-and-concurrency.md)

- Java多线程的基础（线程的创建、线程生命周期、线程同步等）
- 并发包（`java.util.concurrent`）中的主要组件（如CountDownLatch、CyclicBarrier、Semaphore、ThreadPoolExecutor等）
- 线程安全问题（synchronized、volatile关键字、锁机制、CAS操作、AQS原理）
- [线程池的原理及应用](../core-java/java-thread-pool.md)

## 4. [JVM（Java虚拟机）](./jvm.md)

- JVM的内存结构（堆、栈、方法区、程序计数器、本地方法栈等）
- GC（垃圾回收机制）的原理及常见算法（如标记-清除、标记-整理、复制算法等）
- 类加载机制（双亲委派模型、类加载过程）
- JVM性能调优（内存参数调整、垃圾回收器选择）

## 5. [Java I/O 与 NIO](./java-io-and-nio.md)

- Java I/O模型（BIO、NIO、AIO的区别与应用场景）
- I/O流（字节流与字符流、File类的使用、序列化等）
- NIO的组件（Channel、Buffer、Selector）

## 6. [Java 8及以上新特性](./new-features-in-java8-and-above.md)

- Lambda表达式和函数式接口
- Stream API的用法（filter、map、reduce等）
- Optional类的使用
- 时间日期API（`java.time`包）
- Java 9及以上的模块系统、集合工厂方法、`var`关键字等新特性

## 7. [数据库及ORM框架](./database-and-orm-frameworks.md)

- SQL基础知识（基本CRUD操作、索引、事务、锁机制）
- ORM框架（MyBatis、Hibernate）的基本原理和使用
- JPA相关注解（如@Entity、@Table、@OneToOne等）
- 数据库连接池（如HikariCP、DBCP）和其配置

## 8. [Spring生态系统](./spring-ecossystem.md)

- Spring的核心概念（IoC、AOP）
- Spring MVC的工作原理
- Spring Boot的特性和自动配置原理
- Spring Cloud组件（Eureka、Ribbon、Feign、Hystrix、Zuul等）
- Spring Security的基础配置和认证授权机制

## 9. [设计模式](./design-patterns.md)

- 常用设计模式（单例、工厂、代理、策略、观察者等）的原理及应用场景
- 设计模式在实际开发中的运用（结合Spring框架，理解AOP与代理模式的关系等）
- SOLID原则和编写可扩展、易维护代码的设计思想

## 10. [微服务架构](./microservices-architecture.md)

- 微服务架构的设计原则和优缺点
- 服务治理、熔断、限流等策略
- 分布式事务处理（TCC、SAGA、MQ等解决方案）
- 服务注册与发现、负载均衡、配置管理等

## 11. [分布式系统与中间件](./distributed-systems-and-middleware.md)

- 分布式系统的基本概念（CAP理论、数据一致性、幂等性）
- 常用中间件（Redis、消息队列如RabbitMQ、Kafka的工作原理）
- 分布式缓存、分布式锁的实现方式
- 高并发、高可用系统设计（负载均衡、降级限流、缓存穿透等）

## 12. [性能优化与调优](./performance-optimization-and-tuning.md)

- 应用性能瓶颈分析和排查方法
- JVM调优及垃圾回收优化
- SQL查询优化、索引使用、数据库分库分表
- 系统架构上的性能优化措施（缓存、CDN、数据库读写分离等）

这些分类可以帮助面试者系统性地准备Java面试题目，并在面试中针对性地展示自己的技术能力。
