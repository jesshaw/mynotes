# 多线程与并发

以下是Java多线程与并发相关的常见面试题及其答案，涵盖线程基础、并发包、线程安全机制等方面：

## 1. 什么是线程？线程和进程的区别是什么？

**答案**：
**线程是程序执行的最小单元，而进程是资源分配的最小单元**。一个进程可以包含多个线程，线程共享进程的内存空间。相比进程间通信，线程间通信更高效。

## 2. 创建线程的几种方法？

**答案**：

- **继承Thread类**：重写`run()`方法。
- **实现Runnable接口**：实现`run()`方法，将实例传给`Thread`对象。
- **实现Callable接口**：实现`call()`方法，返回一个`Future`对象。

## 3. 什么是线程安全？如何保证线程安全？

**答案**：
线程安全指**多个线程同时访问共享资源时**，程序行为**仍然符合预期**。常见的线程安全实现方法：

- 使用同步块（`synchronized`关键字）。
- 使用并发类（如`ConcurrentHashMap`）。
- 使用`volatile`关键字。
- 使用线程安全的集合（如`CopyOnWriteArrayList`）。

## 4. synchronized的原理是什么？

**答案**：
`synchronized`通过**对象的内置锁（或称监视器）来保证方法或代码块在同一时刻只能被一个线程执行**，防止多线程同时访问共享资源。JVM中的Monitor（监视器）锁实现了` synchronized`，每个对象有一个监视器锁。

## 5. Java中`synchronized`和`ReentrantLock`的区别？

**答案**：

- `ReentrantLock`提供了**更灵活的锁机制**，支持公平锁、非公平锁选择，提供了锁的超时获取、可中断和多条件锁等功能。
- `synchronized`是**JVM层面实现**，性能在JDK 1.6后优化。
- `ReentrantLock`需要**手动释放锁**，而`synchronized`是**自动**的。

## 6. 什么是线程池？为什么使用线程池？

**答案**：
线程池**管理并复用固定数量的线程，避免频繁创建和销毁线程带来的性能开销**。它提高了程序的并发性、资源利用率，避免线程过多导致系统性能下降。

[线程池原理](../core-java/java-thread-pool.md)

## 7. 线程池的几种常见类型？

**答案**：

- `FixedThreadPool`：固定大小的线程池。
- `CachedThreadPool`：可根据需求动态扩容。
- `SingleThreadExecutor`：单线程池，确保任务串行执行。
- `ScheduledThreadPool`：支持定时或周期性任务执行。

## 8. 什么是`Future`和`Callable`？

**答案**：

- **`Callable`**：与`Runnable`类似，但可以返回结果并抛出异常。
- **`Future`**：表示**异步任务的结果**，提供了检查任务完成状态、获取结果和取消任务的方法。

## 9. volatile关键字的作用是什么？

**答案**：
`volatile`**保证了变量的可见性**，即当一个线程修改了变量的值，其他线程立即可见。`volatile`不会保证操作的原子性，所以仅在非复合操作的共享变量使用。

## 10. 什么是死锁？如何避免死锁？

**答案**：
死锁是指**两个或多个线程相互持有对方所需的锁**，导致无法继续执行。避免死锁的方法包括：

- 避免嵌套锁定。
- 使用`tryLock()`等带超时功能的锁。
- 为每个锁规定获取顺序。
- 尽量减少锁的粒度。

## 11. Java中的原子类是什么？

**答案**：
原子类（`AtomicInteger`、`AtomicLong`等）提供了一种锁机制外的线程安全方式，**使用CAS（Compare and Swap）操作保证操作的原子性**，适合高并发场景。

## 12. 什么是CAS操作？

**答案**：
CAS是Compare-And-Swap的简称，通过比较和交换值确保更新操作的原子性。CAS包含三个参数：内存值、期望值和更新值。当内存值与期望值相等时才将其更新为新值，否则重试。

## 13. 什么是`ThreadLocal`？

**答案**：
`ThreadLocal`为每个线程提供独立的变量副本，使变量在多线程环境中互不影响，适合线程间不共享状态的情况。

## 14. Java中的锁有几种类型？

**答案**：

- **偏向锁**：减少无竞争的线程获取锁的开销。
- **轻量级锁**：通过CAS操作实现，在竞争不激烈的情况下快速获取锁。
- **重量级锁**：依赖OS内核的互斥量实现，适用于高竞争的场景。
- **读写锁**（`ReentrantReadWriteLock`）：分为读锁和写锁，读读不互斥，写写和读写互斥。

## 15. Java并发包中有哪些常见的并发工具类？

**答案**：
包括`CountDownLatch`、`CyclicBarrier`、`Semaphore`、`Exchanger`、`Phaser`等。

