---
title: Java类加载器
tags: java,class loader,类加载器
categories: 
  - java

thumbnail: /gallery/blue-water5.jpg
---

Java类加载器是项目开发中Java的一个重要但很少使用的组件。就个而言，我从来没有在任何项目中扩展ClassLoader，但有我自己的ClassLoader，可以自定义Java类加载的想法刺激我，写以篇文章。
<!-- more -->


## 目录
1. Java类加载器
&nbsp;&nbsp;&nbsp;&nbsp;1.1 什么是Java类加载器？
&nbsp;&nbsp;&nbsp;&nbsp;1.2 为什么在Java中编写自定义类加载器？
&nbsp;&nbsp;&nbsp;&nbsp;1.3 Java类加载器如何工作？
&nbsp;&nbsp;&nbsp;&nbsp;1.4 Java自定义ClassLoader
&nbsp;&nbsp;&nbsp;&nbsp;1.5 Java自定义ClassLoader执行步骤
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.5.1 由m29的评论更新
&nbsp;&nbsp;&nbsp;&nbsp;1.6 使用ClassLoader Java选项的Mac OS X 10.6.4问题


## Java类加载器


本文将提供Java类加载器的概述，然后在Java中创建自定义的ClassLoader。


 
### 什么是Java类加载器？

我们知道Java程序在Java虚拟机 （JVM）上运行。当我们编译一个Java类时，它将以平台和机器独立编译程序的字节码的形式进行转换，并将其存储为一个.class文件。之后，当我们尝试使用一个类时，Java类加载器会将该类加载到内存中。

Java中有三种类型的内置ClassLoader：

1. 引导类加载器（Bootstrap Class Loader） - 加载JDK内部类，通常加载rt.jar和其他核心类，例如java.lang。*包类
2. 扩展类加载器 - 它从JDK扩展目录加载类，通常是$ JAVA_HOME / lib / ext目录。
3. 系统类加载器 - 它从当前类路径加载类， 该类可以在使用-cp或-classpath命令行选项调用程序时进行设置。

Java类加载器是分层的，每当引发一个请求来加载一个类时，它就委托给它的父类加载器，这样在运行环境中就保持了唯一性。 如果父类加载器没有找到该类，那么类加载器自身会尝试加载该类。

让我们通过执行下面的java程序来理解这个：

`ClassLoaderTest.java`

```java
package com.lexiangmiao.classloader;

public class ClassLoaderTest {

	public static void main(String[] args) {

		System.out.println("class loader for HashMap: "
				+ java.util.HashMap.class.getClassLoader());
		System.out.println("class loader for DNSNameService: "
				+ sun.net.spi.nameservice.dns.DNSNameService.class
						.getClassLoader());
		System.out.println("class loader for this class: "
				+ ClassLoaderTest.class.getClassLoader());

		System.out.println(com.mysql.jdbc.Blob.class.getClassLoader());

	}

}
```
上面的Java类加载器示例程序的输出是：

```java
class loader for HashMap: null
class loader for DNSNameService: sun.misc.Launcher$ExtClassLoader@7c354093
class loader for this class: sun.misc.Launcher$AppClassLoader@64cbbe37
sun.misc.Launcher$AppClassLoader@64cbbe37
 ```

正如你所看到的，java.util.HashMap的ClassLoader是空的，它反映了Bootstrap类加载器，而DNSNameService类加载器是ExtClassLoader。 由于类本身在CLASSPATH中，所以System ClassLoader会加载它。

当我们试图加载HashMap的时候，我们的System ClassLoader把它委托给扩展类加载器，扩展类加载器又将其委派给Bootstrap ClassLoader，该类发现该类，并将其加载到JVM中。

DNSNameService类遵循相同的过程，但Bootstrap ClassLoader无法找到它，因为它在$ JAVA_HOME / lib / ext / dnsns.jar中，因此被扩展类加载器加载。 请注意，Blob类包含在MySql JDBC Connector jar（mysql-connector-java-5.0.7-bin.jar）中，在执行它之前，它已经包含在项目的构建路径中，并且它也通过System Class Loader 。

还有一点需要注意的是，由子类加载器加载的类可以看到由其父类加载器加载的类。 因此，由System ClassLoader加载的类可以看到由Extensions和Bootstrap ClassLoader加载的类。

如果有兄弟类加载器，则不能访问彼此加载的类。

### 为什么在Java中编写自定义类加载器？

