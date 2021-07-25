---
title: Java堆VS栈-Java中的内存分配
tags: heap space, stack memory, memory allocation，堆空间,堆栈,栈内存,内存分配
categories: 
  - java

thumbnail: /gallery/green-water3.jpg
---
前些时候，在我写了一些关于{% post_link java-jvm-memory-model-memory-management Java垃圾回收 %}和Java是按价值传递的文章之后，收到了很多电子邮件说解释一下Java堆空间 ， Java栈内存，Java内存分配以及它们之间的区别。
<!-- more -->
在Java EE书籍和java教程中都能看到很多关于堆和栈的描述，从程序运行时的角度如何理解堆内存和栈到底是什么呢？

本文目录
1. Java堆空间
2. Java堆栈内存
3. Java程序中堆和栈内存的分配
4. Java堆空间和栈内存的区别

## Java堆空间

Java运行时使用Java堆空间将内存分配给对象和JRE类。 每当我们创建任何对象，它总是在堆空间中创建。

垃圾回收器在堆内存上运行以释放没有任何引用的对象所使用的内存。 在堆空间中创建的任何对象都具有全局访问权限，并且可以从应用程序的任何位置引用。

## Java堆栈内存 

Java堆栈内存用于执行线程。 它们包含特定于方法的值，这些值是短暂的，并引用堆中从该方法引用的其他对象。

堆栈内存始终以LIFO（后进先出）顺序引用。 无论何时调用方法，都会在堆栈内存中为方法创建一个新的块，以保存本地原始值并引用该方法中的其他对象。

一旦方法结束，该块将变为未使用状态，并可用于下一个方法。与堆内存相比，堆栈内存的大小非常小。


## Java程序中堆和栈内存的分配

让我们用一个简单的程序来理解堆和堆栈的内存使用情况。

```java
package com.journaldev.test;

public class Memory {

	public static void main(String[] args) { // Line 1
		int i=1; // Line 2
		Object obj = new Object(); // Line 3
		Memory mem = new Memory(); // Line 4
		mem.foo(obj); // Line 5
	} // Line 9

	private void foo(Object param) { // Line 6
		String str = param.toString(); //// Line 7
		System.out.println(str);
	} // Line 8

}
```
下面的图片显示了参考上述程序的堆栈和堆内存以及它们如何被用来存储原类型值，对象和引用变量。

![Java堆和栈内存的分配](/gallery/Java-Heap-Stack-Memory.png "Java堆和栈内存的分配")

让我们来看看执行程序的步骤。

* 一旦我们运行该程序，它将所有运行时类加载到堆空间中。 当在第1行找到main（）方法时，Java运行时将创建堆栈内存以供main（）方法线程使用。
* 我们在第2行创建了原始局部变量，所以它被创建并存储在main（）方法的堆栈内存中。
* 由于我们在第3行创建了一个对象，因此它在堆内存中创建，并且堆栈内存包含它的引用。 当我们在第4行创建Memory对象时会发生类似的过程。
* 现在当我们在第5行中调用foo（）方法时，堆栈顶部的一个块被创建，以供foo（）方法使用。由于Java是按值传递的，因此在第6行的foo（）堆栈块中创建了对Object的新引用。
* 在第7行中创建一个字符串，它将进入堆空间中的字符串池 ，并在foo（）堆栈空间中为其创建引用。
* foo（）方法在第8行终止，此时为堆栈中的foo（）分配的内存块变为空闲。
* 在第9行中，main（）方法终止，为main（）方法创建的堆栈内存被销毁。 程序也结束在这一行，因此Java运行时释放所有内存并结束程序的执行。

## Java堆空间和栈内存的区别

基于上面的解释，我们可以很容易地得出堆和堆内存之间的差异。

1. 堆内存由应用程序的所有部分使用，而堆栈内存仅由一个执行线程使用。
2. 每当创建一个对象时，它总是存储在堆空间中，并且堆栈存储器包含对它的引用。 堆栈内存只包含局部基本变量和引用变量到堆空间中的对象。
3. 存储在堆中的对象是全局可访问的，而堆栈存储器不能被其他线程访问。
4. 堆栈中的内存管理以LIFO方式完成，而堆内存中的内存管理更为复杂，因为它是全局使用的。 在Java垃圾收集中 ，堆内存分为年轻一代，旧一代等。
5. 堆栈内存是短暂的，而堆内存从开始到应用程序执行结束。
6. 我们可以使用-Xms和-Xmx JVM选项来定义堆内存的启动大小和最大大小。 我们可以使用-Xss来定义堆栈的内存大小。
7. 当堆栈内存已满时，Java运行时会抛出java.lang.StackOverFlowError而如果堆内存已满，则会抛出java.lang.OutOfMemoryError: Java Heap Space错误。
8. 与堆内存相比，堆栈内存的大小非常小。由于内存分配（LIFO）简单，与堆内存相比，堆栈内存非常快。

这是所有的堆空间和堆栈内存在java应用程序中的对比，希望能消除你关于Java程序执行时内存分配的疑虑。

## 引用
1. [原文](https://www.journaldev.com/4098/java-heap-space-vs-stack-memory)