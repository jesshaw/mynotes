---
title: java编程面试问题
tags: java,programming, interview,编程,面试
categories: 
  - java

thumbnail: /gallery/green-water3.jpg
---
在任何java面试中，编程面试总是起决定性影响。最近我参加了许多的面试，因此我搜集了一些有点狡猾的java编程面试题
<!-- more -->

先给出问题，可以自己做个小测验，最后与给出的答案和说明对照下，评估下自己掌握的java知识点。

## 1. java编程面试问题1

如下语句将输出什么？

```java
String s1 = "abc";
String s2 = "abc";
System.out.println("s1 == s2 is:" + s1 == s2);
```

## 2. java编程面试问题2

如下语句将输出什么？

```java
String s3 = "JournalDev";
int start = 1;
char end = 5;
System.out.print(start + end);
System.out.print(s3.substring(start, end));
```

## 3. java编程面试问题3

如下语句将输出什么？

```java
HashSet shortSet = new HashSet();
for (short i = 0; i < 100; i++) {
    shortSet.add(i);
    shortSet.remove(i - 1);
}
System.out.println(shortSet.size());
```

## 4. java编程面试问题4

布尔值flag为什么值可以到达finally语句块

```java
try {
    if (flag) {
        while (true) {
        }
    } else {
        System.exit(1);
    }
} finally {
    System.out.println("In Finally");
}
```

## 5. java编程面试问题5

如下语句将输出什么？

```java
String str = null;
String str1="abc";
System.out.println(str1.equals("abc") | str.equals(null));
```

## 6. java编程面试问题6

如下语句将输出什么？

```java
String x = "abc";
String y = "abc";
x.concat(y);
System.out.print(x);
```

## 7. java编程面试问题7

如下程序的将输出什么？

```java
public class MathTest {
    public void main(String[] args) {        
        int x = 10*10-10;        
        System.out.println(x);
    }
}
```

## 8. java编程面试问题8

如下程序在编译和执行时，将输出什么？

```java
public class Test {
    public static void main(String[] args) {
        try {
            throw new IOException("Hello");
        }catch(IOException | Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
```

## 希望你在看答案和解决之前先把上面的问题看一下

### 1. java编程面试问题1答案和说明

将输出“false”。“+”操作符优先于“==”操作符运逄，最终将输出"s1 == s2 is:abc" == "abc"的结果即false。

### 2. java编程面试问题2答案和说明

将输出“6ourn”。首先字符类型会转换成int型，之后字符串的字符数组是从0开始的，substring函数功能截取的从startIndex开始的，endIndex-startIndex长度的字符串。

### 3. java编程面试问题3答案和说明

将输出“100”。java自动装箱的特性在JDK5被引入，当我们在添加一个short类型值到HashSet<Short>时，short原始类型自动装箱转换成Short对象。当在执行i-1将被转换成int原始类型，在做删除时会被自动装箱成Integer对象，然而HashSet<Short>中并没有Integer对象，因此不能移除任何东西，所以最终列表的总数为100。

### 4. java编程面试问题4答案和说明

finally代码块将不可达。如果falg值为TRUE，将无限循环，若为FALSE，将退出JVM。

### 5. java编程面试问题5答案和说明

将输出抛出空指针异常java.lang.NullPointerException。在做“|”操作时str为null，null在做.equals()方法将会抛出异常。一般使用“||”和“&&”操作符做短路逻辑操作。

### 6. java编程面试问题6答案和说明

将输出“abc”。注意x.concat(y)将创建一个新字符串，但是并没有分配给x，因此x并未改变。

### 7. java编程面试问题7答案和说明

将产生运行时错误，main方法必须时static

### 8. java编程面试问题8答案和说明

不能输出“Hello”，将产生编译时错误，IOException继承自Exception，因此需要分层捕获，更具体的异常在前。


[原文](https://www.journaldev.com/370/java-programming-interview-questions)