Java默认的ClassLoader可以从本地文件系统加载足够大多数情况下的文件。 但是，如果您在加载类时在运行时或者从FTP服务器或通过第三方Web服务期望类，则必须扩展现有的类加载器。 例如，AppletViewers从远程Web服务器加载类。

### Java类加载器如何工作？

当JVM请求一个类时，它通过传递Class的完全限定的名字来调用ClassLoader的loadClass函数。

loadClass函数调用findLoadedClass()方法来检查类是否已经被加载。 需要避免多次加载课程。

如果Class尚未被加载，那么它将把请求委托给父类加载器来加载类。

如果父类加载器没有找到该类，那么它将调用findClass（）方法来查找文件系统中的类。

### Java自定义ClassLoader

我们将通过扩展ClassLoader类和重写loadClass（String name）方法来创建自己的ClassLoader。 如果名称将从com.journaldev（即我们的示例类包）开始，那么我们将使用我们自己的类加载器加载它，否则我们将调用父类ClassLoader的loadClass（）方法来加载类。

项目结构如下图所示：

Java类加载器，Java中的ClassLoader，Java Class Loader，Java类加载器示例
**CCLoader.java** ：这是我们的自定义类加载器，具有以下方法。

1. private byte[] loadClassFileData(String name) ：
此方法将从文件系统读取类文件到字节数组。
2. private Class getClass(String name) private Class getClass(String name)
这个方法将调用loadClassFileData（）函数，并通过调用父类的defineClass（）方法，它将生成类并返回它。
3. public Class loadClass(String name) public Class loadClass(String name) ：
这个方法负责加载类。 如果类名以com.journaldev（我们的示例类）开头，那么它将使用getClass（）方法加载它，否则将调用父类loadClass函数加载它。
4. public CCLoader(ClassLoader parent) ：
这是负责设置父ClassLoader的构造函数。

`CCLoader.java`

```java
 import java.io.DataInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
 
/**
 * Our Custom Class Loader to load the classes. Any class in the com.journaldev
 * package will be loaded using this ClassLoader. For other classes, it will
 * delegate the request to its Parent ClassLoader.
 *
 */
public class CCLoader extends ClassLoader {
 
    /**
     * This constructor is used to set the parent ClassLoader
     */
    public CCLoader(ClassLoader parent) {
        super(parent);
    }
 
    /**
     * Loads the class from the file system. The class file should be located in
     * the file system. The name should be relative to get the file location
     *
     * @param name
     *            Fully Classified name of class, for example com.journaldev.Foo
     */
    private Class getClass(String name) throws ClassNotFoundException {
        String file = name.replace('.', File.separatorChar) + ".class";
        byte[] b = null;
        try {
            // This loads the byte code data from the file
            b = loadClassFileData(file);
            // defineClass is inherited from the ClassLoader class
            // that converts byte array into a Class. defineClass is Final
            // so we cannot override it
            Class c = defineClass(name, b, 0, b.length);
            resolveClass(c);
            return c;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
 
    /**
     * Every request for a class passes through this method. If the class is in
     * com.journaldev package, we will use this classloader or else delegate the
     * request to parent classloader.
     *
     *
     * @param name
     *            Full class name
     */
    @Override
    public Class loadClass(String name) throws ClassNotFoundException {
        System.out.println("Loading Class '" + name + "'");
        if (name.startsWith("com.journaldev")) {
            System.out.println("Loading Class using CCLoader");
            return getClass(name);
        }
        return super.loadClass(name);
    }
 
    /**
     * Reads the file (.class) into a byte array. The file should be
     * accessible as a resource and make sure that its not in Classpath to avoid
     * any confusion.
     *
     * @param name
     *            File name
     * @return Byte array read from the file
     * @throws IOException
     *             if any exception comes in reading the file
     */
    private byte[] loadClassFileData(String name) throws IOException {
        InputStream stream = getClass().getClassLoader().getResourceAsStream(
                name);
        int size = stream.available();
        byte buff[] = new byte[size];
        DataInputStream in = new DataInputStream(stream);
        in.readFully(buff);
        in.close();
        return buff;
    }
}
 ```

**CCRun.java** ：

这是我们使用主函数的测试类，我们正在创建ClassLoader的对象，并使用它的loadClass方法加载样本类。 加载类之后，我们使用Java反射API来调用它的方法。

`CCRun.java`

