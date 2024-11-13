# JVM运维与调试工具

本章就JVM常用的运维与调试工具做一些简单的梳理。

一、JDK自带工具
=========

本地环境安装过完整JDK包之后，会在`$JAVA_HOME/bin`目录下发现很多工具，包括编译命令`javac`、执行命令`java`等。本节我们梳理一下其中用于JVM运维的工具。

> 本节描述的JDK自带工具以OpenJDK11为准。

1.1 jps
-------

jps是JVM进程查找工具，类似于linux的`ps`命令。我们使用这个命令主要是为了找到当前正在运行的JVM及其进程ID。

jps使用示例：

```
zhaochun@zhaochun-T480:bin$ jps
30816 Main
5842 Jps
484 Launcher
22137 TestCase01GCTest
32573 EchoBackService
```

jps支持的参数选项：

| 选项 | 作用 |
| --- |  --- |
| -q | 只输出JVM进程ID |
| --- |  --- |
| -m | 输出启动JVM时，传给启动类main函数的参数 |
| -l | 输出启动类完整包名，如果是jar包，则输出jar路径 |
| -v | 输出JVM启动时传入的JVM参数 |

示例，启动如下这样一个JVM

```
# JVM参数：-Xms20M -Xmx20M -Xmn10M -XX:+UseG1GC -XX:MaxGCPauseMillis=200
# main函数：czhao.study.jvm.TestCase01GCTest
# main函数参数：testParam
/usr/java/jdk-11.0.7+10/bin/java -Xms20M -Xmx20M -Xmn10M -XX:+UseG1GC -XX:MaxGCPauseMillis=200 czhao.study.jvm.TestCase01GCTest testParam

# over
```

各种选项输出如下：

```
# 只输出JVM进程ID
zhaochun@zhaochun-T480:bin$ jps -q
30816
484
10517
11116
32573

# 输出main函数参数
zhaochun@zhaochun-T480:bin$ jps -m | grep TestCase01GCTest
10517 TestCase01GCTest testParam

# 输出启动类完整包名
zhaochun@zhaochun-T480:bin$ jps -l | grep TestCase01GCTest
10517 czhao.study.jvm.TestCase01GCTest

# 输出JVM启动时传入参数
zhaochun@zhaochun-T480:bin$ jps -v | grep TestCase01GCTest
10517 TestCase01GCTest -Xms20M -Xmx20M -Xmn10M -XX:+UseG1GC -XX:MaxGCPauseMillis=200
```

1.2 jstat
---------

jstat是用于监视JVM各种运行时的状态信息的命令行工具，包括类加载、内存、垃圾收集、即时编译等运行时数据。

jstat使用示例：

```
# 先使用jps查找目标JVM的进程ID
zhaochun@zhaochun-T480:bin$ jps | grep TestCase01GCTest
10517 TestCase01GCTest

# 使用jstat查看目标进程 10517 的垃圾收集状况，每500ms查看一次，共查看 10 次
# 如果不加后面两个参数，则表示只查看一次
# -gc 表示查看的是垃圾收集状况
zhaochun@zhaochun-T480:bin$ jstat -gc 10517 500 10
 S0C    S1C    S0U    S1U      EC       EU        OC         OU       MC     MU    CCSC   CCSU   YGC     YGCT    FGC    FGCT     GCT
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001
 0.0   1024.0  0.0   1024.0  5120.0    0.0     14336.0    13816.0   4864.0 3446.8 512.0  305.8       1    0.001   0      0.000    0.001

```

上述`-gc`表示查看垃圾收集状况，其中各列的含义如下(内存空间单位:KB，时间单位:秒)：

-   S0C ：幸存者0区容量
-   S1C ：幸存者1区容量
-   S0U ：幸存者0区已使用大小
-   S1U ：幸存者1区已使用大小
-   EC ：eden区容量
-   EU ：eden区已使用大小
-   OC ：老年代容量
-   OU ：老年代已使用大小
-   MC ：元数据空间容量
-   MU ：元数据空间已使用大小
-   CCSC ：压缩类空间容量
-   CCSU ：压缩类空间已使用大小
-   YGC ：年轻代GC次数
-   YGCT ：年轻代GC耗时合计
-   FGC ：整堆GC次数
-   FGCT ：整堆GC耗时合计
-   GCT ：所有GC耗时合计

其中，`CCS`是压缩类空间，用于对象指针与类指针压缩，属于MetaSpace元数据空间的一部分，通过`-XX:+UseCompressedClassPointers`和`-XX:+UseCompressedOops`开启，默认开启。

`-gc`是参数选项，可以替换为以下其他选项：

