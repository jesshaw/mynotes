# Tomcat

## Tomcat7，8区别

区别不大，Tomcat7有BIO和NIO。Tomcat8增加了AIO(或叫NIO2或者叫APR)

- BIO方式适用于连接数目比较小且固定的架构，这种方式对服务器资源要求比较高，并发局限于应用中，JDK1.4以前的唯一选择，但程序直观简单易理解。
- NIO方式适用于连接数目多且连接比较短(轻操作)的架构，比如聊天服务器，并发局限于应用中，编程比较复杂，JDK1.4开始支持。 
- AIO方式使用于连接数目多且连接比较长(重操作)的架构，比如相册服务器，充分调用OS参与并发操作，编程比较复杂，JDK7开始支持。

这三种模式的不同之处如下：

- BIO：一个线程处理一个请求。缺点：并发量高时，线程数较多，浪费资源。Tomcat7或以下，在 Linux 系统中默认使用这种方式。
- NIO：利用Java的异步IO处理，可以通过少量的线程处理大量的请求。Tomcat8在Linux系统中默认使用这种方式。
- AIO(APR)：即Apache Portable Runtime，从操作系统层面解决io阻塞问题。

## Tomcat部署方式有哪几种

war包部署，文件夹部署，xml配置部署（即标识符部署）

## Tomcat四大容器

Engine, Host, Context, Wrapper。前四大窗口为包含关系，包含多个。Wrapper包含多个Servlet。

## Tomcat通信

操作系统实现TCP可靠传输。TCP三次握手 SYN--->SYN-ACK--->ACK

通过Socket通创建TCP连接。

## IO模型

Tomcat7有BIO，NIO。Tomcat8增加了AIO。

Endpoint来区分

BIO中一个socket连接对应一个线程。多个http对应一个线程。