```java
import java.lang.reflect.Method;
 
public class CCRun {
 
    public static void main(String args[]) throws Exception {
        String progClass = args[0];
        String progArgs[] = new String[args.length - 1];
        System.arraycopy(args, 1, progArgs, 0, progArgs.length);

        CCLoader ccl = new CCLoader(CCRun.class.getClassLoader());
        Class clas = ccl.loadClass(progClass);
        Class mainArgType[] = { (new String[0]).getClass() };
        Method main = clas.getMethod("main", mainArgType);
        Object argsArray[] = { progArgs };
        main.invoke(null, argsArray);

        // Below method is used to check that the Foo is getting loaded
        // by our custom class loader i.e CCLoader
        Method printCL = clas.getMethod("printCL", null);
        printCL.invoke(null, new Object[0]);
    }
 
}
```

**Foo.java和Bar.java** ：


 
这些是由我们的自定义类加载器加载的测试类。 他们还有一个printCL（）方法，被调用来打印已加载Class的ClassLoader。 Foo类将由我们的自定义类加载器加载，后者又使用Bar类，所以Bar类也将由我们的自定义类加载器加载。

`Foo.java`

```java
public class Foo {
    static public void main(String args[]) throws Exception {
        System.out.println("Foo Constructor >>> " + args[0] + " " + args[1]);
        Bar bar = new Bar(args[0], args[1]);
        bar.printCL();
    }
 
    public static void printCL() {
        System.out.println("Foo ClassLoader: "+Foo.class.getClassLoader());
    }
}
```

`Bar.java`

```java 
public class Bar {
 
    public Bar(String a, String b) {
        System.out.println("Bar Constructor >>> " + a + " " + b);
    }
 
    public void printCL() {
        System.out.println("Bar ClassLoader: "+Bar.class.getClassLoader());
    }
}
```
Java自定义ClassLoader执行步骤

首先我们将通过命令行编译所有的类。 之后，我们将通过传递三个参数来运行CCRun类。 第一个参数是Foo类的完整分类名称，它将被我们的类加载器加载。 其他两个参数传递给Foo类的main函数和Bar构造函数。 输出的执行步骤如下所示。

```java
 Pankaj$ javac -cp . com/journaldev/cl/Foo.java
Pankaj$ javac -cp . com/journaldev/cl/Bar.java
Pankaj$ javac CCLoader.java
Pankaj$ javac CCRun.java
CCRun.java:18: warning: non-varargs call of varargs method with inexact argument type for last parameter;
cast to java.lang.Class<?> for a varargs call
cast to java.lang.Class<?>[] for a non-varargs call and to suppress this warning
Method printCL = clas.getMethod("printCL", null);
^
1 warning
Pankaj$ java CCRun com.journaldev.cl.Foo 1212 1313
Loading Class 'com.journaldev.cl.Foo'
Loading Class using CCLoader
Loading Class 'java.lang.Object'
Loading Class 'java.lang.String'
Loading Class 'java.lang.Exception'
Loading Class 'java.lang.System'
Loading Class 'java.lang.StringBuilder'
Loading Class 'java.io.PrintStream'
Foo Constructor >>> 1212 1313
Loading Class 'com.journaldev.cl.Bar'
Loading Class using CCLoader
Bar Constructor >>> 1212 1313
Loading Class 'java.lang.Class'
Bar ClassLoader: CCLoader@71f6f0bf
Foo ClassLoader: CCLoader@71f6f0bf
ctk-pcs1313512-2:src pk93229$
 ```
如果仔细查看输出，首先尝试加载com.journaldev.cl.Foo类，但是由于它扩展了java.lang.Object类，它试图首先加载它，然后请求它来到CCLoader的loadClass方法，即委托它的父类。 所以父类加载器正在加载对象，字符串和其他Java类。 我们的ClassLoader只从调用printCL（）函数的文件系统中加载Foo和Bar类。

请注意，我们可以通过更改loadClassFileData（）函数来从FTP服务器读取字节数组，或通过调用任何第三方服务来即时获取类字节数组。

我希望这篇文章有助于理解Java类加载器的工作原理，以及如何将它扩展到只从文件系统中获取更多内容。

### 从m29的评论更新

当JVM使用Java选项启动时，我们可以将自定义类加载器设置为默认类加载器。 
例如，我将在提供java类加载器选项后再次运行ClassLoaderTest程序。

