title: JVM，JRE和JDK
tags: JVM,JRE, JDK,javv虚拟面,java运行时环境,java开发工具包
categories: 
  - java

thumbnail: /gallery/java-se-platform.jpg
---
不要只从编程语言的角度来看Java，这只会看到“冰山一角”
<!-- more -->

这可以用Java SE Technologies中的图来印证： 
    
![Java SE platform](/gallery/java-se-platform.jpg "Java SE platform")

如果你安装JDK，就会安装这全部的东西，而Java Language只是最左上角一小部份。 

## 什么是JVM？

在上图中，Platforms表示Solaris、Linux、Windows各种作业系统平台，在这些平台上架构了Java虚拟机，也就是JVM，JVM让Java可以跨平台，但是跨平台是怎么一回事？在这之前，你得先了解不能跨平台是怎么一回事。 

对于电脑而言，只认识一种语言，也就是0、1序列组成的机器指令。 当你使用C/C++等高阶语言编写程序时，其实这些语言，是比较贴近人类可阅读的文法，也就是比较接近英语文法的语言。 这是为了方便人类阅读及编写，电脑其实看不懂C/C++这类语言，为了将C/C++翻译为0、1序列组成的机器指令，你必须有个翻译员，担任翻译员工作的就是编译器（Compiler）。 

问题在于，每个平台认识的0、1序列并不一样。 某个指令在Windows上也许是0101，在Linux下也许是1010，因此必须使用不同的编译器为不同平台编译出可执行的机器码，在Windows平台上编译好的程序，不能直接拿到Linux等其它平台执行，也就是说，你的应用程序无法达到「编译一次，到处执行」的跨平台目的。 

Java是个高级语言，要让电脑执行你编写的程序，也得通过编译器的翻译。 不过Java在编译时，并不直接编译为相依于某平台的0、1序列，而是翻译为中介格式的字节码（Byte code）。 

Java源码扩展名为*.java ，经过编译器翻译后为扩展名*.class的字节码。 如果想要执行字节码文件，目标平台必须安装JVM（Java Virtual Machine）。 JVM会将字节码翻译为相应平台的机器码。 

不同的平台必须安装专属该平台的JVM。 这就好比你讲中文（*.java），Java编译器帮你翻译为英语（*.class），之后这份英语文件，到各国家之后，再由当地看得懂英文的人（JVM）翻译为当地语言（机器码）。 

所以 **JVM担任的职责之一就是当地翻译员，将字节码文档翻译为当前平台看得懂的0、1序列，有了JVM，你的Java程序就可以达到「编译一次，到处到处执行」的跨平台目的**。 除了了解JVM具有让Java程序跨平台的重要任务之外，编写Java程序时，对JVM的重要认知就是： 

对Java程序而言，只认识一种作业系统，这个系统叫JVM，字节码文件（扩展名为.class的文件）就是JVM的可执行文件。 

Java程序理想上，并不用理会真正执行于哪个平台，只要知道如何执行于JVM就可以了，至于JVM实际上如何与底层平台作沟通，则是JVM自己的事！ 由于JVM实际上就相当于Java程序的作业系统，JVM就负责了Java程序的各种资源管理。 

## JRE

之后会学到的第一个Java程序，其中会有这么一段程序码： 

System.out.println("Hello World");

先前曾经谈过，Java是个标准，System、out、println这些名称，都是标准中所规范的名称，实际上必须要有人根据标准编写出System.java，编译为System.class，如此你才能在编写第一个Java程序时，使用System类别（Class）上out物件（Object）的println()方法（Method）。 

谁来实现System.java？ 谁来编译为.class？ 可能是Oracle、IBM、Apache，无论如何，这些厂商必须根据相关的JSR标准文件，将标准程序库实现出来，如此你编写的第一个Java程序，在Oracle、IBM、Apache等厂商实现的JVM上运行时，引用如System这些标准API，你的第一个Java程序，才可能轻易地运行在不同的平台。 

在上图中右边可以看到Java SE API ，涵盖了各式常用的程序库，像是通用的群集（Collection）、输入输出、连接数据库的JDBC、编写窗口程序的AWT与Swing等，这些都是在各个JSR标准文件规范之中， 

**Java Runtime Environment就是Java执行环境，简称JRE， 包括了Java SE API与JVM**。只要你使用Java SE API中的程序库，在安装有JRE的电脑上就可以直接运行，无需额外在你的程序中再包装标准程序库，而可以由JRE直接提供。 

## JDK

先前说过，你要在.java中编写Java程序语言，使用编译器编译为.class文档，那么像编译器这样的工具程序是由谁提供？ 答案就是JDK，全名为Java Developer Killer ！ 呃！ 不对！ 是Java Development Kit ！


正如上图所示，JDK包括了javac、appletviewer、javadoc等工具程序，对于要开发Java程序的人，必须安装的是JDK，如此才有这些工具程序可以使用，JDK本身包括了JRE，如此你才能执行Java程序，所以总结就是 **JDK包括了Java程序语言、工具程序与JRE，JRE则包括了部署技术、Java SE API与JVM** 。


编写Java程序的人才需要JDK，如果你的程序只是想让朋友执行呢？ 那他只要装JRE就可以了，不用安装JDK，因为他不需要javac这些工具程序，但他需要Java SE API与JVM。


=======
---
title: JVM，JRE和JDK
tags: JVM,JRE, JDK,javv虚拟面,java运行时环境,java开发工具包
categories: 
  - java

