---
title: Java异常面试问题
tags: java,exception,interview,异常,面试
categories: 
  - java

thumbnail: /gallery/blue-water4.jpg
---
Java提供了一种强大的、面向对象的途径，用于处理异常的场景，它即被称为**Java异常处理**。
<!-- more -->
以前我写过一篇关于Java异常处理的文章，今天我列出了一些重要的Java异常问题和答案，以帮助你顺利通过面试。

1. Java中的异常是什么？
2. Java中的异常处理关键字是什么？
3. 解释Java异常层次结构？
4. 什么是Java异常类的重要方法？
5. 说明Java 7 ARM功能和多catch块？
6. Java中的Checked和Unchecked Exception之间有什么区别？
7. 在Java中throw和throws关键字有什么区别？
8. Java中编写自定义异常？
9. 什么是Java中的OutOfMemoryError？
10. 导致“主线程中的异常”的不同情况是什么？
11. 在Java中final，finally和finalize有什么区别？
12. 当main方法抛出异常时会发生什么？
13. 我们可以有一个空的catch块吗？
14. 提供一些Java异常处理最佳实践？
15. 下面的程序有什么问题，我们如何解决？

 
## 1. Java中的异常是什么？

异常是在执行程序期间可能发生的错误事件，并中断它的正常流程。异常情况可能由用户输入的错误数据，硬件故障，网络连接故障等不同情况引起。

每当执行Java语句时发生任何错误，都会创建一个异常对象，然后**JRE**尝试查找异常处理程序来处理异常。如果找到合适的异常处理程序，则将异常对象传递给处理程序代码以处理异常，即**捕获异常**。如果没有找到处理程序，则应用程序将该异常抛出到运行时环境，JRE终止程序。

**Java异常处理**框架仅用于处理运行时错误，编译时错误不由异常处理框架处理。

## 2. Java中的异常处理关键字是什么？

在java异常处理中使用了四个关键字。

1. `throw` ：有时我们明确地想要创建异常对象，然后抛出它来停止程序的正常处理。使用throw关键字来抛出异常来处理它。
2. `throws` ：当我们在方法中抛出任何检查的异常而不处理它时，我们需要在方法签名中使用throws关键字来让调用者程序知道可能由方法抛出的异常。调用者方法可能会处理这些异常或使用throws关键字将其传播给它的调用方法。我们可以在throws子句中提供多个异常，也可以在`main()`方法中使用。
3. `try-catch` ：我们在代码中使用try-catch块进行异常处理。try是块的开始，catch是在try块的结尾来处理异常。我们可以有一个try的多个catch块，try-catch块也可以嵌套。catch块需要一个类型为Exception的参数。
4. `finally` ：finally块是可选的，只能用于try-catch块。由于异常暂停执行的过程，我们可能会打开一些资源不会关闭，所以我们可以使用finally块。finally块总是被执行，无论是否发生异常。

## 3. 解释Java异常层次结构？

Java异常是有层次的，继承被用来区分不同类型的异常。Throwable是Java异常分层的父类，它有两个子对象 - Error和Exception 。异常进一步被分为检查异常和运行时异常。

**错误**是超出应用程序范围的特殊情况，不可能预测并从中恢复，例如硬件故障，JVM崩溃或内存不足错误。

**检查异常**是我们可以在程序中预料到的例外情况，并尝试从中恢复，例如FileNotFoundException。我们应该抓住这个异常，并为用户提供有用的信息并进行正确记录以便调试。`Exception`是所有检查异常的父类。

**运行时异常**是由不良编程引起的，例如试图从数组中检索一个元素。在尝试检索元素之前，我们应该先检查数组的长度，否则可能会在运行时抛出ArrayIndexOutOfBoundException 。`RuntimeException`是所有运行时异常的父类。

![Java异常层次结构](/gallery/exception-hierarchy.png "Java异常层次结构")

## 4. 什么是Java异常类的重要方法？

异常和所有的子类没有提供任何具体的方法，所有的方法在基类Throwable中定义。