```java
Pankaj$ javac -cp .:../lib/mysql-connector-java-5.0.7-bin.jar com/journaldev/classloader/ClassLoaderTest.java
Pankaj$ java -cp .:../lib/mysql-connector-java-5.0.7-bin.jar -Djava.system.class.loader=CCLoader com.journaldev.classloader.ClassLoaderTest
Loading Class 'com.journaldev.classloader.ClassLoaderTest'
Loading Class using CCLoader
Loading Class 'java.lang.Object'
Loading Class 'java.lang.String'
Loading Class 'java.lang.System'
Loading Class 'java.lang.StringBuilder'
Loading Class 'java.util.HashMap'
Loading Class 'java.lang.Class'
Loading Class 'java.io.PrintStream'
class loader for HashMap: null
Loading Class 'sun.net.spi.nameservice.dns.DNSNameService'
class loader for DNSNameService: sun.misc.Launcher$ExtClassLoader@24480457
class loader for this class: CCLoader@38503429
Loading Class 'com.mysql.jdbc.Blob'
sun.misc.Launcher$AppClassLoader@2f94ca6c
Pankaj$
```

正如你所看到的，CCLoader正在加载ClassLoaderTest类，因为它在com.sanfor 包中。

### ClassLoader Java选项的Mac OS X 10.6.4问题

如果你在Mac OS上工作，上面的执行可能会抛出一些异常，但是它会成功执行。

