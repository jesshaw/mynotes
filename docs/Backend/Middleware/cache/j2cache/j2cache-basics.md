# J2Cache

**J2Cache** 是一个用于 Java 应用程序的双级缓存框架，支持一级缓存（内存缓存）和二级缓存（分布式缓存）架构，以此提高应用程序的缓存性能和可扩展性。它支持 Redis、EhCache、Caffeine、Hazelcast 等多种缓存实现，是一个轻量级、易于集成的缓存工具。

## 1. J2Cache 的特点

- **多级缓存**：支持一级缓存和二级缓存的组合，一级缓存通常是本地内存缓存，二级缓存是分布式缓存。
- **多种缓存适配**：支持 Redis、EhCache、Caffeine、Memcached 等多种缓存实现。
- **分布式缓存支持**：通过 Redis 等分布式缓存实现数据同步，适合分布式系统环境。
- **简化的 API**：提供简单易用的 API，可以方便地对缓存进行增删改查操作。

## 2. J2Cache 的架构

J2Cache 将缓存分为两层：

- **一级缓存（本地缓存）**：一般为 JVM 内存级别的缓存，速度快，但仅限于当前实例。
- **二级缓存（分布式缓存）**：通常使用 Redis 等分布式缓存服务。分布式缓存能保证缓存数据在多个实例之间的一致性。

一级缓存与二级缓存的组合，使得 J2Cache 既能保证访问速度，又能在多实例中同步数据。

## 3. 安装和配置

### 3.1. 引入依赖

在 Maven 项目中，可以通过以下依赖来集成 J2Cache：

```xml
<dependency>
    <groupId>net.oschina.j2cache</groupId>
    <artifactId>j2cache-core</artifactId>
    <version>2.9.0</version>
</dependency>

<dependency>
    <groupId>net.oschina.j2cache</groupId>
    <artifactId>j2cache-redis</artifactId>
    <version>2.9.0</version>
</dependency>
```

### 3.2. 配置文件

J2Cache 使用 `j2cache.properties` 文件来进行配置：

```properties
# 使用 Redis 作为二级缓存
j2cache.L1.provider_class = caffeine
j2cache.L2.provider_class = redis

# Redis 配置
redis.hosts=127.0.0.1:6379
redis.password=your_password
redis.database=0
redis.timeout=10000
redis.pool.maxTotal=100
redis.pool.maxIdle=20
redis.pool.minIdle=5

# 缓存同步策略
j2cache.broadcast = redis
```

- **j2cache.L1.provider_class**：设置一级缓存实现，如 caffeine、ehcache。
- **j2cache.L2.provider_class**：设置二级缓存实现，如 redis、memcached。
- **redis.hosts**：配置 Redis 服务器地址。
- **j2cache.broadcast**：广播配置，用于多实例间的缓存同步。

## 4. 使用 J2Cache API

J2Cache 提供了简单的 API，用于缓存操作：

### 4.1. 初始化缓存

可以通过 `J2Cache` 来获取缓存实例：

```java
CacheChannel cache = J2Cache.getChannel();
```

### 4.2. 缓存的增删改查

以下是基本的缓存操作：

- **写入缓存**：

    ```java
    cache.set("region_name", "key1", "value1");
    ```

- **读取缓存**：

    ```java
    CacheObject cacheObj = cache.get("region_name", "key1");
    System.out.println(cacheObj.getValue());
    ```

- **删除缓存**：

    ```java
    cache.evict("region_name", "key1");
    ```

- **清空区域缓存**：

    ```java
    cache.clear("region_name");
    ```

## 5. 多实例缓存同步

J2Cache 可以通过 Redis 等广播机制实现多实例间的缓存同步。当一个实例对缓存数据进行更新或删除时，会向 Redis 发送广播消息，其他实例监听到消息后进行缓存更新或清除。

通过 `j2cache.broadcast = redis` 配置，J2Cache 会在 Redis 上注册一个频道，实例间的缓存操作会在该频道上进行通知，从而实现缓存的分布式同步。

## 6. 常见使用场景

### 6.1. 读多写少的场景

在读多写少的场景下，比如商品信息、系统配置等数据，J2Cache 的一级缓存可以有效提升查询速度，降低对分布式缓存的依赖。即使分布式缓存稍有延迟，本地缓存也可以较好地提供数据。

### 6.2. 分布式系统中的缓存同步

在微服务或分布式系统中，J2Cache 能利用 Redis 的广播功能，实现多个实例之间的数据同步，确保所有节点的数据一致性。

### 6.3. 低延迟需求场景

J2Cache 的一级缓存可以利用 JVM 内存缓存，极大地减少了缓存查询的延迟；当缓存失效或更新时，才会查询二级缓存，因此非常适合对访问速度要求较高的场景。

---

## 总结

J2Cache 是一款高效的 Java 缓存工具，适用于多实例和分布式系统场景。通过双层缓存机制和分布式缓存同步能力，J2Cache 不仅可以提升查询性能，还能保证分布式环境下的数据一致性。

## 参考

[github J2Cache](https://github.com/oschina/J2Cache)