| 选项 | 作用 |
| --- |  --- |
| -gc | 监视JVM的堆状况，包括eden区、两个幸存者区、老年代的容量、已用空间、以及GC时间合计等等 |
| --- |  --- |
| -gccapacity | 与`-gc`基本相同，但关注点在于JVM堆中各个区的历史最大、最小使用空间 |
| -gcutil | 与`-gc`基本相同，但关注点在于已使用空间占总空间的百分比 |
| -gccause | 与`-gcutil`基本相同，但会额外输出最近一次GC原因 |
| -gcnew | 监视新生代GC状况 |
| -gcnewcapacity | 与`-gcnew`基本相同，但关注点在于历史最大最小已使用空间 |
| -gcold | 监视老年代GC状况 |
| -gcoldcapacity | 与`-gcold`基本相同，但关注点在于历史最大最小已使用空间 |
| -gcmetacapacity | 监视元数据空间，重点关注历史最大最小已使用空间 |
| -class | 监视类加载、卸载数量、总空间及类装载耗费时间 |
| -compiler | 输出即时编译器编译过的方法、耗时等 |
| -printcompilation | 输出已经被即时编译的方法 |

1.3 jinfo
---------

jinfo用于查看JVM参数信息，并可以实时调整少量可以在运行时改变的参数。

使用jinfo时要注意两点：

-   执行`jinfo`命令的用户与目标JVM的启动用户应该是同一个用户，避免权限不足。
-   `jinfo`命令版本与目标JVM的`java`命令版本一致，应该是同一个JDK目录下的命令。

查看目标JVM的完整JVM参数信息如下所示：

```
# 因为之前启动的JVM使用的是 /usr/java/jdk-11.0.7+10/bin/java ，所以这里需要使用对应相同目录下的 jinfo
zhaochun@zhaochun-T480:bin$ pwd
/usr/java/jdk-11.0.7+10/bin

zhaochun@zhaochun-T480:bin$ ./jinfo 10517
Java System Properties:
#Mon Feb 08 11:49:06 CST 2021
sun.desktop=gnome
awt.toolkit=sun.awt.X11.XToolkit
java.specification.version=11
sun.cpu.isalist=
sun.jnu.encoding=UTF-8
java.class.path=.\:/usr/java/jdk1.8.0_131/lib\:/usr/java/jdk1.8.0_131/jre/lib
java.vm.vendor=AdoptOpenJDK
sun.arch.data.model=64
java.vendor.url=https\://adoptopenjdk.net/
user.timezone=Asia/Shanghai
java.vm.specification.version=11
os.name=Linux
sun.java.launcher=SUN_STANDARD
user.country=CN
sun.boot.library.path=/usr/java/jdk-11.0.7+10/lib
sun.java.command=czhao.study.jvm.TestCase01GCTest testParam
jdk.debug=release
sun.cpu.endian=little
user.home=/home/zhaochun
user.language=zh
java.specification.vendor=Oracle Corporation
java.version.date=2020-04-14
java.home=/usr/java/jdk-11.0.7+10
file.separator=/
java.vm.compressedOopsMode=32-bit
line.separator=\n
java.vm.specification.vendor=Oracle Corporation
java.specification.name=Java Platform API Specification
java.awt.graphicsenv=sun.awt.X11GraphicsEnvironment
sun.management.compiler=HotSpot 64-Bit Tiered Compilers
java.runtime.version=11.0.7+10
user.name=zhaochun
path.separator=\:
os.version=4.15.0-20-generic
java.runtime.name=OpenJDK Runtime Environment
file.encoding=UTF-8
java.vm.name=OpenJDK 64-Bit Server VM
java.vendor.version=AdoptOpenJDK
java.vendor.url.bug=https\://github.com/AdoptOpenJDK/openjdk-support/issues
java.io.tmpdir=/tmp
java.version=11.0.7
user.dir=/home/work/sources/test/study-jvm/out/production/study-jvm
os.arch=amd64
java.vm.specification.name=Java Virtual Machine Specification
java.awt.printerjob=sun.print.PSPrinterJob
sun.os.patch.level=unknown
java.library.path=/usr/java/packages/lib\:/usr/lib64\:/lib64\:/lib\:/usr/lib
java.vendor=AdoptOpenJDK
java.vm.info=mixed mode
java.vm.version=11.0.7+10
sun.io.unicode.encoding=UnicodeLittle
java.class.version=55.0

VM Flags:
-XX:CICompilerCount=4 -XX:ConcGCThreads=2 -XX:G1ConcRefinementThreads=8 -XX:G1HeapRegionSize=1048576 -XX:GCDrainStackTargetSize=64 -XX:InitialHeapSize=20971520 -XX:MarkStackSize=4194304 -XX:MaxGCPauseMillis=200 -XX:MaxHeapSize=20971520 -XX:MaxNewSize=10485760 -XX:MinHeapDeltaBytes=1048576 -XX:NewSize=10485760 -XX:NonNMethodCodeHeapSize=5836300 -XX:NonProfiledCodeHeapSize=122910970 -XX:ProfiledCodeHeapSize=122910970 -XX:ReservedCodeCacheSize=251658240 -XX:+SegmentedCodeCache -XX:+UseCompressedClassPointers -XX:+UseCompressedOops -XX:+UseFastUnorderedTimeStamps -XX:+UseG1GC

VM Arguments:
jvm_args: -Xms20M -Xmx20M -Xmn10M -XX:+UseG1GC -XX:MaxGCPauseMillis=200
java_command: czhao.study.jvm.TestCase01GCTest testParam
java_class_path (initial): .:/usr/java/jdk1.8.0_131/lib:/usr/java/jdk1.8.0_131/jre/lib
Launcher Type: SUN_STANDARD
```

