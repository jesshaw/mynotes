---
title: java字符串面试问题
tags: java,String,interview,字符串,面试
categories: 
  - java

thumbnail: /gallery/blue-water5.jpg
---
<!-- more -->

字符串是广泛使用的Java类之一。这里我列出了一些重要的Java字符串面试问题及答案。

这将极大的帮助我们获取字符串相关的全面知识，在面试中回答有关字符串的任何问题。

## Java字符串面试问题列表

1. Java中的字符串是什么？它是数据类型的吗？
2. 创建字符串对象有哪些不同的方式？
3. 写一个方法检查输入的字符串是否是回文？
4. 写一个方法从字符串中移出给定的字符？
5. 怎以确保字符串是大写或者小写？
6. 字符串的subSequence方法是什么？
7. Java编程时怎样比较两个字符串？
8. 怎样转换字符串到字符？反过来呢？
9. 怎样转换字符串到字节数据？反过来呢？
10. swicth case语句中能使用字符串类型吗？
11. 写一个程序打印所有字符串排列？
12. 写一个方法找出给出字符串中最长的回文？
13. String, StringBuffer and StringBuilder有什么区别？
14. Java中为什么字符串是永恒不变和拒绝继承的？
15. Java中怎样分隔字符串？
16. 为什么存储密码字符数组比字符串更合适？
17. Java中怎样检测两个字符串是否相等？
18. 字符串常量池是什么？
19. 字符串的`intern()`方法做了什么？
20. Java中的字符串是线程安全的吗？
21. Java中为什么字符串是受欢迎的Hasmap key？
22. 字符串编程？

## Java字符串面试问题及答案

### 1. Java中的String是什么？它是数据类型的吗？

String是一个定义在`java.lang`包中的Java类。它不是像int或long类似的原始数据类型。字符串(String)类表示了一个字符串。字符串被使用在几乎所有的Java就应用中，这里有一个我们应当知道的有趣的特性。**Java中的字符串是不可变的且无法扩展的。JVM使用字符串常量池存储所有字符串对象。其他有趣的是关于使用双引号初始化字符串的方式和“+”操作符重载**。

### 2. 创建字符串对象有哪些不同的方式？

可以使用`new`操作符或者双引号初始化一个字符串对象。也可以使用char数组, byte数组, StringBuffer或StringBuilder构造器初始化后，获取字符串对象。

```java
String str1 = "abc";
String str = new String("abc");
```
在我们使用双引号创建字符串时，JVM将从字符串常量池中查找，若找到相同的字符串，将直接返回引用，并直接指向它，否则重新创建一个字符串对象，存储在字符串常量池中，并指向它。

在使用new操作符时，JVM创建了字符串对象，但不存储在字符串常量池中。我们可以使用`intern()`方法存储它到字符串常量池，若池中存在相等的字符串，将直接返回引用。

### 3. 写一个方法检查输入的字符串是否是回文？

如果字符串反向后与反向前的值相等，则字符串是回文。如“aba”就是回文。

字符串类没有提供任何反向字符串的方法，但是StringBuffer和StringBuilder类提供，可以用于检测是否是回文。

```java
private static boolean isPalindrome(String str) {
    if (str == null)
        return false;
    StringBuilder strBuilder = new StringBuilder(str);
    strBuilder.reverse();
    return strBuilder.toString().equals(str);
}
```

有时面试官会问还有其他方式吗？这时你可以比较字符串中的字符方式来检测是否是回文。

```java
private static boolean isPalindrome(String str) {
   if (str == null)
        return false;
    int length = str.length();
    System.out.println(length / 2);
    for (int i = 0; i < length / 2; i++) {

        if (str.charAt(i) != str.charAt(length - i - 1))
            return false;
    }
    return true;
}
```

### 4. 写一个方法从字符串中移出给定的字符？

可以使用`replaceAll`方法把字符串多次替换成其他字符串。重点要提出的是接受的参数是字符串类型的，因此我们要使用Character类创建一个字符串类，然后替换成空字符串。

```java
private static String removeChar(String str, char c) {
    if (str == null)
        return null;
    return str.replaceAll(Character.toString(c), "");
}
```

### 5. 怎以确保字符串是大写或者小写？

使用`toUpperCase`和`toLowerCase`方法就可以得到大写和小写字符串。这两个方法还有带本地参数的变种方法。

### 6. 字符串的subSequence方法是什么？

Java 1.4 引入了CharSequence接口，字符串类实现了该接口。内部它是调用字符串类的substring方法。

### 7. Java编程时怎样比较两个字符串？

Java字符串实现了Comparable接口，它有两个变种的`compareTo()`方法。

`compareTo(String anotherString)`方法是按字典顺序比较字符串和入参字符串的。如果字符串先于输入参，则返回负整数，若字符串在入参之后。则返回正整数，若相等值则返回0，在这种情形时`equals(String str)`返回true。

`compareToIgnoreCase(String str)`方法与第一个相似，但忽略了大小写。