1. `String getMessage()` - 此方法返回Throwable的消息String，通过构造函数创建异常时可以提供消息。
2. `String getLocalizedMessage()` - 提供此方法，以便子类可以覆盖它以向调用程序提供特定于语言环境的消息。此方法的可执行类实现只是使用getMessage()方法来返回异常消息。
3. `synchronized Throwable getCause()` - 此方法返回异常的原因或空id，原因未知。
4. `String toString()` - 此方法以字符串格式返回有关Throwable的信息，返回的String包含Throwable类和本地化消息的名称。
5. `void printStackTrace()` - 此方法将堆栈跟踪信息打印到标准错误流，此方法被重载，我们可以传递PrintStream或PrintWriter作为参数，以将堆栈跟踪信息写入文件或流。

## 5. 说明Java 7 ARM功能和多catch块？

如果您在单个try块中捕获了很多异常，您将注意到catch块代码看起来非常难看，主要由冗余代码组成，以记录错误，记住Java 7的一个特性是多catch块我们可以在一个catch块中捕获多个异常。具有此功能的catch块如下所示：

```java
catch(IOException | SQLException | Exception ex){
     logger.error(ex);
     throw new MyException(ex.getMessage());
}
```

大多数情况下，我们使用finally块来关闭资源，有时我们会忘记关闭它们，并在资源耗尽时获取运行时异常。这些异常很难调试，我们可能需要查看每个地方我们正在使用该类型的资源，以确保我们正在关闭它。所以Java 7的一个改进就是try-with-resources ，我们可以在try语句中创建一个资源，并在try-catch块中使用它。当try-catch块执行时，运行时环境会自动关闭这些资源。带有这种改进的try-catch块的示例是：