jinfo的输出内容有三部分，分别是：

-   `Java System Properties`：JVM运行时的环境变量
-   `VM Flags`：生效的虚拟机参数配置
-   `VM Arguments`：启动JVM时传入的参数、命令、及当时的对应会话的环境变量

这里要尤其注意的是，如果系统环境上不止一个JDK，比如这里的例子，实际有两个JDK，一个Java8一个Java11，那么运行JVM时使用的JDK版本应该看`Java System Properties`里的`java.runtime.version`，而不是`VM Arguments`里的`java_class_path (initial)`。

可以使用`jinfo -sysprops <pid>`只查看JVM运行时的环境变量。

可以使用`jinfo -flags <pid>`只查看生效的虚拟机参数配置，比如`jinfo -flags 10517`。

可以使用`jinfo -flag <name> <pid>`查看指定参数的值，比如`jinfo -flag MaxHeapSize 10517`。

可以使用`jinfo -flag [+|-]<name> <pid>`实时开启或关闭某个可以在运行时改变的参数，比如`jinfo -flag +HeapDumpOnOutOfMemoryError 10517`。

可以使用`jinfo -flag <name>=<value>`实时修改某个可以在运行时改变的参数的值，比如`jinfo -flag MaxHeapFreeRatio=75 10517`。

> 通过命令`java -XX:+PrintFlagsFinal <pid> | grep manageable`查看哪些参数可以在运行时改变。

1.4 jmap
--------

jmap是java内存映像工具，主要用于查询当前堆和方法区的详细信息，生成堆的快照文件等。一般都是使用`-XX:+HeapDumpOnOutOfMemoryError`参数指定JVM在内存溢出异常时自动生成堆的快照文件。之后在服务器发生内存溢出异常时，将对应的快照文件拉取到本地使用工具分析。

> jmap的堆转储快照文件有很多工具可以分析，常用的有MAT，Jprofiler，IBM HeapAnalyzer等，后续章节会一一介绍。

同jinfo一样，jmap在使用时，也要注意用户和JDK版本是否与目标JVM一致。

可以使用`jmap -histo[:live] <pid>`分析当前对中对象，例如`./jmap -histo:live 10517`。

可以使用`jmap -dump:[live,]format=b,file=<file> <pid>`对目标JVM进行快照转储，例如:

```
# 只转储存活对象
./jmap -dump:live,format=b,file=/home/work/sources/test/study-jvm/output/jmap/dump001 10517

# 转储所有对象
./jmap -dump:format=b,file=/home/work/sources/test/study-jvm/output/jmap/dump002 10517
```

1.5 jhat
--------

jhat是一个原始简陋的用来分析jmap的堆转储快照文件的工具，Java9之后已经被移出JDK的工具包。这里了解一下即可。

我们用Java8的jhat工具对刚才jmap转储的快照文件进行分析：

```
zhaochun@zhaochun-T480:jmap$ jhat dump001
Reading from dump001...
Dump file created Mon Feb 08 12:37:58 CST 2021
Snapshot read, resolving...
Resolving 28806 objects...
Chasing references, expect 5 dots.....
Eliminating duplicate references.....
Snapshot resolved.
Started HTTP server on port 7000
Server is ready.

```

然后访问`http://localhost:7000/`就可以看到这个简陋的分析页面。

1.6 jstack
----------

jstack用于生成虚拟机当前时刻的线程快照。生成线程快照主要是为了定位长时间停顿的线程，比如线程间死锁、死循环、请求外部资源超时等等。通过jstack可以查看到各个线程的调用堆栈信息，就可以知道线程目前运行在哪一句代码，在做什么事情或者等待什么资源。

同样的，jstack使用时，也要注意用户、版本是否与目标JVM一致。

使用示例：

