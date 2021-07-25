# 集合

## HashMap的特点有哪些？与HastTable的区别

## HashMap的扩容机制

1.7数组+链表。头插法，相同数组的链倒过来了。指定负载因子

1.8节点+链表。一次性移过去

## HashMap的容量为什么是2的幂次

方便转移到新的位置，即可能不变，也可能是老的长度+现在的位置。减少碰撞

## 有集合A和集合B，现在需要将两个集合中重复的元素放入到集合C中，请问你会怎么编程实现

这道题，简单想到的是循环遍历两个集合A和B，然后将重复的元素放入到集合C中，我们来看看怎么实现？

```java
List<String> list1 = Arrays.asList("a","b","c");
List<String> list2 = Arrays.asList("a","b");
List<String> list3 = new ArrayList<>();
for (String a : list1) {
    for (String b : list2) {
        if(a.equals(b)){
            list3.add(a);
        }
    }
}
System.out.println(list3);
```

时间复杂度为O(n²)。

一个时间复杂度为O(n)的写法

```java
Set<String> set = new HashSet<>();
for (String a : list1) {
    set.add(a);
}
for (String b : list2) {
    if(set.contains(b)){
        list3.add(b);
    }
}
System.out.println(list3);
```

## 为什么使用红黑树，不用二叉树。  红黑树实现原理

## HashMap原理，列锁的原因

## HashMap中的put是如何实现的

## 为什么不直接将key作为哈希值而是与高16位做异或运算

## ConcurrentHasmMap扩容的过程

## 扩容列循环的问题

并发情况下，扩容时在同一节点，使用头插法，当达到3个或以上的时候，开成闭环，引起死循环



## WeekHashMap与HashMap的区别

1. WeekHashMap中默认存储的是弱引用键值条目（entry）,HashMap默认存储的是强引用entry
1. 当key丢弃时，WeekHashMap中对应的entry会被垃圾回收（GC），但HashMap不会。
1. WeekHashMap未实现Cloneable接口，仅实现了Map接口。

## ArrayList、LinkedList与Vector三者有什么区别

1. 从存储数据结构分析

    ArrayList：数组
    Vector：数组
    LinkedList：双向链表

    数组：可以根据下标快速查找，所以大部分情况下，查询快。
    但是如果要进行增删操作的时候，会需要移动修改元素后面的所有元素，所以增删的开销比较大，数组的对增删操作的执行效率低。而采用数组作为数据存储结构的ArrayList、Vector也存在这些特性，查询速度快（可以根据下标直接取，比迭代查找更快），增删慢。

    链表：增加和删除元素方便，增加或删除一个元素，仅需处理结点间的引用即可。就像人手拉手连成一排，要增加或删除某个人只要附近的两个人换一个人牵手，对已经牵好手的人没影响。无论在哪里换人耗费的资源和时间都是一样的。
    但是查询不方便，需要一个个对比，无法根据下标直接查找。而采用链表结构存储的LinkedList也有这些特性，增删方便，查询慢(指的是随机查询，不是顺序查询)。

1. 从继承上分析

    它们都实现了List接口，也就是说都实现了get(int location)、remove(int location)等“根据索引值来获取、删除节点的函数”。
    数组结构根据下标取值很容易，LinkedList双向链表的实现也比较简单，通过计数索引值实现，从链表长度的1/2开始查找，下标大了就从表头开始找，小了就从表尾开始找。

1. 从并发安全上分析

    Vector：线程安全
    ArrayList：非线程安全
    LinkedList:非线程安全

1. 数据增长分析

    Vector：缺省的情况下，增长为原数组长度的一倍。说到缺省，说明他其实是可以自主设置初始化大小的。

    ArrayList：自动增长原数组的50%。

## Iterator和ListIterator的区别

ListIterator继承与Iterator接口

Iterator只能单向遍历，而ListIterator可以双向遍历

Iterator可以遍历Set和List，而ListIterator只能遍历List

## 开发一个自己的栈，你会怎么写

首先，栈的特点是FILO(First In Last Out)

其次，底层的数据结构我们采用数组的方式

## ArrayList vs Vector

说句实话，对这种古老的Vector，之所以你在笔试题会遇到，我感觉是面试官偷懒了。

ArrayList：线程不安全，效率高，常用

Vector：线程安全的，效率低

我们看Vector的源码：

```java
    public synchronized void ensureCapacity(int minCapacity) {
        if (minCapacity > 0) {
            modCount++;
            ensureCapacityHelper(minCapacity);
        }
    }
```

## 谈谈ConcurrentHashMap，HashMap，Hashtable的区别

### 1. 首先，来看看其他几个相关的类

Hashtable是线程安全的，但效率低

HashMap是线程不安全的，但效率高

Collections.synchronizedMap()，工具类提供了同步包装器的方法，来返回具有线程安全的集合对象

性能依然有问题

```java
public static <K,V> Map<K,V> synchronizedMap(Map<K,V> m) {
    return new SynchronizedMap<>(m);
}

//在这个类的内部方法实现上，也只是单纯加上了锁

public V put(K key, V value) {
    synchronized (mutex) {return m.put(key, value);}
}

```