```java
try (MyResource mr = new MyResource()) {
            System.out.println("MyResource created in try-with-resources");
        } catch (Exception e) {
            e.printStackTrace();
        }
```
在[Java 7 ARM](https://www.journaldev.com/592/java-try-with-resources)上阅读更多信息。


## 6. Java中的Checked和Unchecked Exception之间有什么区别？

1. 应该使用try-catch块在代码中处理检查异常，否则`main()`方法应该使用throws关键字来让JRE知道可能从程序抛出的异常。未检查的异常不需要在程序中处理，或者在throws子句中提及它们。
2. `Exception`是所有检查异常的超类，而`RuntimeException`是所有未检查异常的超类。
3. 检查异常是指不是由程序引起的错误情况，例如在读取不存在的文件时的FileNotFoundException，而未检查的异常大部分是由于编程不良造成的，例如，当在对象引用上调用方法时没有确定是否为NullPointerException不为null。

## 7. 在Java中throw和throws关键字有什么区别？

throws关键字与方法签名一起使用来声明方法可能抛出的异常，而throw关键字用于中断程序流并将异常对象移交给运行时处理。


## 8. 如何在Java中编写自定义异常？

我们可以扩展`Exception`类或它的任何子类来创建我们的自定义异常类。自定义异常类可以拥有自己的变量和方法，我们可以使用这些变量和方法将错误代码或其他异常相关信息传递给异常处理程序。

自定义异常的一个简单示例如下所示。

```java
package com.lexiangmiao.exceptions;

import java.io.IOException;

public class MyException extends IOException {

	private static final long serialVersionUID = 4664456874499611218L;
	
	private String errorCode="Unknown_Exception";
	
	public MyException(String message, String errorCode){
		super(message);
		this.errorCode=errorCode;
	}
	
	public String getErrorCode(){
		return this.errorCode;
	}
	

}

```

## 9. 什么是Java中的OutOfMemoryError？

Java中的OutOfMemoryError是java.lang.VirtualMachineError的一个子类，当JVM在堆内存中运行时，它将被抛出。我们可以通过增加更多的内存，通过java选项运行java应用程序来解决这个错误。

`$>java MyProgram -Xms1024m -Xmx1024m -XX:PermSize=64M -XX:MaxPermSize=256m`


## 10. 导致“主线程中的异常”的不同情况是什么？

一些常见的主线程异常情况是：

* 主线程中的`java.lang.UnsupportedClassVersionError`异常：当您的java类从另一个JDK版本编译并且您正试图从另一个java版本运行时，会出现此异常。
* 主线程中的`java.lang.NoClassDefFoundError`异常 ：这个异常有两种变体。第一个是你提供扩展名为.class的类全名的地方。第二种情况是没有找到类时。
* 主线程中的`java.lang.NoSuchMethodError：main`异常 ：当您尝试运行一个没有main方法的类时，会发生此异常。
* 主线程中的`java.lang.ArithmeticException`异常 ：每当从main方法抛出任何异常时，它将打印出控制台的异常。第一部分说明从main方法抛出异常，第二部分打印异常类名，然后在冒号后打印异常消息。

了解更多，请阅读此文[主线程中的Java异常](https://www.journaldev.com/611/exception-in-thread-main-java)。


## 11. 在Java中final，finally和finalize有什么区别？

final，finally是在java中的关键字，而finalize是一种方法。

final关键字可以和类变量一起使用，这样它们就不能被重新分配，类可以避免通过类和方法扩展来避免被子类覆盖，finally关键字和try-catch块一起使用，以提供总是被执行的语句即使出现一些异常，通常最终也是用来关闭资源的。垃圾收集器在对象被销毁前执行finalize（）方法，这是确保所有全局资源都关闭的好方法。

在三者中，只有finally才涉及到java异常处理。

## 12. 当main方法抛出异常时会发生什么？

当`main()`方法抛出异常时，Java Runtime会终止程序并在系统控制台中打印异常消息和堆栈跟踪。

## 13. 我们可以有一个空的catch块吗？

我们可以有一个空的catch块，但这是最糟糕的编程例子。我们不应该有空的catch块，因为如果这个块被异常捕获了，我们将没有关于异常的信息，调试它将是一个噩梦。应至少有一个日志记录语句来记录控制台或日志文件中的异常详细信息。

## 14. 提供一些Java异常处理最佳实践？

一些与Java异常处理有关的最佳实践是：

* 使用特定的例外以方便调试。
* 在程序中尽早抛出异常（Fail-Fast）。
* 在程序后期捕获异常，让调用者处理异常。
* 使用Java 7 ARM功能来确保资源已关闭或使用finally块来正确关闭它们。
* 总是记录异常消息以进行调试。
* 使用多个catch块来清理关闭。
* 使用自定义异常从应用程序API中引发单一类型的异常。
* 按照命名约定，总是以Exception结束。
* 记录在javadoc中使用@throws方法抛出的异常。
* 例外是昂贵的，所以只有当它是有道理的。否则你可以抓住他们，并提供空或空的答复。

了解更多，请阅读此文[Java异常处理最佳实践](https://www.journaldev.com/1696/exception-handling-in-java#exception-best-practices)。


## 15. 下面的程序有什么问题，我们如何解决？

在本节中，我们将研究一些与java异常有关的编程问题。

### 1. 下面的程序有什么问题？

```java
package com.lexiangmiao.exceptions;

import java.io.FileNotFoundException;
import java.io.IOException;

public class TestException {

	public static void main(String[] args) {
		try {
			testExceptions();
		} catch (FileNotFoundException | IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public static void testExceptions() throws IOException, FileNotFoundException{
		
	}
}
```

上面的程序不会编译，你会得到错误信息为 “The exception FileNotFoundException is already caught by the alternative IOException”。这是因为FileNotFoundException是IOException的子类，有两种方法可以解决这个问题。

第一种方法是对于这两个例外都使用单个catch块。
```java
		try {
			testExceptions();
		}catch(FileNotFoundException e){
			e.printStackTrace();
		}catch (IOException  e) {
			e.printStackTrace();
		}
```

另一种方法是从multi-catch块中删除FileNotFoundException。
```java
		try {
			testExceptions();
		}catch (IOException  e) {
			e.printStackTrace();
		}
```

你可以根据你的catch代码选择这些方法。

### 2. 下面的程序有什么问题？

```java
package com.lexiangmiao.exceptions;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.xml.bind.JAXBException;

public class TestException1 {

	public static void main(String[] args) {
			try {
				go();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (JAXBException e) {
				e.printStackTrace();
			}
	}

	public static void go() throws IOException, JAXBException, FileNotFoundException{
		
	}
}
```

程序不会编译，因为FileNotFoundException是IOException的子类，因此FileNotFoundException的catch块无法访问，您将得到错误消息为“Unreachable catch block for FileNotFoundException. It is already handled by the catch block for IOException”

你需要修正catch块的顺序来解决这个问题。
```java
			try {
				go();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (JAXBException e) {
				e.printStackTrace();
			}
```

请注意，**JAXBException与IOException或FileNotFoundException无关，可以放在上面的catch块层次结构中的任何地方**。

### 3. 下面的程序有什么问题？

```java
package com.lexiangmiao.exceptions;

import java.io.IOException;

import javax.xml.bind.JAXBException;

public class TestException2 {

	public static void main(String[] args) {
		try {
			foo();
		} catch (IOException e) {
			e.printStackTrace();
		}catch(JAXBException e){
			e.printStackTrace();
		}catch(NullPointerException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public static void foo() throws IOException{
		
	}
}
```

程序不会编译，因为JAXBException是一个检查的异常，foo（）方法应该抛出这个异常来捕获调用方法。您将收到错误消息为“Unreachable catch block for JAXBException. This exception is never thrown from the try statement body”。

要解决这个问题，你必须删除JAXBException的catch块。

注意捕获NullPointerException是有效的，因为它是一个未经检查的异常。

### 4. 下面的程序有什么问题？
```java
package com.lexiangmiao.exceptions;

public class TestException3 {

	public static void main(String[] args) {
		try{
		bar();
		}catch(NullPointerException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		foo();
	}

	public static void bar(){
		
	}
	
	public static void foo() throws NullPointerException{
		
	}
}
```
这是一个技巧性的问题，代码没有问题，它会成功编译。即使它不在方法的throws子句中，我们也总是可以捕获Exception或任何未经检查的异常。

同样，如果一个方法（foo）在throws子句中声明了未检查的异常，那么在程序中处理这个异常并不是强制性的。

### 5. 下面的程序有什么问题？
```java
package com.lexiangmiao.exceptions;

import java.io.IOException;

public class TestException4 {

	public void start() throws IOException{		
	}
	
	public void foo() throws NullPointerException{
		
	}
}

class TestException5 extends TestException4{
	
	public void start() throws Exception{
	}
	
	public void foo() throws RuntimeException{
		
	}
}
```
 
上面的程序不会编译，因为start()方法签名在子类中不一样。为了解决这个问题，我们可以将子类中的方法singnature改为与superclass完全相同，或者我们可以从子类方法中删除throws子句，如下所示。
```java
	@Override
	public void start(){
	}
```

### 6. 下面的程序有什么问题？
```java
package com.lexiangmiao.exceptions;

import java.io.IOException;

import javax.xml.bind.JAXBException;

public class TestException6 {

	public static void main(String[] args) {
		try {
			foo();
		} catch (IOException | JAXBException e) {
			e = new Exception("");
			e.printStackTrace();
		}catch(Exception e){
			e = new Exception("");
			e.printStackTrace();
		}
	}

	public static void foo() throws IOException, JAXBException{
		
	}
}
```
上面的程序不会编译，因为multi-catch块中的异常对象是final的，我们不能改变它的值。编译时错误是“多个catch块的参数e不能被赋值”。

我们必须删除“e”赋值给新的异常对象来解决这个错误。

阅读更多请阅读[Java 7多捕获块](https://www.journaldev.com/629/java-catch-multiple-exceptions-rethrow-exception)。

[原文](https://www.journaldev.com/2167/java-exception-interview-questions-and-answers)