### 8. 怎样转换字符串到字符？反过来呢？

这是一个狡猾的问题，因为字符串是一亿字符序列，我们不能转换它到单个字符串。可以给出索引使用`charAt`方法得到指定位置的字符，也可以使用`toCharArray()`转换成字符数组。

使用new关键字就可以把字符数组转换成字符串。使用`Character.toString(char c)`转换字符到字符串。

### 9. 怎样转换字符串到字节数据？反过来呢？

使用字符串的`getBytes()`方法转换字符串到字节数组，使用字符串构造器`new String(byte[] arr)`转换字节数组到字符串。

### 10. swicth case语句中能使用字符串类型吗？

java 7引入的新特性之一，switch case语句中可以使用字符串类型。因此java 7或更高版本可以使用。

### 11. 写一个程序打印给出字符串的所有的排列方式？

这是一个狡猾的问题，我们需要递归找出所有的排列，如“AAB”的所有排列是“AAB”，“ABA”和“BAA”。我们需要`Set`来确保不重复的值。

首先要获取首个字符与剩下的字符排列做交集。如“ABC”，首字符是A，剩下字符排列是“BC”和“CB”。我们可以把剩下不同的排例插入到首字符。   
BC -> ABC, BAC, BCA  
CB -> ACB, CAB, CBA  
依此类推，递归就实现了以上算法。

```java
package test;

import java.util.HashSet;
import java.util.Set;

/**
 * Java Program to find all permutations of a String
 * @author xxx
 *
 */
public class StringHelper {
    public static Set<String> permutationFinder(String str) {
        Set<String> perm = new HashSet<String>();
        //Handling error scenarios
        if (str == null) {
            return null;
        } else if (str.length() == 0) {
            perm.add("");
            return perm;
        }
        char initial = str.charAt(0); // first character
        String rem = str.substring(1); // Full string without first character
        Set<String> words = permutationFinder(rem);
        for (String strNew : words) {
            for (int i = 0;i<=strNew.length();i++){
                perm.add(charInsert(strNew, initial, i));
            }
        }
        return perm;
    }

    public static String charInsert(String str, char c, int j) {
        String begin = str.substring(0, j);
        String end = str.substring(j);
        return begin + c + end;
    }

    public static void main(String[] args) {
        String s = "AAC";
        String s1 = "ABC";
        String s2 = "ABCD";
        System.out.println("\nPermutations for " + s + " are: \n" + permutationFinder(s));
        System.out.println("\nPermutations for " + s1 + " are: \n" + permutationFinder(s1));
        System.out.println("\nPermutations for " + s2 + " are: \n" + permutationFinder(s2));
    }
}

```

### 12. 写一个方法找出给出字符串中最长的回文？

关键点是任何回文从中间开始左右各移动1位，字符相等。若是奇数长度则中间为1位，若是偶数长度中间为2位。

```java
package test;

public class LongestPalindromeFinder {

    public static void main(String[] args) {
        System.out.println(longestPalindromeString("1234"));
        System.out.println(longestPalindromeString("12321"));
        System.out.println(longestPalindromeString("9912321456"));
        System.out.println(longestPalindromeString("9912333321456"));
        System.out.println(longestPalindromeString("12145445499"));
        System.out.println(longestPalindromeString("1223213"));
        System.out.println(longestPalindromeString("abb"));
    }

    static public String intermediatePalindrome(String s, int left, int right) {
        if (left > right) return null;
        while (left >= 0 && right < s.length()
                && s.charAt(left) == s.charAt(right)) {
            left--;
            right++;
        }
        return s.substring(left + 1, right);
    }

    // O(n^2)
    public static String longestPalindromeString(String s) {
        if (s == null) return null;
        String longest = s.substring(0, 1);
        for (int i = 0; i < s.length() - 1; i++) {
            //odd cases like 121 奇数长度中间为1位。
            String palindrome = intermediatePalindrome(s, i, i);
            if (palindrome.length() > longest.length()) {
                longest = palindrome;
            }
            //even cases like 1221 偶数长度中间为2位
            palindrome = intermediatePalindrome(s, i, i + 1);
            if (palindrome.length() > longest.length()) {
                longest = palindrome;
            }
        }
        return longest;
    }
}
```

### 13. String, StringBuffer and StringBuilder有什么区别？

String是永不变化且拒绝扩展的。因此在做String操作时，创建了新的字符串。由于String操作有资源消耗，因此提供了String操作的助手类--StringBuffer和StringBuilder。

StringBuffer和StringBuilder都是可变的类。因加了同步锁，所以StringBuffer操作时是线程安全的，而StringBuilder不是。因此在多线程操作同一字符串时应当使用StringBuffer，但单线程环境我们应当使用StringBuilder。

StringBuilder性能优于StringBuffer是因为StringBuilder未加同步锁。

### 14. Java中为什么字符串是永恒不变和拒绝继承的？

字符是永恒不变和拒绝继承有如下好处：

