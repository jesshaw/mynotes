# 基于MQ的分布式事务实现方案

分布式事务的核心目标是保证系统中跨服务操作的一致性。由于分布式系统中传统的**2PC（两阶段提交）**模型复杂且存在性能瓶颈，因此**消息中间件（MQ）**常用于实现最终一致性的分布式事务。常见的实现思路有**TCC、可靠消息最终一致性（事务消息）、本地消息表**等。

下面详细介绍一种基于**可靠消息最终一致性**的实现方案。

## 一、解决思路

基于MQ的分布式事务通过**异步通知**的方式，实现多个服务之间的协调。大致流程如下：

1. **业务操作和发送消息事务性完成**：生产者在本地数据库操作和发送消息保证原子性。
2. **消费者执行业务逻辑**：消费者接收到消息后，完成其业务逻辑。
3. **消息重试机制**：若消费失败，可通过重试或死信队列保证最终处理成功。

## 二、典型实现流程

以**订单服务**调用**库存服务**为例，演示如何基于MQ实现分布式事务。

### 1. 订单服务（生产者）

- 订单服务创建订单时，**将订单写入本地数据库**。
- **发送事务消息**到MQ，表明订单创建成功，等待库存扣减。

```java
// 订单创建逻辑（Spring + RocketMQ 示例）
@Transactional
public void createOrder(Order order) {
    // 1. 保存订单到数据库
    orderRepository.save(order);
    
    // 2. 构造事务消息
    Message message = new Message("order-topic", 
            JSON.toJSONString(order).getBytes());

    // 3. 发送事务消息
    rocketMQTemplate.sendMessageInTransaction("order-producer", message, order);
}

@TransactionalEventListener
public void handleOrderTransactionCommit(Event event) {
    // 提交成功后的逻辑（如记录日志）
}
```

**关键点**：

- 使用`sendMessageInTransaction`确保消息的发送和本地事务的提交具有一致性。
- 订单的操作与消息发送是在一个事务中完成的，若事务回滚，则消息不会发送。

---

### 2. MQ 消费者（库存服务）

- **监听订单消息**，执行库存扣减。
- 若库存扣减失败，可以使用**重试机制**，如重发消息或转入死信队列。

```java
@RocketMQMessageListener(topic = "order-topic", consumerGroup = "stock-group")
public class StockConsumer implements RocketMQListener<Order> {

    @Autowired
    private StockService stockService;

    @Override
    public void onMessage(Order order) {
        try {
            // 1. 扣减库存
            stockService.reduceStock(order.getProductId(), order.getQuantity());

            // 2. 更新订单状态为已完成
            orderService.updateOrderStatus(order.getOrderId(), "COMPLETED");

        } catch (Exception e) {
            // 消费失败后，抛出异常，由MQ自动重试或进入死信队列
            throw new RuntimeException("库存扣减失败");
        }
    }
}
```

**关键点**：
- 如果业务执行失败，MQ会根据重试策略重新投递消息，确保消息最终被消费。
- 可以引入**死信队列（DLQ）**，将多次重试后依然失败的消息存储，待人工介入处理。

---

### 3. 事务回查机制

RocketMQ 提供了事务消息的回查机制，用于处理**消息发送与本地事务状态不一致**的情况。

- 当生产者发送的事务消息卡在半提交状态时，MQ会**定期回查**生产者，询问消息对应事务的最终状态。

```java
public class OrderTransactionListener implements TransactionListener {

    @Override
    public LocalTransactionState executeLocalTransaction(Message msg, Object arg) {
        try {
            // 1. 执行本地事务，如保存订单
            // 2. 返回COMMIT表示事务成功
            return LocalTransactionState.COMMIT_MESSAGE;
        } catch (Exception e) {
            // 返回ROLLBACK表示事务失败
            return LocalTransactionState.ROLLBACK_MESSAGE;
        }
    }

    @Override
    public LocalTransactionState checkLocalTransaction(Message msg) {
        // 回查时查询订单状态，返回COMMIT或ROLLBACK
        Order order = orderRepository.findById(msg.getKey());
        if (order != null && order.isCreated()) {
            return LocalTransactionState.COMMIT_MESSAGE;
        }
        return LocalTransactionState.ROLLBACK_MESSAGE;
    }
}
```

## 三、流程图

1. **订单服务**创建订单并发送事务消息。  
2. **MQ**将消息半提交，等待订单服务事务完成。  
3. **订单服务**完成本地事务后通知MQ提交消息。  
4. **库存服务**消费消息并扣减库存。  
5. 若消息消费失败，MQ会重试或进入死信队列。

## 四、重试与死信队列

1. **消费重试**：若消费者处理失败，MQ会自动重试多次。
2. **死信队列**：重试次数超过限制时，将消息存入死信队列，由人工处理。

## 五、代码中的关键点

1. **事务消息发送**：确保生产者本地事务和消息发送原子性。
2. **消息幂等性**：消费者处理消息时需要保证幂等，以避免重复扣减库存等问题。
3. **事务回查**：确保消息状态的一致性。

## 六、总结

- **基于MQ的分布式事务**采用异步通信的方式，实现了跨服务的数据一致性。
- **最终一致性**：不要求强一致性，通过重试和回查机制确保系统状态最终达到一致。
- **适用场景**：订单、支付、库存扣减等业务场景。MQ实现方案相比传统的2PC模型，更加高效且具备良好的扩展性。