为解决这样的矛盾问题，所以JDK提供了并发包，来平衡这样的问题（java.util.concurrent）

### 2. ConcurrentHashMap（重点）

- 兼顾了线程安全和效率的问题

    > 分析：HashTable锁了整段数据（用户操作是不同的数据段，依然需要等待）。
    >
    > 解决方案：把数据分段，执行分段锁（分离锁），核心把锁的范围变小，这样出现并发冲突的概率就变小
    >
    > 在保存的时候，计算所存储的数据是属于哪一段，只锁当前这一段。

- ***注意：分段锁（分离锁）是JDK1.8之前的一种的方案，JDK1.8之后做了优化***。

### JDK1.7跟JDK1.8在ConcurrentHashMap的实现上存在以下区别

1. 数据结构

    JDK1.7采用链表的方式，而JDK1.8则采用链表+红黑树的方式

2. 发生hash碰撞之后

    JDK1.7发生碰撞之后，会采用链表的方式来解决

    JDK1.8发生碰撞之后，默认采用链表，但当链表的长度超过8，且数组容量超过64时，会转换为红黑树存储

3. 保证并发安全

    JDK1.7采用分段锁的方式，而JDK1.8采用CAS和synchronized的组合模式

4. 查询复杂度

    JDK1.7采用链表的方式，时间复杂度为O(n)，而JDK1.8在采用红黑树的方式时，时间复杂度为O(log(n))

题外话：

不过红黑树其实是一种兜底方案，因为当链表数量达到8个且数组容量超过64的时候，其发生的概率是千万分之几，所以作者考虑到这种极端情况下，需要用红黑树的方式来优化

## 谈谈LinkedHashMap和HashMap的区别（重点）

此处，我们好好谈谈HashMap

主要关注几个点：

1. 初始化大小是16。如果事先知道数据量的大小，建议修改默认初始化大小。 减少扩容次数，提高性能 ，这是我一直会强调的点

2. 最大的装载因子默认是0.75。当HashMap中元素个数达到容量的0.75时，就会扩容。 容量是原先的两倍

3. HashMap底层采用链表法来解决冲突。 但是存在一个问题，就是链表也可能会过长，影响性能。 于是JDK1.8,对HashMap做了进一步的优化，引入了红黑树。 当链表长度超过8，且数组容量大于64时，链表就会转换为红黑树。 当红黑树的节点数量小于6时，会将红黑树转换为链表。 因为在数据量较小的情况下，红黑树要维护自身平衡，比链表性能没有优势。

这3点非常重要！

其次，LinkedHashMap就是链表+哈希表的结构，其底层采用了Linked双向链表来保存节点的访问顺序，所以保证了有序性。

## 谈谈HashSet的存储原理

HashSet的存储原理或者工作原理，主要是从如何保证唯一性来说起。

这里面主要有3个问题，需要回答？

第一，为什么要采用Hash算法？有什么优势，解决了什么问题？

第二，所谓哈希表是一张什么表？

第三，HashSet如何保证保存对象的唯一性？会经历一个什么样的运算过程？

大家可以先思考，晚些再补充答案！

首先，我们要明确一点，***HashSet底层采用的是HashMap来实现存储***，其值作为HashMap的key

```java
    public boolean add(E e) {
        return map.put(e, PRESENT)==null;
    }
```

具体关于hashmap的细节再说

第一，为什么要采用Hash算法？有什么优势，解决了什么问题？

***解决的问题是唯一性***

存储数据，底层采用的是数组

当我们往数组放数据的时候，你如何判断是否唯一？

可以采用遍历的方式，逐个比较，但是这种效率低，尤其是数据很多的情况下

所以，为了解决这个效率低的问题，我们采用新的方式

采用hash算法，通过计算存储对象的hashcode，然后再跟数组长度-1做位运算，得到我们要存储在数组的哪个下标下，如果此时计算的位置没有其他元素，直接存储，不用比较。

此处，我们只会用到hashCode

但是随着元素的不断添加，就可能出现“哈希冲突”，不同的对象计算出来的hash值是相同的，这个时候，我们就需要比较，才需要用到equals方法

如果equals相同，则不插入，不相等，则形成链表

第二，所谓哈希表是一张什么表？

本质是一个数组，而且数组的元素是链表

JDK1.7的版本实现

JDK1.8做了优化

随着元素不断添加，链表可能会越来越长，会优化红黑树

## 如何在双向链表A和B之间插入C

关键是B理解为A.next节点。结合草图。

```java
C.pre = A;
C.next = A.next;
A.next.pre = C;
A.next = C;
```

## 谈谈ArrayList和LinkedList的区别

### 1. 底层数据结构的差异

> ArrayList，数组，连续一块内存空间
>
> LinkedList，双向链表，不是连续的内存空间

### 2. 一个常规的结论

虽然不严谨，但也可以应付很多面试了

> ArrayList，查找快，因为是连续的内存空间，方便寻址，但删除，插入慢，因为需要发生数据迁移
>
> LinkedList，查找慢，因为需要通过指针一个个寻找，但删除，插入块，因为只要改变前后节点的指针指向即可。

## List和Set的区别

- List（有序，可重复）

- Set（无序，不可重复）
