# 多线程与并发

以下是Java多线程与并发相关的常见面试题及其答案，涵盖线程基础、并发包、线程安全机制等方面：

## 1. **什么是线程？线程和进程的区别是什么？**

**答案**：线程是程序执行的最小单元，而进程是资源分配的最小单元。一个进程可以包含多个线程，线程共享进程的内存空间。相比进程间通信，线程间通信更高效。

## 2. **创建线程的几种方法？**

**答案**：
    - **继承Thread类**：重写`run()`方法。
    - **实现Runnable接口**：实现`run()`方法，将实例传给`Thread`对象。
    - **实现Callable接口**：实现`call()`方法，返回一个`Future`对象。

## 3. **什么是线程安全？如何保证线程安全？**

**答案**：线程安全指多个线程同时访问共享资源时，程序行为仍然符合预期。常见的线程安全实现方法：
    - 使用同步块（`synchronized`关键字）。
    - 使用并发类（如`ConcurrentHashMap`）。
    - 使用`volatile`关键字。
    - 使用线程安全的集合（如`CopyOnWriteArrayList`）。

## 4. **synchronized的原理是什么？**

**答案**：`synchronized`通过对象的内置锁（或称监视器）来保证方法或代码块在同一时刻只能被一个线程执行，防止多线程同时访问共享资源。JVM中的Monitor（监视器）锁实现了` synchronized`，每个对象有一个监视器锁。

## 5. **Java中`synchronized`和`ReentrantLock`的区别？**

**答案**：
    - `ReentrantLock`提供了更灵活的锁机制，支持公平锁、非公平锁选择，提供了锁的超时获取、可中断和多条件锁等功能。
    - `synchronized`是JVM层面实现，性能在JDK 1.6后优化。
    - `ReentrantLock`需要手动释放锁，而`synchronized`是自动的。

## 6. **什么是线程池？为什么使用线程池？**

**答案**：线程池管理并复用固定数量的线程，避免频繁创建和销毁线程带来的性能开销。它提高了程序的并发性、资源利用率，避免线程过多导致系统性能下降。

## 7. **线程池的几种常见类型？**

**答案**：
    - `FixedThreadPool`：固定大小的线程池。
    - `CachedThreadPool`：可根据需求动态扩容。
    - `SingleThreadExecutor`：单线程池，确保任务串行执行。
    - `ScheduledThreadPool`：支持定时或周期性任务执行。

## 8. **什么是`Future`和`Callable`？**

**答案**：
    - **`Callable`**：与`Runnable`类似，但可以返回结果并抛出异常。
    - **`Future`**：表示异步任务的结果，提供了检查任务完成状态、获取结果和取消任务的方法。

## 9. **volatile关键字的作用是什么？**

**答案**：`volatile`保证了变量的可见性，即当一个线程修改了变量的值，其他线程立即可见。`volatile`不会保证操作的原子性，所以仅在非复合操作的共享变量使用。

## 10. **什么是死锁？如何避免死锁？**

**答案**：死锁是指两个或多个线程相互持有对方所需的锁，导致无法继续执行。避免死锁的方法包括：

- 避免嵌套锁定。
- 使用`tryLock()`等带超时功能的锁。
- 为每个锁规定获取顺序。
- 尽量减少锁的粒度。

## 11. **Java中的原子类是什么？**

**答案**：原子类（`AtomicInteger`、`AtomicLong`等）提供了一种锁机制外的线程安全方式，使用CAS（Compare and Swap）操作保证操作的原子性，适合高并发场景。

## 12. **什么是CAS操作？**

**答案**：CAS是Compare-And-Swap的简称，通过比较和交换值确保更新操作的原子性。CAS包含三个参数：内存值、期望值和更新值。当内存值与期望值相等时才将其更新为新值，否则重试。

## 13. **什么是`ThreadLocal`？**

**答案**：`ThreadLocal`为每个线程提供独立的变量副本，使变量在多线程环境中互不影响，适合线程间不共享状态的情况。

## 14. **Java中的锁有几种类型？**

**答案**：
    - **偏向锁**：减少无竞争的线程获取锁的开销。
    - **轻量级锁**：通过CAS操作实现，在竞争不激烈的情况下快速获取锁。
    - **重量级锁**：依赖OS内核的互斥量实现，适用于高竞争的场景。
    - **读写锁**（`ReentrantReadWriteLock`）：分为读锁和写锁，读读不互斥，写写和读写互斥。

## 15. **Java并发包中有哪些常见的并发工具类？**

**答案**：包括`CountDownLatch`、`CyclicBarrier`、`Semaphore`、`Exchanger`、`Phaser`等。
    - **CountDownLatch**：计数器减到0时释放所有等待的线程。
    - **CyclicBarrier**：允许一组线程相互等待，适合多线程计算。
    - **Semaphore**：限制多个线程同时访问共享资源。
    - **Exchanger**：允许两个线程交换数据。

## 16. **什么是无锁、偏向锁和轻量级锁？**

**答案**：
    - **无锁**：不使用任何锁机制，通常借助CAS操作实现原子性。
    - **偏向锁**：锁竞争不激烈的情况下，线程将获得对象的偏向锁，减少锁的开销。
    - **轻量级锁**：使用自旋和CAS操作，适用于短时间的竞争。

## 17. **什么是`AQS`？它是如何工作的？**

**答案**：`AQS`（AbstractQueuedSynchronizer）是实现Java锁和同步器的基础框架。它使用一个FIFO等待队列管理同步状态，提供了`acquire`、`release`等方法以控制线程的访问。

## 18. **`ReentrantLock`与`Synchronized`的实现区别？**

**答案**：
    - **ReentrantLock**是基于AQS实现，功能更丰富，支持公平锁、非公平锁选择。
    - **Synchronized**是基于JVM实现，1.6之后引入了偏向锁、轻量级锁等优化机制。

## 19. **`CountDownLatch`和`CyclicBarrier`的区别？**

**答案**：`CountDownLatch`用于线程等待，倒数到0时唤醒等待线程，适合一方等待多方完成任务；`CyclicBarrier`用于多线程相互等待，适合多线程并发分阶段执行的场景。

## 20. **什么是分段锁？`ConcurrentHashMap`的实现原理是什么？**

**答案**：分段锁将锁分成多个段（Java 8之前`ConcurrentHashMap`实现方式），不同段可以并发访问。Java 8之后，`ConcurrentHashMap`基于CAS和`Synchronized`实现，底层使用`Node`数组，结合红黑树优化性能。

## 21. **线程中断的原理是什么？如何使用线程的中断机制？**

**答案**：线程中断通过设置线程的中断标志实现，`interrupt()`方法不会强制终止线程。线程可以通过`isInterrupted()`检查中断标志，并在合适的地方响应中断。阻塞方法如`sleep()`、`wait()`被中断会抛出`InterruptedException`。

## 22. **什么是阻塞队列？阻塞队列有哪些实现类？**

**答案**：阻塞队列是一种支持线程间通信的队列，线程在队列为空时获取元素会阻塞。常见实现类有`ArrayBlockingQueue`、`LinkedBlockingQueue`、`PriorityBlockingQueue`、`DelayQueue`、`SynchronousQueue`等。

## 23. **什么是读写锁？如何使用`ReentrantReadWriteLock`？**

**答案**：读写锁分为读锁和写锁，多个线程可以并发获取读锁，但写锁是独占的。使用`ReentrantReadWriteLock
