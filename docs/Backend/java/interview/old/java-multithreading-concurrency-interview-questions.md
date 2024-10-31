---
title: java多线程、并发常见面试问题
tags: java, Multithreading, Concurrency, interview,多线程, 并发, 面试
categories: 
  - java

thumbnail: /gallery/blue-water12.jpg
---

今天我们将通过研究java多线程面试问题同时也研究并发面试问题，因为多线程和并发密不可分。线程是Java面试中的热门话题之一。在这里我从面试的角度列出了大部分重要的java多线程面试问题，不过您应该对java线程有很好的了解，才能应付以下问题。

<!-- more -->

## Java多线程面试问题

1. 进程和线程有什么区别？
2. 多线程编程有哪些好处？
3. 用户线程和守护线程有什么区别？
4. 我们如何在Java中创建一个线程？
5. 线程生命周期中有什么不同的状态？
6. 我们可以调用Thread类的run()方法吗？
7. 我们如何在特定时间暂停线程执行？
8. 你对线程优先级有什么了解？
9. 什么是线程计划和时间切片？
10. 什么是多线程中的上下文切换？
11. 我们如何确保main()是Java程序中完成的最后一个线程？
12. 线程如何相互通信？
13. 为什么线程通信方法wait()，notify()和notifyAll()都在Object类中？
14. 为什么wait()，notify()和notifyAll()方法必须从synchronized方法或块调用？
15. 为什么线程sleep()和yield()方法是静态的？
16. 我们如何在Java中实现线程安全？
17. 在Java中的volatile关键字是什么？
18. 同步方法或同步块哪个是更优选择？
19. 如何在Java中创建守护进程线程？
20. 什么是ThreadLocal？
21. 什么是线程组？ 为什么建议不要使用它？
22. 什么是Java线程Dump，我们如何获得程序的Java线程Dump？
23. 什么是死锁？ 如何分析和避免死锁的情形？
24. 什么是Java时间类？ 如何安排任务在特定间隔时间后运行？
25. 什么是线程池？ 我们如何在Java中创建线程池？
26. 如果我们不覆盖线程类run()方法，会发生什么？

## Java并发访问问题

1. 什么是原子操作？ Java并发API中的原子类是什么？
2. 什么是Java并发API中的锁接口？ 与同步相比有什么好处？
3. 什么是Executors框架？
4. 什么是阻塞队列？ 我们如何使用阻塞队列实现生产者-消费者问题？
5. 什么是Callable和Future？
6. 什么是FutureTask类？
7. 什么是Concurrent Collection类？
8. 什么是Executors类？
9. Java 8中的并发API的一些改进是什么？


## Java多线程面试问题答案

### 1. 进程和线程有什么区别？

进程是一个自包含的执行环境，它可以被看作一个程序或应用程序，而线程是一个单独的执行任务。 Java运行时环境作为单个进程运行，它包含不同的类和作为进程运行的程序。线程可以称为轻量级进程。 线程需要较少的资源来创建并存在于进程中，线程共享进程资源。

### 2. 多线程编程有哪些好处？

在多线程编程中，多个线程同时执行，提高了性能，是因为CPU不空闲，一些线程正在等待获取一些资源。 多个线程共享堆内存，因此创建多个线程来执行某些任务比创建多个进程更好。 例如，Servlet的性能比CGI更好，因为Servlet支持多线程，但CGI不支持。

### 3. 用户线程和守护线程有什么区别？

当我们在java程序中创建一个线程时，它被称为用户线程。 守护线程在后台运行，不会阻止JVM终止。 当没有用户线程运行时，JVM关闭程序并退出。 从守护线程创建的子线程也是一个守护线程。

### 4. 我们如何在Java中创建一个线程？

