title: java核心技术面试问题
tags: java,core,interview,核心技术,编程,面试
categories: 
  - java

thumbnail: /gallery/blue-water4.jpg
---
是否是一位新手或者具有丰富经验专业的程序员，java核心技术在任何java/JEE面试中都扮演重要的角色。
<!-- more -->
## java核心技术面试问题列表

在许多面试中，java核心技术是喜欢考察的知识点，并且在决定你的面试结果中扮演关键的角色。这篇文章关于java核心技术的问题，它直接来自于我10多年java编程和许多面试经历。

我已经写过许多java面试问题的具体文章，如字符串String，集合Collections和多线程Multithreading等主题。

这里我先给出一些重要的java核心技术面试问题，让你重新加快下你所知道的知识点。

1. java 8发布了什么重要特性？
2. 你对java的平台独立性的理解是什么？
3. JVM是什么？JVM是平台独立的吗？
4. JDK和JVM的区别是什么？
5. JVM和JRE的区别是什么？
6. 所有类的的超类是哪个类？
7. 为什么java不支持多继承？
8. 为什么java不是纯面向对象的语言？
9. path和classpath变量的区别是什么？
10. java中main方法的重要性是什么？
11. java中的重载overloading和覆载overriding是什么？
12. 能重载main方法吗？
13. 在一个java源文件中能有多个公共类吗？
14. java包是什么？那个包默认被引入？
15. java的访问修饰符有哪些？
16. final关键字有什么作用？
17. static关键字有什么作用？
18. java中的finally和finalize有什么作用？
19. 能声明一个类为静态static类吗？
20. 静态static引入是什么？
21. java带资源的try语句是什么，有什么作用？
22. java的多catch语句块是什么，有什么作用？
23. 静态static语句块是什么，有什么作用？
24. 接口是什么，有什么作用?
25. 抽象类是什么，有什么作用？
26. 抽象类和接口有什么区别？
27. 接口能否实现或扩展另一个接口？
28. 标记接口Marker interface是什么，有什么作用？
29. 包装类是什么？
30. java中的枚举是什么？
31. java注解是什么？
32. java反射API是什么？为什么它非常重要？
33. java中的组合是什么？
34. 组合相对与继承有什么好处？
35. java中怎样对自定义对象集合进行排序？
36. java中的内部类是什么?
37. 匿名内部类是什么？
38. java类加载器Classloader是什么？
39. 类加载器的不同类型是什么？
40. java中的三元操作符是什么？
41. super关键字做什么用的？
42. break和continue语句是什么，怎么用？
43. this关键字是什么，怎么用？
44. 默认构造器是什么？
45. try可以不带catch语句块吗？
46. 垃圾收集器Garbage Collection是什么？
47. 序列化Serialization和反序列化Deserialization是什么？
48. 通过命令提示行怎样运行JAR文件
49. System类的用途是什么？
50. instanceof关键字用途是什么？
51. switch case语句中能使用String类型吗？
52. java是通过值传递还是通过引用传递？
53. 堆Heap和栈Stack内存有什么区别？
54. java编译器是存储在JDK，JRE或JVM哪一个中？
55. 如下程序将输出什么？

## java核心技术面试问题及答案

### 1. java 8发布了什么重要特性？

java 8于2014年3月发布，因此是java面试中的热点问题。如果你清楚的回答这个问题，将展示出你对新技术的关注度。

在java 5引入注解和泛型后，java 8是最大（变化）的发布版之一。 java 8有如下重要新特性：