- **CountDownLatch**：计数器减到0时释放所有等待的线程。
- **CyclicBarrier**：允许一组线程相互等待，适合多线程计算。
- **Semaphore**：限制多个线程同时访问共享资源。
- **Exchanger**：允许两个线程交换数据。

## 16. 什么是无锁、偏向锁和轻量级锁？

**答案**：

- **无锁**：不使用任何锁机制，通常借助CAS操作实现原子性。
- **偏向锁**：锁竞争不激烈的情况下，线程将获得对象的偏向锁，减少锁的开销。
- **轻量级锁**：使用自旋和CAS操作，适用于短时间的竞争。

## 17. 什么是`AQS`？它是如何工作的？

**答案**：
`AQS`（AbstractQueuedSynchronizer）是实现Java锁和同步器的基础框架。它使用一个FIFO等待队列管理同步状态，提供了`acquire`、`release`等方法以控制线程的访问。

## 18. `ReentrantLock`与`Synchronized`的实现区别？

**答案**：

- **ReentrantLock**是基于AQS实现，功能更丰富，支持公平锁、非公平锁选择。
- **Synchronized**是基于JVM实现，1.6之后引入了偏向锁、轻量级锁等优化机制。

## 19. `CountDownLatch`和`CyclicBarrier`的区别？

**答案**：
`CountDownLatch`用于线程等待，倒数到0时唤醒等待线程，适合一方等待多方完成任务；`CyclicBarrier`用于多线程相互等待，适合多线程并发分阶段执行的场景。

## 20. 什么是分段锁？`ConcurrentHashMap`的实现原理是什么？

**答案**：
分段锁将锁分成多个段（Java 8之前`ConcurrentHashMap`实现方式），不同段可以并发访问。Java 8之后，`ConcurrentHashMap`基于CAS和`Synchronized`实现，底层使用`Node`数组，结合红黑树优化性能。

## 21. 线程中断的原理是什么？如何使用线程的中断机制？

**答案**：
线程中断通过设置线程的中断标志实现，`interrupt()`方法不会强制终止线程。线程可以通过`isInterrupted()`检查中断标志，并在合适的地方响应中断。阻塞方法如`sleep()`、`wait()`被中断会抛出`InterruptedException`。

## 22. 什么是阻塞队列？阻塞队列有哪些实现类？

**答案**：
阻塞队列是一种支持线程间通信的队列，线程在队列为空时获取元素会阻塞。常见实现类有`ArrayBlockingQueue`、`LinkedBlockingQueue`、`PriorityBlockingQueue`、`DelayQueue`、`SynchronousQueue`等。

## 23. 什么是读写锁？如何使用`ReentrantReadWriteLock`？

**答案**：
读写锁分为读锁和写锁，多个线程可以并发获取读锁，但写锁是独占的。使用`ReentrantReadWriteLock

## 24. java应用的线程数定义多少合适？

**答案**：

| 应用类型           | 推荐线程数设置                 |
|--------------------|-------------------------------|
| CPU密集型应用      | CPU核心数 + 1                 |
| I/O密集型应用      | `CPU核心数 * 2` 或更高 / CPU核心数 / (1 - 阻塞系数默认为0.5)      |
| Web服务器          | `CPU核心数 * 2` 到 `CPU核心数 * 4` |
| 后台任务/队列处理  | `根据测试逐步增加，保持系统稳定` |

这些问题都围绕Java的多线程与并发编程。以下是逐一回答：

## 25. 并发和并行的区别

**答案**：

**并发**指多个任务在同一时间段交替执行，通常是通过单个CPU在不同任务之间切换来实现，适用于IO密集型任务。
**并行**指多个任务在同一时刻同时执行，通常需要多核CPU的支持，适用于计算密集型任务。并行是并发的一种特殊情况。

## 26. 线程的生命周期

**答案**：

```plantuml
@startuml
!define RECTANGLE class

state "New" as NEW #lightblue
state "Runnable" as RUNNABLE #lightgreen
state "Running" as RUNNING #yellow
state "Blocked" as BLOCKED #orange
state "Waiting" as WAITING #lightpink
state "Timed Waiting" as TIMED_WAITING #lavender
state "Terminated" as TERMINATED #grey

NEW --> RUNNABLE : start()
RUNNABLE --> RUNNING : CPU schedule
RUNNING --> BLOCKED : Needs lock (synchronized)
BLOCKED --> RUNNABLE : Lock available

RUNNING --> WAITING : wait() method
WAITING --> RUNNABLE : notify() / notifyAll()
RUNNING --> TIMED_WAITING : sleep() / wait(timeout) / join(timeout)
TIMED_WAITING --> RUNNABLE : Timeout or notify()

