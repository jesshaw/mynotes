# RabbitMQ

## RabbitMQ 的工作原理

RabbitMQ 是基于 AMQP（Advanced Message Queuing Protocol，高级消息队列协议）的消息中间件，它的基本工作流程如下：

### 1. 生产者（Producer）发送消息

生产者向 RabbitMQ 服务器发送消息，通常会发送到一个**交换机（Exchange）**。

### 2. 交换机（Exchange）分发消息  

交换机根据自身类型（Direct、Fanout、Topic、Headers）决定如何将消息路由到**队列（Queue）**。

### 3. 队列（Queue）存储消息  

消息到达绑定的队列后，RabbitMQ 会负责存储消息，直到消费者确认接收。

### 4. 消费者（Consumer）接收消息  

消费者从队列中取出消息进行处理，处理后可以发送**ACK（确认）**，RabbitMQ 便会删除该消息。

### 5. 消息确认与重试机制  

- **ACK 机制**：消费者处理完消息后，必须发送 ACK 确认，否则 RabbitMQ 认为消息未成功处理，会重新投递或存入死信队列（DLX）。
- **死信队列（DLX）**：如果消息因超时、拒绝（nack/reject）或队列满等原因未能被正常处理，RabbitMQ 可将其转发到死信队列供后续分析。

### 6. 持久化机制  

 - **消息持久化**：确保消息存储在磁盘，即使 RabbitMQ 服务器重启，消息仍然存在。
 - **队列持久化**：队列本身也可以设置为持久化，避免重启丢失。

### 7. 流量控制（限流）  

RabbitMQ 通过**Prefetch Count** 机制控制消费者一次获取的最大未确认消息数量，以防止单个消费者因负载过高崩溃。

---

## RabbitMQ 常见面试题

### 1. RabbitMQ 的核心组件有哪些？

- 生产者（Producer）
- 交换机（Exchange）
- 队列（Queue）
- 绑定（Binding）
- 消费者（Consumer）
- 连接（Connection）和信道（Channel）

### 2. RabbitMQ 有哪些交换机类型？

- **Direct Exchange（直连交换机）**：基于**精确匹配**的路由键（routing key）进行消息投递。
- **Fanout Exchange（扇出交换机）**：广播模式，消息会发送到所有绑定的队列。
- **Topic Exchange（主题交换机）**：支持模糊匹配（`*`匹配一个单词，`#`匹配多个单词）。
- **Headers Exchange（头部交换机）**：基于消息头部属性匹配投递。

### 3. 如何保证 RabbitMQ 的消息不丢失？

- **生产者端**
  - 开启**事务**（transaction），但性能较低。
  - 开启**Confirm 模式**，生产者可确认消息是否被 RabbitMQ 接收。
- **RabbitMQ服务端**
  - **队列持久化**（队列 durable=true）。
  - **消息持久化**（消息属性 `deliveryMode=2`）。
  - **镜像队列**（在集群环境下防止单点故障）。
- **消费者端**
  - **手动 ACK 确认**，避免自动确认后消费者宕机导致数据丢失。

### 4. RabbitMQ 如何处理未被消费的消息？

- 通过 **死信队列**（DLX）存储消息，常见的触发条件：
  - 消息**TTL 过期**。
  - 队列**长度满**，新消息无法加入。
  - 消费者**拒绝消费**消息（`basic.reject` 或 `basic.nack`）且不重新入队。

### 5. 如何实现延迟消息（延迟队列）？

- **方式 1：TTL + 死信队列**
  1. 在普通队列设置消息的 TTL。
  2. 过期后消息进入死信队列（DLX），再由 DLX 队列的消费者进行处理。
- **方式 2：RabbitMQ 官方插件 `rabbitmq-delayed-message-exchange`**
  - 该插件支持直接为消息设置延迟时间，无需依赖死信队列。

### 6. 如何控制消费者的消费速率？

- 通过 `basic.qos(prefetchCount=n)` 限制消费者最多能处理 `n` 条未确认消息，避免消息过载。

### 7. 如何处理消费失败的消息？

- **手动 ACK 并重新入队**：如果消费者处理失败，可以使用 `basic.nack(requeue=true)` 让消息重新进入队列。
- **死信队列（DLX）**：如果消息多次消费失败，可进入死信队列做后续分析。

### 8. RabbitMQ 如何实现消息的顺序消费？

- 单一队列单一消费者可以保证顺序消费。
- 多消费者情况下，可以使用**FIFO 队列**（例如 Kafka 更适合严格的顺序保证）。

### 9. RabbitMQ 与 Kafka 的区别？

   | 特性 | RabbitMQ | Kafka |
   |------|----------|-------|
   | 模型 | 基于 AMQP 的消息队列 | 分布式日志系统 |
   | 适用场景 | 低延迟、可靠消息传输 | 高吞吐量、批量处理 |
   | 消息存储 | 可持久化，队列模型 | 基于日志存储，分区模型 |
   | 消息顺序 | 单消费者模式可保证顺序 | 同一分区内保证顺序 |
   | 消息确认 | 手动 ACK | 通过偏移量管理 |

### 10. 如何搭建 RabbitMQ 高可用集群？

- **镜像队列（Mirrored Queue）**：主从同步，保证消息不丢失。
- **普通集群（Classic Cluster）**：消息只存储在单节点，不同步数据，仅提供负载均衡。
- **使用负载均衡**（HAProxy、NGINX）提升吞吐量。

### 11. RabbitMQ 如何进行权限管理？

- 通过**vhost（虚拟主机）**进行资源隔离。
- 通过**用户和权限**（读、写、管理）管理访问控制。

### 12. 如何监控 RabbitMQ 运行状态？

- RabbitMQ 提供 **Management Plugin**（Web UI）。
- 使用 `rabbitmqctl status` 查看节点状态。
- 配合 Prometheus + Grafana 进行可视化监控。

---

## 总结

RabbitMQ 作为企业级消息队列，具有可靠性、持久化、ACK 机制等特性，适用于高并发低延迟的消息传输场景。面试时，掌握 RabbitMQ 的核心概念（交换机、队列、ACK、DLX）、消息持久化、高可用集群等内容，会大幅提升竞争力。