```
zhaochun@zhaochun-T480:bin$ jstack 3031
2021-02-08 15:11:01
Full thread dump OpenJDK 64-Bit Server VM (11.0.7+10 mixed mode):

Threads class SMR info:
_java_thread_list=0x00007fd8500b8430, length=12, elements={
0x00007fd8d0016000, 0x00007fd8d026b800, 0x00007fd8d026f800, 0x00007fd8d0284800,
0x00007fd8d0286800, 0x00007fd8d0288800, 0x00007fd8d028a800, 0x00007fd8d030f000,
0x00007fd8d0320800, 0x00007fd878001000, 0x00007fd86417b800, 0x00007fd850042800
}

"main" #1 prio=5 os_prio=0 cpu=135.52ms elapsed=2030.68s tid=0x00007fd8d0016000 nid=0xbd8 runnable  [0x00007fd8d987a000]
   java.lang.Thread.State: RUNNABLE
    at java.io.FileInputStream.readBytes(java.base@11.0.7/Native Method)
    at java.io.FileInputStream.read(java.base@11.0.7/FileInputStream.java:279)
    at java.io.BufferedInputStream.read1(java.base@11.0.7/BufferedInputStream.java:290)
    at java.io.BufferedInputStream.read(java.base@11.0.7/BufferedInputStream.java:351)
    - locked <0x000000062ac01148> (a java.io.BufferedInputStream)
    at sun.nio.cs.StreamDecoder.readBytes(java.base@11.0.7/StreamDecoder.java:284)
    at sun.nio.cs.StreamDecoder.implRead(java.base@11.0.7/StreamDecoder.java:326)
    at sun.nio.cs.StreamDecoder.read(java.base@11.0.7/StreamDecoder.java:178)
    - locked <0x000000062ac01a78> (a java.io.InputStreamReader)
    at java.io.InputStreamReader.read(java.base@11.0.7/InputStreamReader.java:185)
    at java.io.Reader.read(java.base@11.0.7/Reader.java:189)
    at java.util.Scanner.readInput(java.base@11.0.7/Scanner.java:882)
    at java.util.Scanner.findWithinHorizon(java.base@11.0.7/Scanner.java:1796)
    at java.util.Scanner.nextLine(java.base@11.0.7/Scanner.java:1649)
    at czhao.study.jvm.TestCase01GCTest.main(TestCase01GCTest.java:15)

"Reference Handler" #2 daemon prio=10 os_prio=0 cpu=0.72ms elapsed=2030.63s tid=0x00007fd8d026b800 nid=0xbe0 waiting on condition  [0x00007fd8a065e000]
   java.lang.Thread.State: RUNNABLE
    at java.lang.ref.Reference.waitForReferencePendingList(java.base@11.0.7/Native Method)
    at java.lang.ref.Reference.processPendingReferences(java.base@11.0.7/Reference.java:241)
    at java.lang.ref.Reference$ReferenceHandler.run(java.base@11.0.7/Reference.java:213)

"Finalizer" #3 daemon prio=8 os_prio=0 cpu=0.37ms elapsed=2030.63s tid=0x00007fd8d026f800 nid=0xbe1 in Object.wait()  [0x00007fd8a055d000]
   java.lang.Thread.State: WAITING (on object monitor)
    at java.lang.Object.wait(java.base@11.0.7/Native Method)
    - waiting on <0x000000062ac03180> (a java.lang.ref.ReferenceQueue$Lock)
    at java.lang.ref.ReferenceQueue.remove(java.base@11.0.7/ReferenceQueue.java:155)
    - waiting to re-lock in wait() <0x000000062ac03180> (a java.lang.ref.ReferenceQueue$Lock)
    at java.lang.ref.ReferenceQueue.remove(java.base@11.0.7/ReferenceQueue.java:176)
    at java.lang.ref.Finalizer$FinalizerThread.run(java.base@11.0.7/Finalizer.java:170)

"Signal Dispatcher" #4 daemon prio=9 os_prio=0 cpu=0.55ms elapsed=2030.63s tid=0x00007fd8d0284800 nid=0xbe2 runnable  [0x0000000000000000]
   java.lang.Thread.State: RUNNABLE

"C2 CompilerThread0" #5 daemon prio=9 os_prio=0 cpu=5100.91ms elapsed=2030.63s tid=0x00007fd8d0286800 nid=0xbe3 waiting on condition  [0x0000000000000000]
   java.lang.Thread.State: RUNNABLE
   No compile task

"C1 CompilerThread0" #8 daemon prio=9 os_prio=0 cpu=1492.77ms elapsed=2030.63s tid=0x00007fd8d0288800 nid=0xbe4 waiting on condition  [0x0000000000000000]
   java.lang.Thread.State: RUNNABLE
   No compile task

"Sweeper thread" #9 daemon prio=9 os_prio=0 cpu=26.09ms elapsed=2030.63s tid=0x00007fd8d028a800 nid=0xbe5 runnable  [0x0000000000000000]
   java.lang.Thread.State: RUNNABLE

"Service Thread" #10 daemon prio=9 os_prio=0 cpu=12.23ms elapsed=2030.60s tid=0x00007fd8d030f000 nid=0xbe6 runnable  [0x0000000000000000]
   java.lang.Thread.State: RUNNABLE

"Common-Cleaner" #11 daemon prio=8 os_prio=0 cpu=3.01ms elapsed=2030.60s tid=0x00007fd8d0320800 nid=0xbe8 in Object.wait()  [0x00007fd893167000]
   java.lang.Thread.State: TIMED_WAITING (on object monitor)
    at java.lang.Object.wait(java.base@11.0.7/Native Method)
    - waiting on <0x000000062ac047a8> (a java.lang.ref.ReferenceQueue$Lock)
    at java.lang.ref.ReferenceQueue.remove(java.base@11.0.7/ReferenceQueue.java:155)
    - waiting to re-lock in wait() <0x000000062ac047a8> (a java.lang.ref.ReferenceQueue$Lock)
    at jdk.internal.ref.CleanerImpl.run(java.base@11.0.7/CleanerImpl.java:148)
    at java.lang.Thread.run(java.base@11.0.7/Thread.java:834)
    at jdk.internal.misc.InnocuousThread.run(java.base@11.0.7/InnocuousThread.java:134)

"Attach Listener" #12 daemon prio=9 os_prio=0 cpu=276.95ms elapsed=2027.53s tid=0x00007fd878001000 nid=0xc0a waiting on condition  [0x0000000000000000]
   java.lang.Thread.State: RUNNABLE

"RMI TCP Accept-0" #14 daemon prio=9 os_prio=0 cpu=3.55ms elapsed=2026.03s tid=0x00007fd86417b800 nid=0xc16 runnable  [0x00007fd89202d000]
   java.lang.Thread.State: RUNNABLE
    at java.net.PlainSocketImpl.socketAccept(java.base@11.0.7/Native Method)
    at java.net.AbstractPlainSocketImpl.accept(java.base@11.0.7/AbstractPlainSocketImpl.java:458)
    at java.net.ServerSocket.implAccept(java.base@11.0.7/ServerSocket.java:565)
    at java.net.ServerSocket.accept(java.base@11.0.7/ServerSocket.java:533)
    at sun.management.jmxremote.LocalRMIServerSocketFactory$1.accept(jdk.management.agent@11.0.7/LocalRMIServerSocketFactory.java:52)
    at sun.rmi.transport.tcp.TCPTransport$AcceptLoop.executeAcceptLoop(java.rmi@11.0.7/TCPTransport.java:394)
    at sun.rmi.transport.tcp.TCPTransport$AcceptLoop.run(java.rmi@11.0.7/TCPTransport.java:366)
    at java.lang.Thread.run(java.base@11.0.7/Thread.java:834)

"RMI Scheduler(0)" #16 daemon prio=9 os_prio=0 cpu=4.74ms elapsed=2025.98s tid=0x00007fd850042800 nid=0xc19 waiting on condition  [0x00007fd891e2b000]
   java.lang.Thread.State: WAITING (parking)
    at jdk.internal.misc.Unsafe.park(java.base@11.0.7/Native Method)
    - parking to wait for  <0x000000062ac02540> (a java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject)
    at java.util.concurrent.locks.LockSupport.park(java.base@11.0.7/LockSupport.java:194)
    at java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.await(java.base@11.0.7/AbstractQueuedSynchronizer.java:2081)
    at java.util.concurrent.ScheduledThreadPoolExecutor$DelayedWorkQueue.take(java.base@11.0.7/ScheduledThreadPoolExecutor.java:1170)
    at java.util.concurrent.ScheduledThreadPoolExecutor$DelayedWorkQueue.take(java.base@11.0.7/ScheduledThreadPoolExecutor.java:899)
    at java.util.concurrent.ThreadPoolExecutor.getTask(java.base@11.0.7/ThreadPoolExecutor.java:1054)
    at java.util.concurrent.ThreadPoolExecutor.runWorker(java.base@11.0.7/ThreadPoolExecutor.java:1114)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run(java.base@11.0.7/ThreadPoolExecutor.java:628)
    at java.lang.Thread.run(java.base@11.0.7/Thread.java:834)

"VM Thread" os_prio=0 cpu=194.73ms elapsed=2030.64s tid=0x00007fd8d0263000 nid=0xbde runnable

"GC Thread#0" os_prio=0 cpu=98.26ms elapsed=2030.68s tid=0x00007fd8d0040800 nid=0xbd9 runnable

"GC Thread#1" os_prio=0 cpu=7.07ms elapsed=847.66s tid=0x00007fd888001000 nid=0x466f runnable

"GC Thread#2" os_prio=0 cpu=7.05ms elapsed=847.66s tid=0x00007fd888002000 nid=0x4670 runnable

"GC Thread#3" os_prio=0 cpu=7.40ms elapsed=847.66s tid=0x00007fd888003800 nid=0x4671 runnable

"GC Thread#4" os_prio=0 cpu=2.72ms elapsed=847.66s tid=0x00007fd888005000 nid=0x4672 runnable

"GC Thread#5" os_prio=0 cpu=5.62ms elapsed=847.66s tid=0x00007fd888006800 nid=0x4673 runnable

"GC Thread#6" os_prio=0 cpu=7.15ms elapsed=847.66s tid=0x00007fd888008000 nid=0x4674 runnable

"GC Thread#7" os_prio=0 cpu=1.41ms elapsed=847.66s tid=0x00007fd88800a000 nid=0x4675 runnable

"G1 Main Marker" os_prio=0 cpu=1.09ms elapsed=2030.67s tid=0x00007fd8d007a800 nid=0xbda runnable

"G1 Conc#0" os_prio=0 cpu=0.19ms elapsed=2030.67s tid=0x00007fd8d007c800 nid=0xbdb runnable

"G1 Refine#0" os_prio=0 cpu=0.91ms elapsed=2030.67s tid=0x00007fd8d01fe000 nid=0xbdc runnable

"G1 Young RemSet Sampling" os_prio=0 cpu=367.00ms elapsed=2030.67s tid=0x00007fd8d01ff800 nid=0xbdd runnable
"VM Periodic Task Thread" os_prio=0 cpu=1578.99ms elapsed=2030.60s tid=0x00007fd8d0311800 nid=0xbe7 waiting on condition

JNI global refs: 38, weak refs: 0

```

