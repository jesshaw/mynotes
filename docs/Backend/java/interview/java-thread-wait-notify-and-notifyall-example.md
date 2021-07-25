---
title: Java Thread wait, notify and notifyAll 示例
tags: java, Thread, wait, notify, notifyAll, 等待, 通知, 通知所有
categories: 
  - java

thumbnail: /gallery/blue-water1.jpg
---

java中的Object类包含三个允许线程就资源的锁定状态进行通信的最终（final）方法，。他们是`wait()`，`notify()`，和`notifyAll()` 。 今天我们将通过java程序来研究wait，notify和notifyAll。

<!-- more -->

## Java多线程面试问题

<a name="menu"></a>
1. [Java中的wait，notify和notifyAll](#1)
1.1 [wait](#1.1)
1.2 [notify](#1.2)
1.3 [notifyAll](#1.3)
1.4 [消息](#1.4)
1.5 [等待者](#1.5)
1.6 [通知者](#1.6)
1.7 [等待通知测试](#1.7)


## <a name="1"></a>[1. Java中的wait，notify和notifyAll](#menu)

任何对象调用这些方法的当前线程应具有对象监视器，否则会抛出java.lang.IllegalMonitorStateException异常。


 
### <a name="1.1"></a>[1.1 wait](#menu)

对象wait方法有三种实现，其中一种实现是等待任何其他线程无限期地调用对象的notify或notifyAll方法来唤醒当前线程。 其他两种实现会使当前线程在唤醒之前等待特定的时间。

### <a name="1.2"></a>[1.2 notify](#menu)

notify方法只唤醒等待对象的一个​​线程，并且该线程开始执行。所以如果有多个线程在等待一个对象，这个方法只会唤醒其中的一个。线程的选择取决于线程管理的OS实现。

### <a name="1.3"></a>[1.3 notifyAll](#menu)

notifyAll方法唤醒等待对象的所有线程，但哪一个将首先处理取决于OS实现。


这些方法可用于实现**生产者消费者问题**，其中消费者线程正在等待队列中的对象，生产者线程将对象放入队列中并通知等待的线程。

让我们来看一个例子，其中多个线程在同一个对象上工作，我们使用wait，notify和notifyAll方法。

### <a name="1.4"></a>[1.4 消息](#menu)

Java bean将在线程上工作，并调用wait和notify方法。
```java
public class Message {
    private String msg;

    public Message(String str){
        this.msg=str;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String str) {
        this.msg=str;
    }
}
 ```
### <a name="1.5"></a>[1.5 等待者](#menu)

将等待其他线程调用notify方法来完成处理的类。 请注意，等待者线程使用同步块方式在Message对象上拥有监视器。
```java
public class Waiter implements Runnable{
    
    private Message msg;
    
    public Waiter(Message m){
        this.msg=m;
    }

    @Override
    public void run() {
        String name = Thread.currentThread().getName();
        synchronized (msg) {
            try{
                System.out.println(name+" waiting to get notified at time:"+System.currentTimeMillis());
                msg.wait();
            }catch(InterruptedException e){
                e.printStackTrace();
            }
            System.out.println(name+" waiter thread got notified at time:"+System.currentTimeMillis());
            //process the message now
            System.out.println(name+" processed: "+msg.getMsg());
        }
    }

}
```

### <a name="1.6"></a>[1.6 通知者](#menu)

一个将要处理消息对象的类，然后调用notify方法来唤醒等待消息对象的线程。请注意，同步块用于拥有Message对象的监视器。
```java

public class Notifier implements Runnable {

    private Message msg;
    
    public Notifier(Message msg) {
        this.msg = msg;
    }

    @Override
    public void run() {
        String name = Thread.currentThread().getName();
        System.out.println(name+" started");
        try {
            Thread.sleep(1000);
            synchronized (msg) {
                msg.setMsg(name+" Notifier work done");
                msg.notify();
                // msg.notifyAll();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
    }

}
```

### <a name="1.7"></a>[1.7 等待通知测试](#menu)

测试类将创建Waiter和Notifier的多个线程并启动它们。
```java
public class WaitNotifyTest {

    public static void main(String[] args) {
        Message msg = new Message("process it");
        Waiter waiter = new Waiter(msg);
        new Thread(waiter,"waiter").start();
        
        Waiter waiter1 = new Waiter(msg);
        new Thread(waiter1, "waiter1").start();
        
        Notifier notifier = new Notifier(msg);
        new Thread(notifier, "notifier").start();
        System.out.println("All the threads are started");
    }

}
 ```
当我们调用上面的程序的时候，我们会看到下面的输出，但是程序不会完成，因为有两个线程在等待Message对象，而notify（）方法只唤醒其中的一个，另一个线程还在等待通知。

```java
waiter waiting to get notified at time:1356318734009
waiter1 waiting to get notified at time:1356318734010
All the threads are started
notifier started
waiter waiter thread got notified at time:1356318735011
waiter processed: notifier Notifier work done
```
如果我们注释notify（）调用并不注释Notifier类中的notifyAll（）调用，则下面将生成输出。
```java
waiter waiting to get notified at time:1356318917118
waiter1 waiting to get notified at time:1356318917118
All the threads are started
notifier started
waiter1 waiter thread got notified at time:1356318918120
waiter1 processed: notifier Notifier work done
waiter waiter thread got notified at time:1356318918120
waiter processed: notifier Notifier work done
```
由于notifyAll（）方法唤醒所有Waiter线程和程序完成，并在执行后终止。 这就是所有在Java的wait，notify和notifyAll方法。

[原文](https://www.journaldev.com/1037/java-thread-wait-notify-and-notifyall-example)