1. 字符串不可变才使得线程池变为可能。
2. 因为在存储诸如用户名和密码等第三信息时，任何黑客不能改变它的值。增强了安全性！
3. 由于字符串不可变，它就可以安全用于多线程中，不需要任何同步。
4. 字符串不可变性，使得java类加载器可以准确的加载。

### 15. Java中怎样分隔字符串？

基于正规表达式的方式，使用`split(String regex)`分隔转换成字符串数组。 

### 16. 为什么存储密码字符数组比字符串更合适？  

1. 因为字符串是不可变对象，如果作为普通文本存储密码，那么它会一直存在内存中直至被垃圾收集器回收。因为字符串从字符串池中取出的（如果池中有该字符串就直接从池中获取，否则new 一个出来，然后把它放入池中），这样有很大的机会长期保留在内存中，这样会引发安全问题。因为任何可以访问内存的人能以明码的方式把密码dump出来。另外你还应该始终以加密而不是普通的文本来表示密码。因为字符串是不可变，因此没有任何方法可以改变其内容，任何改变都将产生一个新的字符串，而如果使用char[]，你就可以设置所有的元素为空或者为零（这里意思是说，让认证完后该数组不再使用了，就可以用零或者null覆盖原来的密码，防止别人从内存中dump出来）。所以存储密码用字符数组可以明显的减轻密码被盗的危险。
2. Java官方本身也推荐字符数组，JpasswordField的方法getPassword()就是返回一个字符数组，而由于安全原因getText()方法是被废弃掉的，因为它返回一个纯文本字符串。跟随Java 团队的步伐吧，没有错。
3. 字符串以普通文本打印在log文件或控制台中也易引起危险，但是如果使用数组你不能打印数组的内容，而是它的内存地址。尽管这不是它的真正原因，但仍值得注意。

### 17. Java中怎样检测两个字符串是否相等？

有`equal`和`==`操作符实现。使用`==`操作符除了检查值之外还要检查是否是同一引用，更多时候我们是检查值是否相等。因此我们应当使用`equal`检查两个字符串是否相等。

### 18. 字符串常量池是什么？

正如名字所示，字符串常量池是存储在Java堆内存中的一个字符串的常量池。

### 19. 字符串的`intern()`方法做了什么？

在做`intern`调用时，如果字符串池中存在相等值（`equals(Object)`）的字符串对象，则返回引用。否则创建后添加到字符串池，并引用它。

### 20. Java中的字符串是线程安全的吗？

字符串是不可变的，因此程序中不能改变这个值。因此是编程安全的，可以被安全的用于多线程环境。

### 21. Java中为什么字符串是受欢迎的Hasmap key？

由于字符串不可变，它的hascode是在创建时缓存的，它也不需要再次计算。也使得他在处理时比其他key对象更快。这也是为什么字符串最常用来当做HasMap key的原因。

### 22. 字符串编程？

#### 1. 如下程序的输出?

```java
package test;

public class StringTest {

    public static void main(String[] args) {
        String s1 = new String("pankaj");
        String s2 = new String("PANKAJ");
        System.out.println(s1 = s2);
    }

}
```
这是一个简单但狡猾的问题，不要忘记`==`操作符。


#### 2. 如下程序的输出?

```java
package test;

public class Test {

     public void foo(String s) {
     System.out.println("String");
     }

     public void foo(StringBuffer sb){
     System.out.println("StringBuffer");
     }

     public static void main(String[] args) {
        new Test().foo(null);
    }

}
```

出现编译错误“The method foo(String) is ambiguous for the type Test”。入参没有明确类型。

#### 3. 如下代码段将输出什么?

```java
String s1 = new String("abc");
String s2 = new String("abc");
System.out.println(s1 == s2);
```

输出“false”，因为`new`操作符强行创建了引用，`==`操作会比较引用。

#### 4. 如下代码段将输出什么?

```java
String s1 = "abc";
StringBuffer s2 = new StringBuffer(s1);
System.out.println(s1.equals(s2));
```
输出“false”，因为`equals`方法实现会使用`instanceof`操作检查类型，相同类型且值相等则返回true，否返回false。

#### 5. 如下代码段将输出什么?

```java
String s1 = "abc";
String s2 = new String("abc");
s2.intern();
System.out.println(s1 ==s2);
```
输出“false”，`intern()`返回了引用，但需再次分配给s2，若`s2 = s2.intern()`，则输出“true”。

#### 6. 如下代码段创建了多少个String对象？

```java
String s1 = new String("Hello");  
String s2 = new String("Hello");
```
答案是3个。 
第1个 - 第1行, 存储在字符串常量池的“Hello” 对象。   
第2个 - 第1行, 在堆内存的“Hello”字符串对象。  
第3个 - 第2行, 在堆内存的“Hello”字符串对象（内存地址与上一行的不一样），这里的“Hello”字符重用了字符串常量中的字符串。 

[原文](https://www.journaldev.com/1321/java-string-interview-questions-and-answers)