jstack支持的可选参数：

-   `-F` ：强制输出线程堆栈
-   `-l` ：额外输出锁的附加信息
-   `-m` ：如果调用了本地方法，输出C/C++堆栈

1.7 jcmd
--------

jcmd提供了上述命令行工具的统一使用方式，如下表所示：

> 与jcmd具有类似功能的还有`jhsdb`，也一起列在下面的表中。`jhsdb`还提供了图形化功能，在下一节介绍。

| 命令 | jcmd命令 | jhsdb命令 |
| --- |  --- |  --- |
| jps -lm | jcmd | - |
| --- |  --- |  --- |
| jmap -dump <pid> | jcmd <pid> GC.heap_dump | jhsdb jmap --binaryheap --pid <pid> |
| jmap -histo <pid> | jcmd <pid> GC.class_histogram | jhsdb jmap --histo --pid <pid> |
| jstack <pid> | jcmd <pid> Thread.print | jhsdb jstack --locks --pid <pid> |
| jinfo -sysprops <pid> | jcmd <pid> VM.system_properties | jhsdb info --sysprops --pid <pid> |
| jinfo -flags <pid> | jcmd <pid> VM.flags | jhsdb jinfo --flags --pid <pid> |

同样的，jcmd使用时，也要注意用户、版本是否与目标JVM一致。