1. [接口可以带默认和静态方法。](https://www.journaldev.com/2752/java-8-interface-changes-static-method-default-method)
2. [函数式接口和Lambda表达式。](https://www.journaldev.com/2763/java-8-functional-interfaces)
3. [为集合引入的java Stream API。](https://www.journaldev.com/2774/java-8-stream)
4. [java 新的日期时间API。](https://www.journaldev.com/2800/java-8-date-localdate-localdatetime-instant)

强烈推荐打开链接了作深入理解，也可以看一下java 8的新特性。

### 2. 你对java的平台独立性Platform independence的理解是什么？

平台独立性意思是在任何操作系统中运行同样的java程序。例如你可以在Windows上写java程序运行在Mac OS上。

### 3. JVM是什么？JVM是平台独立的吗？

JVM是java虚拟机（Java Virtual Machine）的缩写，它是java语言的核心。JVM的责任就是转换字节码到可读的机器码。JVM不是平台独立的，也是为什么我们在不同的操作系统需要不同的JVM的原因。我们用java可选项可以自定义分配内存最小和最大值。java虚拟机之所以被叫做虚拟，是因为他提了一个不依赖于底层操作系统的接口。

阅读更多知识，请访问 {% post_link jvm-jre-jdk JVM、JRE和JDK %} 一文。

### 4. JDK和JVM的区别是什么？

JDK是java开发工具包（java Development Kit）的缩写，它是用于开发目的工具集合。JVM是执行java程序的部分。  

JDK除了包含了一批用于Java开发的组件，还包含JRE,java运行时环境，也包括了用于产品环境的各种库类，如基础类库rt.jar，以及给开发人员使用的补充库，如国际化与本地化的类库、IDL库等等。JDK中还包括各种样例程序，用以展示Java API中的各部分。

JVM是java平台的可执行的部分。JVM屏蔽了与具体操作系统平台相关的信息，使得Java程序只需生成在Java虚拟机上运行的目标代码（字节码），就可以在多种平台上不加修改地运行。由于JVM并不是专为Java所实现的运行时，实际上只要有其他编程语言的编译器能生成正确Java bytecode文件，则这个语言也能实现在JVM上运行。

### 5. JVM和JRE的区别是什么？

JRE是java运行时环境的缩写（Java Runtime Environment），它是JVM的一种实现。JRE由JVM,java二节文件和其他成功执行任何程序的其他类组成。JRE不包含任何像编译器、调试器等那样的开发工具。如果你想执行任何java程序，你应当安装JRE。

### 6. 所有类的的超类是哪个类？

`java.lang.Object`是所有类的根类，不需要扩展它。

### 7. 为什么java不支持多继承？

因是“钻石问题（菱形继承问题）” 导致java类不支持多继承。想了解更多“钻石问题”，请阅读[java中的多继承](https://www.journaldev.com/1775/multiple-inheritance-in-java)。

然后多继承在接口中是支持的。一个接口可以扩展多个接口，因为仅仅是声明方法，实现类中将实现它接口的方法。因此在接口中就没有“
钻石问题（菱形继承问题）”了。

### 8. 为什么java不是纯面向对象的语言？

说java不是纯面向对象语言，是因为它支持如int、byte、short、long等原始类型。我相信在写代码时它带来了简捷性。很显然地java有原始类型对应的包装类型表示，从所周知，包装类型除了添加了一些方法，它们没有带来任何好处。

### 9. path和classpath变量的区别是什么？

PATH是一个用在操作系统中定位可执行文件的环境变量（不仅java可执行文件，还有其他如C#,C++等可执行文件）。这就是为什么在安装java时或想任何可执行文件被找到时，我们需要配置目录路径到Path变量的原因。

Classpath是为java指定的用于java可执行文件定位class字节文件的路径变量。在运行java应用程序时将查找这个classpath路径，它可以是目录、ZIP文件、JAR文件等。

### 10. java中main方法的重要性是什么？

main()方法是任何独立的java应用程序的入口点。main的语法是：`public static void main(String args[])`.

main方法是公用且静态的，输入参数是数组，可以转入运行时参数给它。

### 11. java中的重载overloading和覆载overriding是什么？

有超过一个方法存在相同名称、不同参时，我们称它为重载。

覆载指的是父子类之间存在相同签名的方法。在子类中可以使用@Override注解覆盖父类的方法。

### 12. 能重载main方法吗？

可以，在类中可以有多个main名字的方法。然而运行时的入口仅查找这个方法`public static void main(String args[])`.

### 13. 在一个java源文件中能有多个公共类吗？

在单个java源文件中，不能超过一个公共类。但单个源文件中可以有多个非公共的类。

### 14. java包是什么？那个包默认被引入？

java包是组织java类文件的一种机制。这个组织逻辑可以基于功能或模块。一个类的完整类名应包含包及类名，例如，`java.lang.Object`是Object类的完整类名，它是java.lang包的一部分。

`java.lang`包是被默认引入的，任何类中它不需要明确引入。

### 15. java的访问修饰符有哪些？

java提供公有public, 私有private和保护protected访问修饰符。若未使用任何修饰符，则被叫做默认default访问修饰符。

java类仅有公有和默认访问修饰符。阅读更多关于[java访问修饰符](https://www.journaldev.com/2345/java-access-modifiers)的知识。

### 16. final关键字有什么作用？

final关键用于确保其他类不能扩展它。如String类就带有final，我们就不能扩展它。

方法前也可以使用final关键字用来确保子类不能覆盖它。

final关键字用在变量前确保只能分配一次值。然而变量的状态是可以改变的，例如可以分配到final变量一次，但是变量的值，在分配之后是可以改变的。

java接口的变量默认就是final且静态static的。

### 17. static关键字有什么作用？

static关键字用在类级别全局的变量，如所有对象将共享同一个变量。

static关键字也可以用在方法前。静态方法仅能访问类的静态变量和调用静态方法。

static关键字用作静态块。静态块是通过java类加载器一次性加载到内存的。常用来初始化静态变量，大多用来创建静态资源。

static关键字用作静态嵌套类。此时能访问变部静态类的静态方法或静态变量。

static关键字用作静态引入。如`import static java.lang.Math.PI;`，这样就可以直接在当前类中使用PI参数了。

### 18. java中的finally和finalize有什么作用？

finally块用作在try-catch块之后你总想执行的东西。甚至在抛出异常时也会执行。它大多用来释放在try块中创建的资源。

finalize()是Object的protected方法，子类可以覆盖该方法以实现资源清理工作，GC在回收对象之前调用该方法。

finalize()与C++中的析构函数不是对应的。C++中的析构函数调用的时机是确定的（对象离开作用域或delete掉），但java中的finalize的调用具有不确定性。

不建议用finalize方法完成“非内存资源”的清理工作，但建议用于：  
 a.清理本地对象(通过JNI创建的对象)；  
 b.作为确保某些非内存资源(如Socket、文件等)释放的一个补充：在finalize方法中显式调用其他资源释放方法。

### 19. 能声明一个类为静态static类吗？

不能声明一个类为顶级静态类，但可以声明为嵌套静态类。

### 20. 静态static引入是什么？

我们访问静态变量或方法一般是通过类访问的。但也可以通过静态引入的方式`import static java.lang.Math.PI;`使用它。

使用静态引入带来困惑，最好避免使用它，同时使用它还会使代码的可维护性和可读性变差。

### 21. java带资源的try语句是什么，有什么作用？

java 7的新特性,带资源的try语句，用于自动释放资源，相当于try-catch语句块执行了finnaly块。

### 22. java的多个catch语句块是什么，有什么作用？

如果一个try块中有多个异常要被捕获，catch块中的代码会变丑陋的同时还要用多余的代码来记录异常。有鉴于此，java 7的一个新特征是：一个catch子句中可以捕获多个异常。使用管道符(|),如'catch(IOException | SQLException | Exception ex)'捕获异常。


### 23. 静态static语句块是什么，有什么作用？

静态块是一组语句块，通过java类加载器一次性加载到内存的。常用来初始化静态变量，大多用来创建静态资源。

### 24. 接口是什么，有什么作用?

接口是java语言的核心部分，不但用在许多JDK中而且也用在许多框架、工具和java设计模式中。在java中，接口提供了一用实现方式的抽象，用来定义子类需要实现的契约。

在代码中，接口有利于定义类型起始点和创建顶层结构。自从java接口能实现多个接口后，在许多场景下，使用接口更优于超类。

### 25. 抽象类是什么，有什么作用？

抽象类为子类创建一些默认方法的实现。抽象类可以有未实现的抽象方法。

abstract关键字用来创建抽象类。抽象类不能被实例化，大多是用于子类的扩展。

### 26. 抽象类和接口有什么区别？

* abstract用于创建抽象类，而interface用来创建接口。
* 子类用extends扩展抽象类，而接口使用implements实现接口。
* 抽象类可以有实现方法，但接口没有。
* 抽象类有构造器，但接口没有。
* 抽象类的方法有public, private, protected, static修饰符，但接口的方法是隐式的public和abstract，不需要使用任何的修饰符。
* 一个类只能扩展最多一个抽象类，但接口可以扩展一个或多个接口。
* 抽象类可以扩展其他类和实现其他接口，但接口只能扩展其他接口。
* 抽象类有main入口方法，是可以运行的，但时接口不能。
* 接口常用来定义契约，但抽象定义契约的同时还可以有方法实现。

### 27. 接口能否实现或扩展另一个接口？

接口不能实现另一个接口，但可以扩展它。因为接口没有实现就没有“钻石问题”。

### 28. 标记接口Marker interface是什么，有什么作用？

标记接口是一个没有任何方法实现的空接口，用于标记实现类有某些功能。从所周知的Serializable和Cloneable就是标记接口。

### 29. 包装类是什么？

java包装类是8个原始类型对应的对象表示形式。所有的包装类都是不能被继承final和一成不变immutable的。

### 30. java中的枚举是什么？

枚举作为一个新类型，在java 1.5版本引入。它的域由一些固定的常量构成。如，在java中可以使用EAST, WEST, NORTH, SOUTH创建Direction方向的枚举。

与类相似，我们使用enum关键字用于创建一个枚举类型。枚举常量是隐式的静态不能继承的。

### 31. java注解是什么？

java注解提供关于代码的描述信息。它不直接影响代码。注解在java5中被引入。注解是关于嵌套在程序自己中的元数据。可以用过注解解析工具或编译器解析。我们常指定注释在编译时或者在运行时可用。java盎的注解有@Override, @Deprecated and @SuppressWarnings。 

### 32. java反射API是什么？为什么有它非常重要？

java反射API提供查看和修改java应用程序的运行时行为的能力。我们可以查看java类，接口，枚举和它们的方法和域的详情。反射API是一个高级主题，一般的应用中应当避免它。反射API用于反设计模式的场景，如单例模式中调用私有构造器，建返访问修饰调用。

即然一般的应用中应当避免使用反射API，但有它的话还是非常重要。因为我们不能没有如Spring，Hibernate或者Tomcat服务，JBoss之类的框架。它们通过反射API调用适当的方法和实体，使用它做了许多处理。

### 33. java中的组合（Composition）是什么？

组合是在类中实现`有has-a`关系的一种设计技术。使用对象组合是为了代码重用。

java组合通过引用其他对象的实例变量实现的。使用组合的好处是，我们能够控制其他对象的可见性，在我们需要的时候重用。

### 34. 组合相对与继承有什么好处？

java编程的最佳实践之一是“组合（Composition）优于继承（Inheritance）”。有以下原因：

* 尽管我们可以不使用超类的方法，但在超类中的任何改变也可能影响到子类。例如，假如我们在子类中有一个方法`test()`，突然某人在父类引入一个方法`test()`，那么我们在子类中出现编译错误。组合从没有这种问题，是因为我们仅在需要方法时才使用。
* 若我们在设计超类时没有掌控，继承会暴露了所有超类的方法和变量到客户端，这样也能导致安全漏洞。组合允许我们对方法提供限制的访问，因此更加安全。
* 在组合中我们可以运行时绑定，继承绑定是在编译时。因此组合的方法调用更加灵活。

你可以在[java组合vs继承](https://www.journaldev.com/1775/multiple-inheritance-in-java)一文中，阅读更多关于组合优于继承的知识。

### 35. java中怎样对自定义对象集合进行排序？

自定义对象集合支持排序需要实现比较Comparable接口。比较接口有`compareTo(T obj)`方法，它被用于排序的实现，我们可以提供默认的排序方法。

然后，如果想基于不同条件，如员工集合中基于薪资或年龄的排序。我们可以创建多个匿名类的比较器实例实现。

### 36. java中的内部类是什么?

我们把定义在类的内部的类称为嵌套类。任何非静态的嵌套类被称之为内部类。内部类与类的对象实例相关。它能访问所有变量和外部类的方法。即然内部类是与实例相关，那么它就没有任何静态变量。

在类的内部，可以有本地内部类和匿名内部类。详情请阅读[java内部类](https://www.journaldev.com/996/java-inner-class)。

### 37. 匿名内部类是什么？

一个本地不带名字的类被叫做匿名内部类。在单个语句中匿名类定义后并立即实例化。匿名内部类总是扩展自一个类或者实现一个接口。

既然匿名类没有名字，那么它也没有定义构造器。匿名内部类仅在定义的地方可以访问。

### 38. java类加载器Classloader是什么？

java类加载器是在我们想访问任何类时，加载字节码程序到内存的一种程序。我们也可以扩散ClassLoader类和覆载loadClass(String name)方法定义自己的类加载器。了解更多关于[java类加器](https://www.journaldev.com/349/java-classloader)。

### 39. 类加载器的不同类型是什么？

在java中提供以下三个内建的类加载器：

1. 引导类加载器（Bootstrap Class Loader）：它用来加载JDK内存类，典型的加载rt.jar和其他核心类。它是用原生代码来实现的，并不继承自 java.lang.ClassLoader。
2. 扩展类加载器（Extensions Class Loader）：它用来加载 JDK 的扩展库。常常加载$jAVA_HOME/lib/ext目录库。
3. 系统类加载器（System Class Loader）：它根据 java 应用的类路径（CLASSPATH）来加载 java 类。一般来说，java 应用的类都是由它来完成加载的。可以通过 ClassLoader.getSystemClassLoader()来获取它。

### 40. java中的三元操作符是什么？

java三元操作符仅是一个带三个表达式的条件操作符。可以使用if-then-else语句替换。例如`a==b?a:b`。

### 41. super关键字做什么用的？

super用作子类中访问父类构造器或父类方法。访问类构造器是须放在第一条语句且只能在构造器中访问。

### 42. break和continue语句是什么，怎么用？

放在循环语句中用来结束循环，break结束整个循环，continue结束本次循环。

### 43. this关键字是什么，怎么用？

用于访问当前对象的引用。大多被用于确保是当前对象的变量（相对于入参变量来说），也可以用来调用当前对象的其他构造器。

### 44. 默认构造器是什么？

类的无参构造器被称为默认构造器。在我们没有定义任何类构造器时，java编译器会自动创建类的默认无参构造器。如果定义了有其他构造器，则编译器不会为我们创建默认构造器。

### 45. try可以不带catch语句块吗？

可以。可以有try-finally语句块，于是就避免带catch语句块了。

### 46. 垃圾收集器Garbage Collection是什么？

垃圾收集器查看堆内存的处理器，识别哪个对象在使用中和哪个不在使用中，然后删除不使用的对象。销毁内存是通过垃圾收集器自动进行处理的。

我们可以使用代码`Runtime.getRuntime().gc()`或者使用工具方法`System.gc()`运行垃圾收集器。更多堆内存和垃圾收集器详细分析，请阅读“[垃圾收集器](https://www.journaldev.com/2856/java-jvm-memory-model-memory-management-in-java)”。

### 47. 序列化Serialization和反序列化Deserialization是什么？

我们把java对象转换成二进制流的过程被称做为序列化。一旦一个对象被转换成二进制流，它就可以侦破到文件或通过网络发送或在套接字连接中使用。

对象应当实现序列化Serializable接口，这样我们就可以使用`java.io.ObjectOutputStream`写入对象到文件或者任何输出流OutputStream对象了。阅读更多[java序列化](https://www.journaldev.com/927/objectoutputstream-java-write-object-file)知识。

把二进制流数据转换成对象的过程被称做为反序列化。阅读更多[java反序列化](https://www.journaldev.com/933/objectinputstream-java-read-object-file)知识。

### 48. 通过命令提示行怎样运行JAR文件？

能使用命令行运行jar包文件，但需要在jar清单文件中有Main入口类。含Main的类是jar包的入口点，用来通过java命令执行。

### 49. System类的用途是什么？

java System类是核心类之一，`System.out.print()`是其中一个方法。在调试时，它是最简单的记录日志信息的方法。

System类被声明为final的。因此无法被子类继承和覆盖其行为。也不提供任何公共构造器，因此也不能实例这个类。也是为什么它的所有方法是静态static的原因。

System类提供了数组拷贝、获取当前时间、读环境变化等助手类方法。阅读更多[java System类](https://www.journaldev.com/1847/java-system-java-lang-system-class)知识。

### 50. instanceof关键字的用途是什么？

instanceof关键字用来检测是否属于某个类。我们应当尽可能的避免使用它。

### 51. switch case语句中能使用字符串类型吗？

java 7引入的新特性之一，switch case语句中可以使用字符串类型。因此java 7或更高版本可以使用。

### 52. java是通过值传递还是通过引用传递？

这个问题非常具有迷惑性。我们知道对象变量在堆空间中包含引用的对象。在我们调用任何方法时，这个变量的拷贝被转递并存储在方法的栈内存中。我们能够检测到任何语言它是通过引用或通过值传递通过一个简单的交换方法，请阅读[更多](https://www.journaldev.com/3884/java-is-pass-by-value-and-not-pass-by-reference)。由此我们得出java是通过值传递而不是通过引用传递的。

### 53. 堆Heap和栈Stack内存有什么区别？

堆和栈主要的区别如下：

* 所有应用的部分都使用堆内存，然而只有执行线程使用栈内存。
* 每当对象被创建时，它总是存在堆空间中，栈内存包含它的引用。栈内存仅包括本地的原始变量，在堆空间中的对象的引用变量。
*栈内存是通后进先出LIFO的方法管理的，然而在堆内存中因为它是全局使用，所以它的管理方式更加复杂。

在同一程序中更加详细的解释，请阅读[java堆vs栈内存](https://www.journaldev.com/4098/java-heap-space-vs-stack-memory)


### 54. java编译器是存储在JDK，JRE或JVM哪一个中？

java编译器的任务是转换java程序到字节码，我们使用`javac`命令执行即可实现。因此它必须要存在JDK中。

### 55. 如下程序将输出什么？

1. 在类中的静态方法

```java
package tests;

public class Test {

    public static String toString(){
        System.out.println("Test toString called");
        return "";
    }
    
    public static void main(String args[]){
        System.out.println(toString());
    }
}
```

答：以上代码不能编译。因为所有类对继承根对象类Object。以上会编译错误提示静态方法不能覆盖实例方法。

2. 静态方法调用

```java
package tests;

public class Test {

    public static String foo(){
        System.out.println("Test foo called");
        return "";
    }
    
    public static void main(String args[]){
        Test obj = null;
        System.out.println(obj.foo());
    }
}
```

答：这是个奇怪的使用场景。NULL空对象调用方法是总会报`NullPointerException`异常，且该方法是属于类的静态方法，但该程序能工作并打印"Test foo called"。

原因是编译器做了编译优化。在java编译转换成字节码时，它指向的foo()是静态方法，而不是对象方法，因此编译从`obj.foo()`调整到`Test.foo()`，于是也没有了`NullPointerException`异常。

=======
---
title: java核心技术面试问题
tags: java,core,interview,核心技术,编程,面试
categories: 
  - java

thumbnail: /gallery/blue-water4.jpg
---
是否是一位新手或者具有丰富经验专业的程序员，java核心技术在任何java/JEE面试中都扮演重要的角色。
<!-- more -->
## java核心技术面试问题列表

在许多面试中，java核心技术是喜欢考察的知识点，并且在决定你的面试结果中扮演关键的角色。这篇文章关于java核心技术的问题，它直接来自于我10多年java编程和许多面试经历。

我已经写过许多java面试问题的具体文章，如字符串String，集合Collections和多线程Multithreading等主题。

这里我先给出一些重要的java核心技术面试问题，让你重新加快下你所知道的知识点。

1. java 8发布了什么重要特性？
2. 你对java的平台独立性的理解是什么？
3. JVM是什么？JVM是平台独立的吗？
4. JDK和JVM的区别是什么？
5. JVM和JRE的区别是什么？
6. 所有类的的超类是哪个类？
7. 为什么java不支持多继承？
8. 为什么java不是纯面向对象的语言？
9. path和classpath变量的区别是什么？
10. java中main方法的重要性是什么？
11. java中的重载overloading和覆载overriding是什么？
12. 能重载main方法吗？
13. 在一个java源文件中能有多个公共类吗？
14. java包是什么？那个包默认被引入？
15. java的访问修饰符有哪些？
16. final关键字有什么作用？
17. static关键字有什么作用？
18. java中的finally和finalize有什么作用？
19. 能声明一个类为静态static类吗？
20. 静态static引入是什么？
21. java带资源的try语句是什么，有什么作用？
22. java的多catch语句块是什么，有什么作用？
23. 静态static语句块是什么，有什么作用？
24. 接口是什么，有什么作用?
25. 抽象类是什么，有什么作用？
26. 抽象类和接口有什么区别？
27. 接口能否实现或扩展另一个接口？
28. 标记接口Marker interface是什么，有什么作用？
29. 包装类是什么？
30. java中的枚举是什么？
31. java注解是什么？
32. java反射API是什么？为什么它非常重要？
33. java中的组合是什么？
34. 组合相对与继承有什么好处？
35. java中怎样对自定义对象集合进行排序？
36. java中的内部类是什么?
37. 匿名内部类是什么？
38. java类加载器Classloader是什么？
39. 类加载器的不同类型是什么？
40. java中的三元操作符是什么？
41. super关键字做什么用的？
42. break和continue语句是什么，怎么用？
43. this关键字是什么，怎么用？
44. 默认构造器是什么？
45. try可以不带catch语句块吗？
46. 垃圾收集器Garbage Collection是什么？
47. 序列化Serialization和反序列化Deserialization是什么？
48. 通过命令提示行怎样运行JAR文件
49. System类的用途是什么？
50. instanceof关键字用途是什么？
51. switch case语句中能使用String类型吗？
52. java是通过值传递还是通过引用传递？
53. 堆Heap和栈Stack内存有什么区别？
54. java编译器是存储在JDK，JRE或JVM哪一个中？
55. 如下程序将输出什么？

## java核心技术面试问题及答案

### 1. java 8发布了什么重要特性？

java 8于2014年3月发布，因此是java面试中的热点问题。如果你清楚的回答这个问题，将展示出你对新技术的关注度。

在java 5引入注解和泛型后，java 8是最大（变化）的发布版之一。 java 8有如下重要新特性：

1. [接口可以带默认和静态方法。](https://www.journaldev.com/2752/java-8-interface-changes-static-method-default-method)
2. [函数式接口和Lambda表达式。](https://www.journaldev.com/2763/java-8-functional-interfaces)
3. [为集合引入的java Stream API。](https://www.journaldev.com/2774/java-8-stream)
4. [java 新的日期时间API。](https://www.journaldev.com/2800/java-8-date-localdate-localdatetime-instant)

强烈推荐打开链接了作深入理解，也可以看一下java 8的新特性。

### 2. 你对java的平台独立性Platform independence的理解是什么？

平台独立性意思是在任何操作系统中运行同样的java程序。例如你可以在Windows上写java程序运行在Mac OS上。

### 3. JVM是什么？JVM是平台独立的吗？

JVM是java虚拟机（Java Virtual Machine）的缩写，它是java语言的核心。JVM的责任就是转换字节码到可读的机器码。JVM不是平台独立的，也是为什么我们在不同的操作系统需要不同的JVM的原因。我们用java可选项可以自定义分配内存最小和最大值。java虚拟机之所以被叫做虚拟，是因为他提了一个不依赖于底层操作系统的接口。

阅读更多知识，请访问 {% post_link jvm-jre-jdk JVM、JRE和JDK %} 一文。

### 4. JDK和JVM的区别是什么？

JDK是java开发工具包（java Development Kit）的缩写，它是用于开发目的工具集合。JVM是执行java程序的部分。  

JDK除了包含了一批用于Java开发的组件，还包含JRE,java运行时环境，也包括了用于产品环境的各种库类，如基础类库rt.jar，以及给开发人员使用的补充库，如国际化与本地化的类库、IDL库等等。JDK中还包括各种样例程序，用以展示Java API中的各部分。

JVM是java平台的可执行的部分。JVM屏蔽了与具体操作系统平台相关的信息，使得Java程序只需生成在Java虚拟机上运行的目标代码（字节码），就可以在多种平台上不加修改地运行。由于JVM并不是专为Java所实现的运行时，实际上只要有其他编程语言的编译器能生成正确Java bytecode文件，则这个语言也能实现在JVM上运行。

### 5. JVM和JRE的区别是什么？

JRE是java运行时环境的缩写（Java Runtime Environment），它是JVM的一种实现。JRE由JVM,java二节文件和其他成功执行任何程序的其他类组成。JRE不包含任何像编译器、调试器等那样的开发工具。如果你想执行任何java程序，你应当安装JRE。

### 6. 所有类的的超类是哪个类？

`java.lang.Object`是所有类的根类，不需要扩展它。

### 7. 为什么java不支持多继承？

因是“钻石问题（菱形继承问题）” 导致java类不支持多继承。想了解更多“钻石问题”，请阅读[java中的多继承](https://www.journaldev.com/1775/multiple-inheritance-in-java)。

然后多继承在接口中是支持的。一个接口可以扩展多个接口，因为仅仅是声明方法，实现类中将实现它接口的方法。因此在接口中就没有“
钻石问题（菱形继承问题）”了。

### 8. 为什么java不是纯面向对象的语言？

说java不是纯面向对象语言，是因为它支持如int、byte、short、long等原始类型。我相信在写代码时它带来了简捷性。很显然地java有原始类型对应的包装类型表示，从所周知，包装类型除了添加了一些方法，它们没有带来任何好处。

### 9. path和classpath变量的区别是什么？

PATH是一个用在操作系统中定位可执行文件的环境变量（不仅java可执行文件，还有其他如C#,C++等可执行文件）。这就是为什么在安装java时或想任何可执行文件被找到时，我们需要配置目录路径到Path变量的原因。

Classpath是为java指定的用于java可执行文件定位class字节文件的路径变量。在运行java应用程序时将查找这个classpath路径，它可以是目录、ZIP文件、JAR文件等。

### 10. java中main方法的重要性是什么？

main()方法是任何独立的java应用程序的入口点。main的语法是：`public static void main(String args[])`.

main方法是公用且静态的，输入参数是数组，可以转入运行时参数给它。

### 11. java中的重载overloading和覆载overriding是什么？

有超过一个方法存在相同名称、不同参时，我们称它为重载。

覆载指的是父子类之间存在相同签名的方法。在子类中可以使用@Override注解覆盖父类的方法。

### 12. 能重载main方法吗？

可以，在类中可以有多个main名字的方法。然而运行时的入口仅查找这个方法`public static void main(String args[])`.

### 13. 在一个java源文件中能有多个公共类吗？

在单个java源文件中，不能超过一个公共类。但单个源文件中可以有多个非公共的类。

### 14. java包是什么？那个包默认被引入？

java包是组织java类文件的一种机制。这个组织逻辑可以基于功能或模块。一个类的完整类名应包含包及类名，例如，`java.lang.Object`是Object类的完整类名，它是java.lang包的一部分。

`java.lang`包是被默认引入的，任何类中它不需要明确引入。

### 15. java的访问修饰符有哪些？

java提供公有public, 私有private和保护protected访问修饰符。若未使用任何修饰符，则被叫做默认default访问修饰符。

java类仅有公有和默认访问修饰符。阅读更多关于[java访问修饰符](https://www.journaldev.com/2345/java-access-modifiers)的知识。

### 16. final关键字有什么作用？

final关键用于确保其他类不能扩展它。如String类就带有final，我们就不能扩展它。

方法前也可以使用final关键字用来确保子类不能覆盖它。

final关键字用在变量前确保只能分配一次值。然而变量的状态是可以改变的，例如可以分配到final变量一次，但是变量的值，在分配之后是可以改变的。

java接口的变量默认就是final且静态static的。

### 17. static关键字有什么作用？

static关键字用在类级别全局的变量，如所有对象将共享同一个变量。

static关键字也可以用在方法前。静态方法仅能访问类的静态变量和调用静态方法。

static关键字用作静态块。静态块是通过java类加载器一次性加载到内存的。常用来初始化静态变量，大多用来创建静态资源。

static关键字用作静态嵌套类。此时能访问变部静态类的静态方法或静态变量。

static关键字用作静态引入。如`import static java.lang.Math.PI;`，这样就可以直接在当前类中使用PI参数了。

### 18. java中的finally和finalize有什么作用？

finally块用作在try-catch块之后你总想执行的东西。甚至在抛出异常时也会执行。它大多用来释放在try块中创建的资源。

finalize()是Object的protected方法，子类可以覆盖该方法以实现资源清理工作，GC在回收对象之前调用该方法。

finalize()与C++中的析构函数不是对应的。C++中的析构函数调用的时机是确定的（对象离开作用域或delete掉），但java中的finalize的调用具有不确定性。

不建议用finalize方法完成“非内存资源”的清理工作，但建议用于：  
 a.清理本地对象(通过JNI创建的对象)；  
 b.作为确保某些非内存资源(如Socket、文件等)释放的一个补充：在finalize方法中显式调用其他资源释放方法。

### 19. 能声明一个类为静态static类吗？

不能声明一个类为顶级静态类，但可以声明为嵌套静态类。

### 20. 静态static引入是什么？

我们访问静态变量或方法一般是通过类访问的。但也可以通过静态引入的方式`import static java.lang.Math.PI;`使用它。

使用静态引入带来困惑，最好避免使用它，同时使用它还会使代码的可维护性和可读性变差。

### 21. java带资源的try语句是什么，有什么作用？

java 7的新特性,带资源的try语句，用于自动释放资源，相当于try-catch语句块执行了finnaly块。

### 22. java的多个catch语句块是什么，有什么作用？

如果一个try块中有多个异常要被捕获，catch块中的代码会变丑陋的同时还要用多余的代码来记录异常。有鉴于此，java 7的一个新特征是：一个catch子句中可以捕获多个异常。使用管道符(|),如'catch(IOException | SQLException | Exception ex)'捕获异常。


### 23. 静态static语句块是什么，有什么作用？

静态块是一组语句块，通过java类加载器一次性加载到内存的。常用来初始化静态变量，大多用来创建静态资源。

### 24. 接口是什么，有什么作用?

接口是java语言的核心部分，不但用在许多JDK中而且也用在许多框架、工具和java设计模式中。在java中，接口提供了一用实现方式的抽象，用来定义子类需要实现的契约。

在代码中，接口有利于定义类型起始点和创建顶层结构。自从java接口能实现多个接口后，在许多场景下，使用接口更优于超类。

### 25. 抽象类是什么，有什么作用？

抽象类为子类创建一些默认方法的实现。抽象类可以有未实现的抽象方法。

abstract关键字用来创建抽象类。抽象类不能被实例化，大多是用于子类的扩展。

### 26. 抽象类和接口有什么区别？

* abstract用于创建抽象类，而interface用来创建接口。
* 子类用extends扩展抽象类，而接口使用implements实现接口。
* 抽象类可以有实现方法，但接口没有。
* 抽象类有构造器，但接口没有。
* 抽象类的方法有public, private, protected, static修饰符，但接口的方法是隐式的public和abstract，不需要使用任何的修饰符。
* 一个类只能扩展最多一个抽象类，但接口可以扩展一个或多个接口。
* 抽象类可以扩展其他类和实现其他接口，但接口只能扩展其他接口。
* 抽象类有main入口方法，是可以运行的，但时接口不能。
* 接口常用来定义契约，但抽象定义契约的同时还可以有方法实现。

### 27. 接口能否实现或扩展另一个接口？

接口不能实现另一个接口，但可以扩展它。因为接口没有实现就没有“钻石问题”。

### 28. 标记接口Marker interface是什么，有什么作用？

标记接口是一个没有任何方法实现的空接口，用于标记实现类有某些功能。从所周知的Serializable和Cloneable就是标记接口。

### 29. 包装类是什么？

java包装类是8个原始类型对应的对象表示形式。所有的包装类都是不能被继承final和一成不变immutable的。

### 30. java中的枚举是什么？

枚举作为一个新类型，在java 1.5版本引入。它的域由一些固定的常量构成。如，在java中可以使用EAST, WEST, NORTH, SOUTH创建Direction方向的枚举。

与类相似，我们使用enum关键字用于创建一个枚举类型。枚举常量是隐式的静态不能继承的。

### 31. java注解是什么？

java注解提供关于代码的描述信息。它不直接影响代码。注解在java5中被引入。注解是关于嵌套在程序自己中的元数据。可以用过注解解析工具或编译器解析。我们常指定注释在编译时或者在运行时可用。java盎的注解有@Override, @Deprecated and @SuppressWarnings。 

### 32. java反射API是什么？为什么有它非常重要？

java反射API提供查看和修改java应用程序的运行时行为的能力。我们可以查看java类，接口，枚举和它们的方法和域的详情。反射API是一个高级主题，一般的应用中应当避免它。反射API用于反设计模式的场景，如单例模式中调用私有构造器，建返访问修饰调用。

即然一般的应用中应当避免使用反射API，但有它的话还是非常重要。因为我们不能没有如Spring，Hibernate或者Tomcat服务，JBoss之类的框架。它们通过反射API调用适当的方法和实体，使用它做了许多处理。

### 33. java中的组合（Composition）是什么？

组合是在类中实现`有has-a`关系的一种设计技术。使用对象组合是为了代码重用。

java组合通过引用其他对象的实例变量实现的。使用组合的好处是，我们能够控制其他对象的可见性，在我们需要的时候重用。

### 34. 组合相对与继承有什么好处？

java编程的最佳实践之一是“组合（Composition）优于继承（Inheritance）”。有以下原因：

* 尽管我们可以不使用超类的方法，但在超类中的任何改变也可能影响到子类。例如，假如我们在子类中有一个方法`test()`，突然某人在父类引入一个方法`test()`，那么我们在子类中出现编译错误。组合从没有这种问题，是因为我们仅在需要方法时才使用。
* 若我们在设计超类时没有掌控，继承会暴露了所有超类的方法和变量到客户端，这样也能导致安全漏洞。组合允许我们对方法提供限制的访问，因此更加安全。
* 在组合中我们可以运行时绑定，继承绑定是在编译时。因此组合的方法调用更加灵活。

你可以在[java组合vs继承](https://www.journaldev.com/1775/multiple-inheritance-in-java)一文中，阅读更多关于组合优于继承的知识。

### 35. java中怎样对自定义对象集合进行排序？

自定义对象集合支持排序需要实现比较Comparable接口。比较接口有`compareTo(T obj)`方法，它被用于排序的实现，我们可以提供默认的排序方法。

然后，如果想基于不同条件，如员工集合中基于薪资或年龄的排序。我们可以创建多个匿名类的比较器实例实现。

### 36. java中的内部类是什么?

我们把定义在类的内部的类称为嵌套类。任何非静态的嵌套类被称之为内部类。内部类与类的对象实例相关。它能访问所有变量和外部类的方法。即然内部类是与实例相关，那么它就没有任何静态变量。

在类的内部，可以有本地内部类和匿名内部类。详情请阅读[java内部类](https://www.journaldev.com/996/java-inner-class)。

### 37. 匿名内部类是什么？

一个本地不带名字的类被叫做匿名内部类。在单个语句中匿名类定义后并立即实例化。匿名内部类总是扩展自一个类或者实现一个接口。

既然匿名类没有名字，那么它也没有定义构造器。匿名内部类仅在定义的地方可以访问。

### 38. java类加载器Classloader是什么？

java类加载器是在我们想访问任何类时，加载字节码程序到内存的一种程序。我们也可以扩散ClassLoader类和覆载loadClass(String name)方法定义自己的类加载器。了解更多关于[java类加器](https://www.journaldev.com/349/java-classloader)。

### 39. 类加载器的不同类型是什么？

在java中提供以下三个内建的类加载器：

1. 引导类加载器（Bootstrap Class Loader）：它用来加载JDK内存类，典型的加载rt.jar和其他核心类。它是用原生代码来实现的，并不继承自 java.lang.ClassLoader。
2. 扩展类加载器（Extensions Class Loader）：它用来加载 JDK 的扩展库。常常加载$jAVA_HOME/lib/ext目录库。
3. 系统类加载器（System Class Loader）：它根据 java 应用的类路径（CLASSPATH）来加载 java 类。一般来说，java 应用的类都是由它来完成加载的。可以通过 ClassLoader.getSystemClassLoader()来获取它。

### 40. java中的三元操作符是什么？

java三元操作符仅是一个带三个表达式的条件操作符。可以使用if-then-else语句替换。例如`a==b?a:b`。

### 41. super关键字做什么用的？

super用作子类中访问父类构造器或父类方法。访问类构造器是须放在第一条语句且只能在构造器中访问。

### 42. break和continue语句是什么，怎么用？

放在循环语句中用来结束循环，break结束整个循环，continue结束本次循环。

### 43. this关键字是什么，怎么用？

用于访问当前对象的引用。大多被用于确保是当前对象的变量（相对于入参变量来说），也可以用来调用当前对象的其他构造器。

### 44. 默认构造器是什么？

类的无参构造器被称为默认构造器。在我们没有定义任何类构造器时，java编译器会自动创建类的默认无参构造器。如果定义了有其他构造器，则编译器不会为我们创建默认构造器。

### 45. try可以不带catch语句块吗？

可以。可以有try-finally语句块，于是就避免带catch语句块了。

### 46. 垃圾收集器Garbage Collection是什么？

垃圾收集器查看堆内存的处理器，识别哪个对象在使用中和哪个不在使用中，然后删除不使用的对象。销毁内存是通过垃圾收集器自动进行处理的。

我们可以使用代码`Runtime.getRuntime().gc()`或者使用工具方法`System.gc()`运行垃圾收集器。更多堆内存和垃圾收集器详细分析，请阅读“[垃圾收集器](https://www.journaldev.com/2856/java-jvm-memory-model-memory-management-in-java)”。

### 47. 序列化Serialization和反序列化Deserialization是什么？

我们把java对象转换成二进制流的过程被称做为序列化。一旦一个对象被转换成二进制流，它就可以侦破到文件或通过网络发送或在套接字连接中使用。

对象应当实现序列化Serializable接口，这样我们就可以使用`java.io.ObjectOutputStream`写入对象到文件或者任何输出流OutputStream对象了。阅读更多[java序列化](https://www.journaldev.com/927/objectoutputstream-java-write-object-file)知识。

把二进制流数据转换成对象的过程被称做为反序列化。阅读更多[java反序列化](https://www.journaldev.com/933/objectinputstream-java-read-object-file)知识。

### 48. 通过命令提示行怎样运行JAR文件？

能使用命令行运行jar包文件，但需要在jar清单文件中有Main入口类。含Main的类是jar包的入口点，用来通过java命令执行。

### 49. System类的用途是什么？

java System类是核心类之一，`System.out.print()`是其中一个方法。在调试时，它是最简单的记录日志信息的方法。

System类被声明为final的。因此无法被子类继承和覆盖其行为。也不提供任何公共构造器，因此也不能实例这个类。也是为什么它的所有方法是静态static的原因。

System类提供了数组拷贝、获取当前时间、读环境变化等助手类方法。阅读更多[java System类](https://www.journaldev.com/1847/java-system-java-lang-system-class)知识。

### 50. instanceof关键字的用途是什么？

instanceof关键字用来检测是否属于某个类。我们应当尽可能的避免使用它。

### 51. switch case语句中能使用字符串类型吗？

java 7引入的新特性之一，switch case语句中可以使用字符串类型。因此java 7或更高版本可以使用。

### 52. java是通过值传递还是通过引用传递？

这个问题非常具有迷惑性。我们知道对象变量在堆空间中包含引用的对象。在我们调用任何方法时，这个变量的拷贝被转递并存储在方法的栈内存中。我们能够检测到任何语言它是通过引用或通过值传递通过一个简单的交换方法，请阅读[更多](https://www.journaldev.com/3884/java-is-pass-by-value-and-not-pass-by-reference)。由此我们得出java是通过值传递而不是通过引用传递的。

### 53. 堆Heap和栈Stack内存有什么区别？

堆和栈主要的区别如下：

* 所有应用的部分都使用堆内存，然而只有执行线程使用栈内存。
* 每当对象被创建时，它总是存在堆空间中，栈内存包含它的引用。栈内存仅包括本地的原始变量，在堆空间中的对象的引用变量。
*栈内存是通后进先出LIFO的方法管理的，然而在堆内存中因为它是全局使用，所以它的管理方式更加复杂。

在同一程序中更加详细的解释，请阅读[java堆vs栈内存](https://www.journaldev.com/4098/java-heap-space-vs-stack-memory)


### 54. java编译器是存储在JDK，JRE或JVM哪一个中？

java编译器的任务是转换java程序到字节码，我们使用`javac`命令执行即可实现。因此它必须要存在JDK中。

### 55. 如下程序将输出什么？

1. 在类中的静态方法

```java
package tests;

public class Test {

    public static String toString(){
        System.out.println("Test toString called");
        return "";
    }
    
    public static void main(String args[]){
        System.out.println(toString());
    }
}
```

答：以上代码不能编译。因为所有类对继承根对象类Object。以上会编译错误提示静态方法不能覆盖实例方法。

2. 静态方法调用

```java
package tests;

public class Test {

    public static String foo(){
        System.out.println("Test foo called");
        return "";
    }
    
    public static void main(String args[]){
        Test obj = null;
        System.out.println(obj.foo());
    }
}
```

答：这是个奇怪的使用场景。NULL空对象调用方法是总会报`NullPointerException`异常，且该方法是属于类的静态方法，但该程序能工作并打印"Test foo called"。

原因是编译器做了编译优化。在java编译转换成字节码时，它指向的foo()是静态方法，而不是对象方法，因此编译从`obj.foo()`调整到`Test.foo()`，于是也没有了`NullPointerException`异常。

[原文](https://www.journaldev.com/2366/core-java-interview-questions-and-answers#public-class)