RUNNING --> TERMINATED : run completes or exception
WAITING --> TERMINATED : InterruptedException
TIMED_WAITING --> TERMINATED : InterruptedException

@enduml
```

**解释**:

- **New** 到 **Runnable**：调用 `start()` 方法，线程进入就绪状态。
- **Runnable** 到 **Running**：线程被CPU调度，获得执行权。
- **Running** 到 **Blocked**：线程尝试获取锁，但锁被其它线程持有，因此进入Blocked状态。
- **Blocked** 到 **Runnable**：锁被其它线程释放后，Blocked状态的线程重新进入Runnable状态，等待再次调度。
- **Running** 到 **Waiting**：线程调用`wait()`方法，进入等待状态，直到被通知。
- **Waiting** 到 **Runnable**：另一个线程调用`notify()`或`notifyAll()`，将线程唤醒，使其重新进入Runnable状态。
- **Running** 到 **Timed Waiting**：线程调用`sleep()`、`wait(timeout)`或`join(timeout)`方法，进入限时等待状态。
- **Timed Waiting** 到 **Runnable**：等待超时或被通知后，线程回到Runnable状态。
- **Running** 到 **Terminated**：线程执行完`run()`方法或发生异常后，进入终止状态。
- **Waiting**和**Timed Waiting**到**Terminated**：如果线程在等待中被中断（抛出`InterruptedException`），也会进入终止状态。

## 27. start和run的区别

**答案**：

- **start**方法：用于启动线程，使线程进入就绪状态，由系统调度执行`run`方法。调用`start`会创建新线程。
- **run**方法：线程实际执行的任务内容。如果直接调用`run`方法，不会创建新线程，任务会在当前线程执行，起不到并发效果。

## 28. sleep和wait的区别

**答案**：

- **sleep**：属于Thread类，暂停线程指定时间后自动恢复执行，不释放锁。
- **wait**：属于Object类，必须在同步块中使用，释放锁并进入等待队列，直到其他线程调用notify/notifyAll方法唤醒。

## 29. synchronized和volatile的区别

**答案**：

- **synchronized**：用于线程同步，确保同一时刻只有一个线程访问某资源，保证可见性和原子性。
- **volatile**：用于保证变量的可见性，使其他线程及时看到变量值的更新，但不保证原子性。

## 30. AtomicInteger类的原理

**答案**：

`AtomicInteger`基于CAS（Compare and Swap）实现，通过无锁机制提供原子性操作，能在线程竞争下保持高效。CAS原理依赖于CPU指令，避免了加锁带来的性能开销。

## 31. ThreadLocal理解和原理

**答案**：

**ThreadLocal**用于为每个线程提供独立的变量副本，避免多个线程之间变量相互干扰。每个线程通过ThreadLocal访问的变量只属于当前线程，典型应用场景是为线程提供独立的数据库连接、会话信息等资源。

## 32. 谈谈你对ThreadLocal的理解

**答案**：

ThreadLocal是实现线程隔离的有效方式，不同于synchronized等锁机制，ThreadLocal不用于线程间共享数据，而是为每个线程创建独立副本，避免线程安全问题，典型场景包括用户会话、数据库连接等。

## 33. 谈谈你对线程安全的理解

**答案**：

**线程安全**是指在多线程环境中对共享数据的访问不会出现错误，通常通过加锁（如synchronized）和无锁（如CAS）两类方式实现，确保操作的原子性和数据的可见性。

## 34. JDK提供的线程池有哪些？实际开发我们该怎么使用

**答案**：

JDK提供的线程池主要有：

1. **FixedThreadPool**：固定大小线程池，适合稳定负载。
2. **CachedThreadPool**：缓存线程池，适合处理短生命周期任务。
3. **SingleThreadExecutor**：单线程池，确保任务按顺序执行。
4. **ScheduledThreadPool**：支持定时任务。
5. **WorkStealingPool**：基于任务窃取算法，适合并行计算。
实际开发中，合理选择线程池类型，配置合适的线程数，并确保对资源管理（如队列、超时时间）和异常处理。

## 35. Sleep和wait的区别

**答案**：

**sleep**不会释放锁资源，而**wait**在同步代码块中会释放锁，且需要被notify/notifyAll唤醒。

## 36. 一个普通main方法的执行，是单线程模式还是多线程模式？为什么

**答案**：

普通的main方法执行是**单线程**的，因为main方法由JVM以单个线程（主线程）启动，除非在代码中显式创建新线程。

## 37. 创建线程的方式

**答案**：

Java中创建线程的方式有三种：

1. **继承Thread类**：重写run方法，调用start启动。
2. **实现Runnable接口**：实现run方法，避免单继承限制，传入Thread构造函数中。
3. **实现Callable接口**：实现call方法，有返回值，配合FutureTask使用。