1.7 jhsdb
---------

jhsdb除了命令以外，还提供了图形化功能来监视分析JVM状况。

jhsdb使用如下命令开启目标JVM的图形化分析界面：

```
jhsdb hsdb --pid <pid>
```

同样的，jhsdb使用时，也要注意用户、版本是否与目标JVM一致。

打开后首先有一个线程窗口，展现当前的线程信息。

另外tools菜单下有很多功能按钮，比如`Class Browser`可以查看所有类信息，`Heap Parameters`可以输出当前堆内存分区使用情况就像下面这样：

```
G1 Heap:
   regions  = 20
   capacity = 20971520 (20.0MB)
   used     = 15204416 (14.50006103515625MB)
   free     = 5767104 (5.49993896484375MB)
   72.50030517578125% used
G1 Young Generation:
Eden Space:
   regions  = 0
   capacity = 5242880 (5.0MB)
   used     = 0 (0.0MB)
   free     = 5242880 (5.0MB)
   0.0% used
Survivor Space:
   regions  = 1
   capacity = 1048576 (1.0MB)
   used     = 1048576 (1.0MB)
   free     = 0 (0.0MB)
   100.0% used
G1 Old Generation:
   regions  = 14
   capacity = 14680064 (14.0MB)
   used     = 14155840 (13.50006103515625MB)
   free     = 524224 (0.49993896484375MB)
   96.42900739397321% used
```

还有很多其他功能，大家可以慢慢尝试。

1.8 jconsole
------------

jconsole是一款对JVM的可视化监视管理工具，通过它我们可以实时地监视JVM的内存、线程、类加载等信息的变化趋势。

使用下面的命令启动:

```
jconsole
```

同样的，jconsole使用时，也要注意用户、版本是否与目标JVM一致。

jconsole启动后有一个选择JVM进程的界面，选择一个JVM后即可看到界面。

如果要连接一个远程机器上的JVM，那么需要在目标机器的JVM上增加以下参数：

```
-Dcom.sun.management.jmxremote
-Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.port=<port>
-Djava.rmi.server.hostname=<ip>
```

> 如果想要使用密码认证和ssl保证通信安全，请自行搜索。

二、Java9后需要单独下载的JDK工具
====================

Java9之后，部分JVM工具被移出了JDK工具包，需要单独去安装。这里介绍两个比较好用的工具。

2.1 visualVM
------------

visualVM是一个类似jconsole，但是比jconsole的功能更强大丰富的JVM监视工具，还可以用来分析jmap的堆转储快照文件。它也可以连接远程JVM，方法与jconsole的远程JVM一样。

visualVM的下载地址是：

```
https://visualvm.github.io/download.html
```