thumbnail: /gallery/java-se-platform.jpg
---
不要只从编程语言的角度来看Java，这只会看到“冰山一角”
<!-- more -->

这可以用Java SE Technologies中的图来印证： 
    
![Java SE platform](/gallery/java-se-platform.jpg "Java SE platform")

如果你安装JDK，就会安装这全部的东西，而Java Language只是最左上角一小部份。 

## 什么是JVM？

在上图中，Platforms表示Solaris、Linux、Windows各种作业系统平台，在这些平台上架构了Java虚拟机，也就是JVM，JVM让Java可以跨平台，但是跨平台是怎么一回事？在这之前，你得先了解不能跨平台是怎么一回事。 

对于电脑而言，只认识一种语言，也就是0、1序列组成的机器指令。 当你使用C/C++等高阶语言编写程序时，其实这些语言，是比较贴近人类可阅读的文法，也就是比较接近英语文法的语言。 这是为了方便人类阅读及编写，电脑其实看不懂C/C++这类语言，为了将C/C++翻译为0、1序列组成的机器指令，你必须有个翻译员，担任翻译员工作的就是编译器（Compiler）。 

问题在于，每个平台认识的0、1序列并不一样。 某个指令在Windows上也许是0101，在Linux下也许是1010，因此必须使用不同的编译器为不同平台编译出可执行的机器码，在Windows平台上编译好的程序，不能直接拿到Linux等其它平台执行，也就是说，你的应用程序无法达到「编译一次，到处执行」的跨平台目的。 

Java是个高级语言，要让电脑执行你编写的程序，也得通过编译器的翻译。 不过Java在编译时，并不直接编译为相依于某平台的0、1序列，而是翻译为中介格式的字节码（Byte code）。 

Java源码扩展名为*.java ，经过编译器翻译后为扩展名*.class的字节码。 如果想要执行字节码文件，目标平台必须安装JVM（Java Virtual Machine）。 JVM会将字节码翻译为相应平台的机器码。 

不同的平台必须安装专属该平台的JVM。 这就好比你讲中文（*.java），Java编译器帮你翻译为英语（*.class），之后这份英语文件，到各国家之后，再由当地看得懂英文的人（JVM）翻译为当地语言（机器码）。 

所以 **JVM担任的职责之一就是当地翻译员，将字节码文档翻译为当前平台看得懂的0、1序列，有了JVM，你的Java程序就可以达到「编译一次，到处到处执行」的跨平台目的**。 除了了解JVM具有让Java程序跨平台的重要任务之外，编写Java程序时，对JVM的重要认知就是： 

对Java程序而言，只认识一种作业系统，这个系统叫JVM，字节码文件（扩展名为.class的文件）就是JVM的可执行文件。 

Java程序理想上，并不用理会真正执行于哪个平台，只要知道如何执行于JVM就可以了，至于JVM实际上如何与底层平台作沟通，则是JVM自己的事！ 由于JVM实际上就相当于Java程序的作业系统，JVM就负责了Java程序的各种资源管理。 

## JRE

之后会学到的第一个Java程序，其中会有这么一段程序码： 

System.out.println("Hello World");

先前曾经谈过，Java是个标准，System、out、println这些名称，都是标准中所规范的名称，实际上必须要有人根据标准编写出System.java，编译为System.class，如此你才能在编写第一个Java程序时，使用System类别（Class）上out物件（Object）的println()方法（Method）。 

谁来实现System.java？ 谁来编译为.class？ 可能是Oracle、IBM、Apache，无论如何，这些厂商必须根据相关的JSR标准文件，将标准程序库实现出来，如此你编写的第一个Java程序，在Oracle、IBM、Apache等厂商实现的JVM上运行时，引用如System这些标准API，你的第一个Java程序，才可能轻易地运行在不同的平台。 

在上图中右边可以看到Java SE API ，涵盖了各式常用的程序库，像是通用的群集（Collection）、输入输出、连接数据库的JDBC、编写窗口程序的AWT与Swing等，这些都是在各个JSR标准文件规范之中， 

**Java Runtime Environment就是Java执行环境，简称JRE， 包括了Java SE API与JVM**。只要你使用Java SE API中的程序库，在安装有JRE的电脑上就可以直接运行，无需额外在你的程序中再包装标准程序库，而可以由JRE直接提供。 

## JDK

先前说过，你要在.java中编写Java程序语言，使用编译器编译为.class文档，那么像编译器这样的工具程序是由谁提供？ 答案就是JDK，全名为Java Developer Killer ！ 呃！ 不对！ 是Java Development Kit ！


正如上图所示，JDK包括了javac、appletviewer、javadoc等工具程序，对于要开发Java程序的人，必须安装的是JDK，如此才有这些工具程序可以使用，JDK本身包括了JRE，如此你才能执行Java程序，所以总结就是 **JDK包括了Java程序语言、工具程序与JRE，JRE则包括了部署技术、Java SE API与JVM** 。


编写Java程序的人才需要JDK，如果你的程序只是想让朋友执行呢？ 那他只要装JRE就可以了，不用安装JDK，因为他不需要javac这些工具程序，但他需要Java SE API与JVM。



对初学者来说，JDK确实很不友善，这大概是Java阵营的哲学，假设你懂得如何准备相关开发环境，因此装好JDK之后，该自己设定的变数或选项就要自己设定，JDK不会代劳，过去戏称JDK全名为Java Developer Killer其实是其来于这。