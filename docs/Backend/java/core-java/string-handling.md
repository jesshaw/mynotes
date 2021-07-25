# 字符串处理

## String s=new String("abc"); 创建了几个字符串？

将创建1或2个字符串。如果常量内存池中没有，则先在内存池中创建，再在堆中创建，否则只在堆中创建。

## String，StringBuffer，StringBuilder区别

String 跟其他两个类的区别是

String是final类型，每次声明的都是不可变的对象，

所以每次操作都会产生新的String对象，然后将指针指向新的String对象。

StringBuffer，StringBuilder都是在原有对象上进行操作

所以，如果需要经常改变字符串内容，则建议采用这两者。

StringBuffer vs StringBuilder

前者是线程安全的，后者是线程不安全的。

线程不安全性能更高，所以在开发中，优先采用StringBuilder.

StringBuilder > StringBuffer > String

## String s = "java"与String s = new String("java")

第一种方式，JVM会将其分配到常量池，而第二种方式是分配到堆内存

## 以下代码输出结果

```java
String s1 = new String("zs");
String s2 = new String("zs");
System.out.println(s1 == s2); //false

String s3 = "zs";
String s4 = "zs";
System.out.println(s3 == s4); //true
System.out.println(s3 == s1); //false

String s5 = "zszs";
String s6 = s3+s4; //因为s3,s4变量指针可变,所以是走new StringBuilder
System.out.println(s5 == s6); //false

final String s7 = "zs";
final String s8 = "zs";
String s9 = s7+s8; //因为s7,s8变量不可变，统译优化后直接替换成了zszs
System.out.println(s5 == s9);//true

final String s10 = s3+s4; //因为s3,s4变量指针可变,所以是走new StringBuilder
System.out.println(s5 == s10);//false
```