在Java中创建线程有两种方法 - 第一种方式是实现Runnable接口，然后从中创建线程对象，第二种方法是扩展Thread类。 阅读这篇文章了解更多关于[在java中创建线程](https://www.journaldev.com/1016/java-thread-example) 。

### 5. 线程生命周期中有什么不同的状态？

当我们在java程序中创建一个线程时，它的状态是New。 然后我们启动将其状态更改为Runnable的线程。 线程调度器负责将CPU分配给Runnable线程池中的线程，并将其状态更改为Running。 其他线程状态是 Waiting, Blocked和Dead。 阅读这篇文章，了解[线程生命周期](https://www.journaldev.com/1044/thread-life-cycle-in-java-thread-states-in-java)的更多信息。

### 6. 我们可以调用Thread类的run()方法吗？

可以，我们可以调用Thread类的run()方法，但它的行为就像一个普通的方法。 要在一个线程中执行它时，我们需要先使用**Thread.start()**方法启动它。

### 7. 我们如何在特定时间暂停线程执行？

我们可以使用Thread类sleep()方法暂停执行线程一段时间。 请注意，线程在特定时间内不会停止处理，一旦线程从睡眠状态唤醒，状态变为可运行，并且基于线程调度计划，它将被执行。

### 8. 你对线程优先级有什么了解？

每个线程都有一个优先级，通常较高优先级的线程在执行时优先，但这取决于依赖于操作系统的Thread Scheduler实现。 我们可以指定线程的优先级，但不能保证较高优先级的线程在低优先级线程之前被执行。 线程优先级是一个int，其值从1到10，其中1是最低优先级线程，10是最高优先级线程。

### 9. 什么是线程计划和时间切片？

线程调度程序（Thread Scheduler）是将CPU时间分配给可用的可运行线程的操作系统服务。 一旦我们创建和启动一个线程，它的执行取决于Thread Scheduler的实现。时间切片是将可用CPU时间划分为可用的可运行线程的过程。 CPU时间到线程的分配可以基于线程优先级，或线程等待更长时间将获得CPU时间的优先级。 线程调度不能由java控制，因此从应用程序本身控制它总是更好。

### 10. 什么是多线程中的上下文切换？

上下文切换（Context Switching）是存储和恢复CPU状态的过程，以便可以在稍后时间点从同一点恢复线程执行。 上下文切换（Context Switching）是多任务操作系统的基本特性，并支持多线程环境。

### 11. 我们如何确保main()是Java程序中完成的最后一个线程？

我们可以使用线程`join()`方法来确保程序创建的所有线程在完成主函数之前都已经结束。`join()`方法用于指定指定的线程结束后，才执行当前线程。这是一篇关于[线程join方法](https://www.journaldev.com/1024/java-thread-join-example)的文章。

### 12. 线程间如何通信？

当线程共享资源时，线程之间的通信对协调其工作很重要。 Object类中的`wait()`，`notify()`和`notifyAll()`方法允许线程通过资源的锁进行通信。 查看这篇文章了解更多关于 {% post_link java-thread-wait-notify-and-notifyall-example 线程wait()，notify()和notifyAll() %}。

### 13. 为什么线程通信方法wait()，notify()和notifyAll()都在Object类中？

在Java中，每个对象都有一个监视器和wait，notify方法用于等待对象监视器或通知其他线程对象监视器现在是空闲的。 java中的线程没有监视器，同步可以用于任何对象，这就是为什么它是Object类的一部分的原因，所以java中的每个类都有这些线程间通信的基本方法。

### 14. 为什么wait()，notify()和notifyAll()方法必须从synchronized方法或块调用？

当一个线程在任何对象上调用wait（）时，它必须在该对象上有监视器，它将离开并进入等待状态，直到任何其他线程调用该对象的notify（）为止。 

同样，当一个线程在任何对象上调用notify（）时，它将把该监视器留在该对象上，其他等待的线程可以获得该对象上的监视器。 由于所有这些方法都要求线程具有对象监视器，这只能通过同步来实现，所以它们需要从同步方法或块中调用。

### 15. 为什么线程sleep()和yield()方法是静态的？

线程sleep()和yield()方法工作在当前正在执行的线程。 因此，在等待状态的其他线程上调用这些方法没有意义。 这就是为什么这些方法是静态的，所以当这种方法被静态调用时，它可以在当前执行的线程上运行，并可避免混淆程序员，否则他们可能认为他们可以在一些非运行的线程上调用这些方法。

### 16. 我们如何在Java中实现线程安全？

有几种方法可以实现java中的线程安全 - 同步，原子并发类，实现并发Lock接口，使用volatile关键字，使用不可变类和线程安全类。 了解更多[线程安全教程](https://www.journaldev.com/1061/thread-safety-in-java)。

### 17. 在Java中的volatile关键字是什么？

当我们将volatile关键字与变量一起使用时，所有的线程都直接从内存中读取它的值，并且不缓存它。这可确保读取的值与内存中的值相同。

### 18. 同步方法或同步块哪个是更优选择？

同步块是更优选择，因为它不锁定对象，同步方法锁定对象，并且如果类中有多个同步块，即使它们不相关，为了获取对象锁，也会阻止它们执行并使它们处于等待状态。

### 19. 如何在Java中创建守护进程线程？

在调用start()方法之前，使用Thread类setDaemon(true)方法创建守护线程。否则它将抛出IllegalThreadStateException。

### 20. 什么是ThreadLocal？

Java ThreadLocal用于创建线程局部变量。 我们知道一个对象的所有线程都共享它的变量，所以如果变量不是线程安全的，我们可以使用同步，但如果我们想避免同步，我们可以使用ThreadLocal变量。 

每个线程都有自己的ThreadLocal变量，它们可以使用它的get()和set()方法来获取默认值，或者将它的本地值更改为Thread。 ThreadLocal实例通常是希望将状态与线程关联的类中的私有静态字段。 查看小示例程序[ThreadLocal示例](https://www.journaldev.com/1076/java-threadlocal-example)。

### 21. 什么是线程组？ 为什么建议不要使用它？

线程组(ThreadGroup)是一个类，旨在提供有关线程组的信息。 ThreadGroup API很弱，并没有任何Thread提供的功能。 它的主要特点是获取线程组中的活动线程列表，并为线程设置未捕获的异常处理程序。 但Java 1.5添加了setUncaughtExceptionHandler（UncaughtExceptionHandler eh）方法，我们可以向线程添加未捕获的异常处理程序。 所以ThreadGroup已经过时了，因此不建议再使用了。
```java
t1.setUncaughtExceptionHandler(new UncaughtExceptionHandler(){

@Override
public void uncaughtException(Thread t, Throwable e) {
    System.out.println("exception occured:"+e.getMessage());
}
            
});
```

### 22. 什么是Java线程Dump，我们如何获得程序的Java线程Dump？

线程Dump是JVM中活动的所有线程的列表，线程Dump非常有助于分析应用程序中的瓶颈并分析死锁情况。有很多方法可以为我们生成线程Dump - 使用Profiler，Kill -3命令，jstack工具等。我喜欢jstack工具来生成程序的线程Dump，因为它易于使用，并附带JDK安装。由于它是一个基于终端的工具，我们可以创建脚本来定期生成线程Dump，以便稍后进行分析。 阅读这篇文章了解更多关于[在java中生成线程Dump](https://www.journaldev.com/1053/java-thread-dump-visualvm-jstack-kill-3-jcmd)。

### 23. 什么是死锁？ 如何分析和避免死锁的情形？

死锁是一种编程情况，其中两个或多个线程被永久阻塞，这种情况出现在至少两个线程和两个或更多资源中。

为了分析一个死锁，我们需要查看应用程序的java线程Dump，我们需要注意线程的状态为BLOCKED，然后是资源等待锁定，每个资源都有一个唯一的ID，我们可以找到哪个线程已经在对象上保持锁定。

避免嵌套锁定，仅需要锁定什么是必需的，并且避免无限期地等待是避免死锁情况的常见方法，请阅读本文以了解如何使用示例程序[分析java中的死锁](https://www.journaldev.com/1058/deadlock-in-java-example)。

### 24. Java Timer类是什么？ 如何安排任务在特定间隔时间后运行？

java.util.Timer是一个实用工具类，可用于安排在将来某个特定时间执行的线程。 Java Timer类可用于计划一次运行的任务或定期运行的任务。

java.util.TimerTask是一个实现Runnable接口的抽象类 ，我们需要扩展这个类来创建可以使用java Timer类调度的我们自己的TimerTask。

查看这篇文章[java定时器](https://www.journaldev.com/1050/java-timer-timertask-example)的例子 。

### 25. 什么是线程池？ 我们如何在Java中创建线程池？

线程池是管理工作线程的池子，它包含一个队列，可以让任务等待执行。

线程池是管理Runnable线程和从队列中执行Runnable的工作线程。

java.util.concurrent.Executors提供java.util.concurrent.Executor接口的实现，用以在java中创建线程池。 [线程池示例](https://www.journaldev.com/1069/threadpoolexecutor-java-thread-pool-example-executorservice)程序显示如何在java中创建和使用Thread Pool。 或者读取[ScheduledThreadPoolExecutor示例](https://www.journaldev.com/2340/java-scheduler-scheduledexecutorservice-scheduledthreadpoolexecutor-example)来了解如何在一定的延迟之后执行任务。

### 26. 如果我们不覆盖线程类run()方法，会发生什么？

线程类run()方法的代码如下所示。
```java
public void run() {
    if (target != null) {
        target.run();
    }
}
```
以上目标设置在Thread类的init()方法中，如果我们创建一个Thread类的实例作为new TestThread() ，它设置为null。 所以如果我们不覆盖run()方法，就不会发生任何事情。 下面是一个简单的例子来说明这一点。
```java
public class TestThread extends Thread {

    //not overriding Thread.run() method
    
    //main method, can be in other class too
    public static void main(String args[]){
        Thread t = new TestThread();
        System.out.println("Before starting thread");
        t.start();
        System.out.println("After starting thread");
    }
}
```
它将仅打印输出和终止。
```
Before starting thread
After starting thread
```


## Java并发访问问题答案

### 1. 什么是原子操作？ Java并发API中的原子类是什么？

原子操作在单个任务单元中执行，而不受其他操作的干扰。 原子操作在多线程环境中是必需的，以避免数据不一致。

int++不是原子操作。 所以当一个线程读取它的值并将其增加一个时，其他线程读取旧的值导致错误的结果。

为了解决这个问题，我们必须确保在count上的增量操作是原子的，我们可以使用Synchronization来实现，但是Java 5 java.util.concurrent.atomic为int和long提供了可以用来实现这个原子的包装类不使用同步。 转到这篇文章了解更多关于[原子并发类](https://www.journaldev.com/1095/atomicinteger-java) 。

### 2. 什么是Java并发API中的锁接口？ 与同步相比有什么好处？

锁定界面提供比使用synchronized方法和语句可以获得的更广泛的锁定操作。 它们允许更灵活的结构化，可能具有完全不同的属性，并且可以支持多个相关联的Condition对象。 
锁的优点是

* 有可能使他们公平
* 在等待Lock对象时，可以使线程响应中断。
* 有可能尝试获取锁定，但如果无法获取锁定，则立即返回或超时后返回
* 可以在不同的范围内以不同的顺序获取和释放锁
阅读更多[Java Lock示例](https://www.journaldev.com/2377/java-lock-example-reentrantlock) 。

### 3. 什么是Executors框架？

在Java 5中，Executor框架被引入了java.util.concurrent.Executor接口。

执行器框架是根据一组执行策略来标准化异步任务的调用，调度，执行和控制的框架。

创建许多线程没有限制到最大阈值可能导致应用程序用尽堆内存。 所以，创建一个ThreadPool是一个更好的解决方案，因为有限数量的线程可以被汇集和重用。 执行器框架促进了在Java中创建线程池的过程。 查看这篇文章，学习使用Executors框架创建线程池的示例代码。


### 4. 什么是阻塞队列？ 我们如何使用阻塞队列实现生产者-消费者问题？

java.util.concurrent.BlockingQueue是一个队列，支持在检索和删除元素时等待队列变为非空的操作，并在添加元素时等待队列中的空间变得可用。

如果尝试在队列中存储空值，BlockingQueue不接受空值并抛出NullPointerException。

BlockingQueue实现是线程安全的。 所有排队方法本质上都是原子的，并使用内部锁或其他形式的并发控制。

BlockingQueue接口是java集合框架的一部分，它主要用于实现生产者消费者问题。 
使用BlockingQueue检查此帖子的生产者 - 消费者问题实现 。


### 5. 什么是Callable和Future？

Java 5在Concurrency包中引入了类似于Runnable接口的java.util.concurrent.Callable接口，但它可以返回任何Object并且能够抛出异常。

可调用接口使用Generic来定义Object的返回类型。 执行器类提供了有用的方法来在线程池中执行Callable。 由于可调用任务并行运行，我们必须等待返回的对象。 可调用任务返回java.util.concurrent.Future对象。 使用未来，我们可以找到可调用任务的状态并获取返回的对象。 它提供可以等待Callable完成的get（）方法，然后返回结果。 
检查这个帖子可以调用未来的例子 。


### 6. 什么是FutureTask类？

FutureTask是Future接口的基本实现类，我们可以使用Executors进行异步处理。 大多数情况下，我们不需要使用FutureTask类，但如果我们想覆盖Future接口的某些方法并希望保留大部分的基本实现，那么它将非常方便。 我们只能扩展这个类，并根据我们的要求重写方法。 查看Java FutureTask示例文章，了解如何使用它，以及其具有的不同方法。


### 7. 什么是Concurrent Collection类？

Java集合类是故障快速的，这意味着如果在某些线程使用迭代器遍历它时，集合将被更改，则iterator.next（）将抛出ConcurrentModificationException。

并发收集类支持检索的完全并发性和可更新的可预期并发性。 
主要类是ConcurrentHashMap，CopyOnWriteArrayList和CopyOnWriteArraySet，请检查此帖子，以了解如何在使用迭代器时避免ConcurrentModificationException异常 。


### 8. 什么是Executors类？

Executors类为Executor，ExecutorService，ScheduledExecutorService，ThreadFactory和Callable类提供实用程序方法。

执行器类可以用来轻松地在java中创建Thread Pool，这也是支持Callable实现的唯一类。

### 9. Java 8中的并发API的一些改进是什么？

一些重要的并发API增强功能是：

ConcurrentHashMap compute（），forEach（），forEachEntry（），forEachKey（），forEachValue（），merge（），reduce（）和search（）方法。
可以明确完成的CompletableFuture（设置其值和状态）。
执行者newWorkStealingPool（）方法创建使用所有可用处理器作为其目标并行级别的工作窃取线程池。

[原文](https://www.journaldev.com/1162/java-multithreading-concurrency-interview-questions-answers)