```java
Pankaj$$ java -cp .:../lib/mysql-connector-java-5.0.7-bin.jar -Djava.system.class.loader=CCLoader com.journaldev.classloader.ClassLoaderTest
Intentionally suppressing recursive invocation exception!
java.lang.IllegalStateException: recursive invocation
    at java.lang.ClassLoader.initSystemClassLoader(ClassLoader.java:1391)
    at java.lang.ClassLoader.getSystemClassLoader(ClassLoader.java:1374)
    at sun.security.jca.ProviderConfig$1.run(ProviderConfig.java:64)
    at java.security.AccessController.doPrivileged(Native Method)
    at sun.security.jca.ProviderConfig.getLock(ProviderConfig.java:62)
    at sun.security.jca.ProviderConfig.getProvider(ProviderConfig.java:187)
    at sun.security.jca.ProviderList.getProvider(ProviderList.java:215)
    at sun.security.jca.ProviderList.getService(ProviderList.java:313)
    at sun.security.jca.GetInstance.getInstance(GetInstance.java:140)
    at java.security.cert.CertificateFactory.getInstance(CertificateFactory.java:148)
    at sun.security.pkcs.PKCS7.parseSignedData(PKCS7.java:244)
    at sun.security.pkcs.PKCS7.parse(PKCS7.java:141)
    at sun.security.pkcs.PKCS7.parse(PKCS7.java:110)
    at sun.security.pkcs.PKCS7.<init>(PKCS7.java:92)
    at sun.security.util.SignatureFileVerifier.<init>(SignatureFileVerifier.java:80)
    at java.util.jar.JarVerifier.processEntry(JarVerifier.java:256)
    at java.util.jar.JarVerifier.update(JarVerifier.java:188)
    at java.util.jar.JarFile.initializeVerifier(JarFile.java:321)
    at java.util.jar.JarFile.getInputStream(JarFile.java:386)
    at sun.misc.JarIndex.getJarIndex(JarIndex.java:99)
    at sun.misc.URLClassPath$JarLoader$1.run(URLClassPath.java:606)
    at java.security.AccessController.doPrivileged(Native Method)
    at sun.misc.URLClassPath$JarLoader.ensureOpen(URLClassPath.java:597)
    at sun.misc.URLClassPath$JarLoader.<init>(URLClassPath.java:581)
    at sun.misc.URLClassPath$3.run(URLClassPath.java:331)
    at java.security.AccessController.doPrivileged(Native Method)
    at sun.misc.URLClassPath.getLoader(URLClassPath.java:320)
    at sun.misc.URLClassPath.getLoader(URLClassPath.java:297)
    at sun.misc.URLClassPath.getResource(URLClassPath.java:167)
    at java.net.URLClassLoader$1.run(URLClassLoader.java:192)
    at java.security.AccessController.doPrivileged(Native Method)
    at java.net.URLClassLoader.findClass(URLClassLoader.java:188)
    at sun.misc.Launcher$ExtClassLoader.findClass(Launcher.java:244)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:319)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:309)
    at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:330)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:254)
    at java.lang.ClassLoader.loadClassInternal(ClassLoader.java:399)
    at java.lang.Class.forName0(Native Method)
    at java.lang.Class.forName(Class.java:247)
    at java.lang.SystemClassLoaderAction.run(ClassLoader.java:2147)
    at java.security.AccessController.doPrivileged(Native Method)
    at java.lang.ClassLoader.initSystemClassLoader(ClassLoader.java:1404)
    at java.lang.ClassLoader.getSystemClassLoader(ClassLoader.java:1374)
Intentionally suppressing recursive invocation exception!
java.lang.IllegalStateException: recursive invocation
    at java.lang.ClassLoader.initSystemClassLoader(ClassLoader.java:1391)
    at java.lang.ClassLoader.getSystemClassLoader(ClassLoader.java:1374)
    at sun.security.jca.ProviderConfig$3.run(ProviderConfig.java:231)
    at java.security.AccessController.doPrivileged(Native Method)
    at sun.security.jca.ProviderConfig.doLoadProvider(ProviderConfig.java:225)
    at sun.security.jca.ProviderConfig.getProvider(ProviderConfig.java:205)
    at sun.security.jca.ProviderList.getProvider(ProviderList.java:215)
    at sun.security.jca.ProviderList.getService(ProviderList.java:313)
    at sun.security.jca.GetInstance.getInstance(GetInstance.java:140)
    at java.security.cert.CertificateFactory.getInstance(CertificateFactory.java:148)
    at sun.security.pkcs.PKCS7.parseSignedData(PKCS7.java:244)
    at sun.security.pkcs.PKCS7.parse(PKCS7.java:141)
    at sun.security.pkcs.PKCS7.parse(PKCS7.java:110)
    at sun.security.pkcs.PKCS7.<init>(PKCS7.java:92)
    at sun.security.util.SignatureFileVerifier.<init>(SignatureFileVerifier.java:80)
    at java.util.jar.JarVerifier.processEntry(JarVerifier.java:256)
    at java.util.jar.JarVerifier.update(JarVerifier.java:188)
    at java.util.jar.JarFile.initializeVerifier(JarFile.java:321)
    at java.util.jar.JarFile.getInputStream(JarFile.java:386)
    at sun.misc.JarIndex.getJarIndex(JarIndex.java:99)
    at sun.misc.URLClassPath$JarLoader$1.run(URLClassPath.java:606)
    at java.security.AccessController.doPrivileged(Native Method)
    at sun.misc.URLClassPath$JarLoader.ensureOpen(URLClassPath.java:597)
    at sun.misc.URLClassPath$JarLoader.<init>(URLClassPath.java:581)
    at sun.misc.URLClassPath$3.run(URLClassPath.java:331)
    at java.security.AccessController.doPrivileged(Native Method)
    at sun.misc.URLClassPath.getLoader(URLClassPath.java:320)
    at sun.misc.URLClassPath.getLoader(URLClassPath.java:297)
    at sun.misc.URLClassPath.getResource(URLClassPath.java:167)
    at java.net.URLClassLoader$1.run(URLClassLoader.java:192)
    at java.security.AccessController.doPrivileged(Native Method)
    at java.net.URLClassLoader.findClass(URLClassLoader.java:188)
    at sun.misc.Launcher$ExtClassLoader.findClass(Launcher.java:244)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:319)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:309)
    at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:330)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:254)
    at java.lang.ClassLoader.loadClassInternal(ClassLoader.java:399)
    at java.lang.Class.forName0(Native Method)
    at java.lang.Class.forName(Class.java:247)
    at java.lang.SystemClassLoaderAction.run(ClassLoader.java:2147)
    at java.security.AccessController.doPrivileged(Native Method)
    at java.lang.ClassLoader.initSystemClassLoader(ClassLoader.java:1404)
    at java.lang.ClassLoader.getSystemClassLoader(ClassLoader.java:1374)
Loading Class 'com.journaldev.classloader.ClassLoaderTest'
Loading Class using CCLoader
Loading Class 'java.lang.Object'
Loading Class 'java.lang.String'
Loading Class 'java.lang.System'
Loading Class 'java.lang.StringBuilder'
Loading Class 'java.util.HashMap'
Loading Class 'java.lang.Class'
Loading Class 'java.io.PrintStream'
class loader for HashMap: null
Loading Class 'sun.net.spi.nameservice.dns.DNSNameService'
class loader for DNSNameService: sun.misc.Launcher$ExtClassLoader@24480457
class loader for this class: CCLoader@38503429
Loading Class 'com.mysql.jdbc.Blob'
sun.misc.Launcher$AppClassLoader@2f94ca6c
Pankaj$
```
这就是Java类加载器和java自定义类加载器的例子。

[原文](https://www.journaldev.com/349/java-classloader)