下载后启动:

```
./visualvm --jdkhome /usr/java/jdk-11.0.7+10
```

同样的，visualVM使用时，也要注意用户、JDK版本是否与目标JVM一致。

visualVM监视信息比jconsole更丰富，而且它还可以直接导入jmap的堆转储快照文件，并按照你需要的维度做一些简单的排序展示。

2.2 JMC
-------

JMC，`Java Mission Control`，是另一个很强大的JVM监视工具，和visualVM、jconsole一样，它可以监视JVM的各种数据。除此以外，它还提供了强大的`飞行记录器`功能，记录一段时间内JVM的各种信息，包括内存、代码、线程、IO、事件等等的记录，然后基于这些信息做性能分析。分析结果如下图所示：

![image](/img/bVcODB3 "image")

JMC下载地址如下：

```
https://www.oracle.com/java/technologies/javase/products-jmc7-downloads.html
```

本地启动命令：

```
./jmc
```

页面启动后，左侧会显示本地JVM，如果要连接远程JVM，可以在`文件 --> 连接`菜单中创建新连接。远程JVM的参数配置与jconsole一样。

直接点击左侧菜单的目标JVM即可打开实时监视页面，双击左侧菜单该JVM下层的`飞行记录器`即可开始一次飞行记录，结束后会自动给出分析报告。

`Flight Recorder`飞行记录，简称`JFR`，以前是商业JDK的特性，后来在JDK11中开源，通常可以通过JVM启动参数`-XX:StartFlightRecording`开启，或者通过`jcmd`相关命令录制。这里通过JMC工具可以可视化录制飞行记录。

JFR是一种用于收集关于正在运行的 Java 应用程序的诊断和分析数据的工具。它集成到 Java 虚拟机(JVM)中，几乎不会造成性能开销，因此即使在负载非常大的生产环境中也可以使用它。它收集JVM的各种事件信息，包括：磁盘 IO、GC、线程 sleep、线程 wait、Socket read/write 等。JFR就如同飞机上的黑匣子，通过收集的这些事件的详细信息能够更加深入了解程序的内部运行过程，这是很多其他工具所不具备的。

除了实时JVM监视和飞行记录分析以外，JMC也可以直接打开并分析jmap的堆转储快照文件，分析结果如下：

![image](/img/bVcODCm "image")

三、其他工具
======

3.1 MAT
-------

MAT，全称`Memory Analyzer Tool`，它是一个傻瓜式的堆转储快照文件分析工具，既可以自己生成堆转储快照文件，也可以直接分析jmap命令导出的快照文件。

MAT工具可以提供以下分析：

-   Histogram：列出内存中的对象，对象的个数以及大小
-   Dominator Tree：列出最大的对象以及其依赖存活的Object
-   Top Consumers ： 通过图形列出最大的object
-   duplicate classes ：检测由多个类装载器加载的类
-   Leak Suspects ：内存泄漏分析
-   Top Components：列出大于总堆数的百分之1的报表
-   Component Report：分析属于同一个包或者被同一个类加载器加载的对象状况

其中最常用的就是`Leak Suspects`内存泄漏分析。

MAT需要单独下载安装，下载地址：

```
https://www.eclipse.org/mat/downloads.php
```

> MAT是eclipse系的工具，类似与Jprofiler之于IDEA，但它是免费的，不像Jprofiler还收费。。。

下载到本地解压后直接运行`MemoryAnalyzer`即可。

使用也很简单，首页点击`Open heap dump`，然后选择对应的堆转储快照文件即可。

我们一般是在JVM启动参数添加`-XX:+HeapDumpOnOutOfMemoryError`让JVM在发生内存溢出异常时自动dump堆快照文件，所以分析时最重要的就是找出数量和空间消耗最大的对象信息，并通过调用堆栈信息查找可能发生内存泄露的代码所在。

而通过MAT的`Leak Suspects`功能，就能直接给出一个内存泄露分析报告，如下所示：

![image](/img/bVcODCn "image")

同时报告还会指出最可能发生泄露的具体对象及其调用堆栈信息：

![image](/img/bVcODCr "image")

更多相关信息请查看官方文档:

[](https://link.segmentfault.com/?enc=z2xX7UXesWKTyseZbpA3%2Fw%3D%3D.TV%2BaDaebBfoM7mdtCoH28%2Bw69M%2BMyqEzBxKTMZAC2HJeSn8LXLKf31JbWtM6sCGQ)[http://wiki.eclipse.org/Memor...](https://link.segmentfault.com/?enc=ty8aYO%2BGMoVFSaGSMALbZQ%3D%3D.TnYfElbIPk9f%2B67F1QRPE7sLdvGbgu0sH6eSuXo8PGyWLE0kEvogKvoF6CrczBZl)

3.2 IBM HeapAnalyzer
--------------------

MAT在分析内存泄露时，虽然能快速定位发生内存溢出异常时占用空间最多的对象，但这些对象往往是很底层的对象，我们要通过堆栈调用去找到真正代码中产生泄露的地方。而MAT貌似没有直观展现调用关系树的功能，这时我们可以使用`IBM HeapAnalyzer`这个工具。

`IBM HeapAnalyzer`的下载和使用参考下面的地址：

```
https://www.ibm.com/support/pages/node/1109955?mhsrc=ibmsearch_a&mhq=heapanalyzer
```

它与MAT一样，也可以自动做内存泄露分析，比MAT更好的地方是，它对堆栈调用做了可视化的转换，可以更直观地看到调用关系树。

`IBM HeapAnalyzer`最大的问题是，它已经很久没有更新维护了。。。

3.3 Jprofiler
-------------

JProfiler 是由 ej-technologies 公司开发的一款性能瓶颈分析工具。它是一款优秀的商业软件，功能非常丰富，因此具备一些免费软件所不具备的功能。Jprofiler 提供的主要功能有内存视图、CPU 视图、线程视图、堆遍历器(Heap Walker)等。

它与MAT，IBM HeapAnalyzer一样，可以用于分析堆转储快照文件。但由于收费，这里就不介绍了。

3.3 Arthas
----------

前面所有的JVM工具，都是基于JVM自己提供的MBeans/JMX技术，或者JFR技术去监视JVM状态。要么是监视JVM运行时数据，要么是OOM之后的堆转储快照文件的离线分析。

如果我们要找到一个JVM运行时的性能瓶颈所在，我们需要监视运行时内存、线程、CPU等资源的变化，并找到对应时间段的对象或线程来定位具体比较消耗资源的代码。这种方式实际操作起来还是很麻烦的。

而Arthas就是一个在实时监视跟踪具体方法方面特别强大的一种JVM在线调试工具。Arthas提供了在线的方法级别的监视跟踪功能。比如monitor/watch/trace等指令，通过字节码增强技术，直接在代码字节码层面做插桩，实现对运行时方法调用链、耗时、返回数据等信息的动态实时监视。

Arthas的安装与使用可以直接参考官方文档，上手很简单：

```
https://arthas.aliyun.com/doc/index.html
https://arthas.aliyun.com/doc/quick-start.html
https://arthas.aliyun.com/doc/advanced-use.html
```

除了JMC的JFR飞行记录，其他JVM工具所能监视的信息，基本上Arthas也都具备对应功能。而除了这些JVM信息查看、运行时状况监视。以及方法的实时监视跟踪之外，Arthas还有在线编译与反编译的功能，对于某些场景下的临时验证，或确认部署版本是否正确等特殊需求而言，十分方便。

但arthas在使用时，会对JVM的字节码造成入侵，会占用部分资源，对系统整体性能有一定的影响。所以相比于其他工具，arthas其实是一个开发人员的调试工具，而不是JVM运维工具。

四、JVM工具总结
=========

JVM运维与调试工具当然并不是仅仅只有本章节所列举的这些，但一般而言，这些工具掌握部分也就满足平时的需要了。这里对它们进行一个简单的总结。

-   当你只是简单地查看JVM运行时的状况时，你可以直接使用JDK自带的那些工具命令，比如`jps`、`jinfo`等等。
-   当你需要在OOM时查看内存泄露原因时，可以直接在JVM参数中配置OOM自动dump堆转储快照文件，并配合`jmap`等工具手动或定时周期性地dump堆快照。
-   当你想实时监视JVM的内存、线程、CPU等资源消耗趋势时，你可以使用`jconsole`、`visualVM`、`JMC`等工具。
-   当你想全面监视JVM各种事件信息，包括磁盘 IO、GC、线程 sleep、线程 wait、Socket read/write 等等，且不想对JVM性能带去影响时，你可以通过JMC录制JFR飞行记录，并在JMC中查看报告。
-   当你需要在方法层面上监视跟踪其调用链路，耗时及返回值时，你可以使用arthas这样的在线JVM调试工具。

个人认为作为保底手段，无论是JVM运维还是开发调试，JDK自带的那些工具比如`jps`、`jinfo`、`jstat`、`jstack`等，我们都应该要学习如何使用。

对于偏向于JVM运维的可视化监视方面，推荐使用JMC，并尝试录制JFR飞行记录。对于专业的JVM运维，以及编写各种性能分析报告来说，这个工具很有用。

而对于开发人员来说，目前最推荐的工具是`arthas`，基本上JVM调试需要的功能它都有。

[jvm工具](https://segmentfault.com/a/1190000038952613?utm_source=sf-similar-article)
[jstack详情](https://blog.csdn.net/q13554515812/article/details/89712423)
[jmap详情](https://www.cnblogs.com/sxdcgaq8080/p/11089664.html)
[jprofiler](https://blog.csdn.net/axin1240101543/article/details/105142141/)
[JVM Heap Dump的生成和MAT的使用](https://www.javatang.com/archives/2017/10/30/53562102.html)