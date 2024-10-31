---
title: Java集合面试问题
tags: collections, list, set, map，堆空间,堆栈,栈内存,内存分配
categories: 
  - java

thumbnail: /gallery/green-water4.jpg
---
Java集合框架是Java编程语言的基本方面。 他是java面试问题的重要话题之一。 在这里，我列出了一些重要的java集合面试问题和答案，以帮助你面试。 这些直接来自我在Java编程方面10多年的经验。
<!-- more -->

## Java多线程面试问题

1. Java 8中新增与集合相关的功能是什么？
2. Java集合框架是什么？ 列出它的好处？ 
3. 泛型在集合框架中的好处是什么？
4. Java集合框架的基本接口有哪些？
5. 为什么Collection接口不能扩展Cloneable和Serializable接口？
3. 为什么Map接口不能扩展Collection接口？
3. 什么是迭代器？
3. 枚举和Iterator接口有什么区别？
3. 为什么没有类似Iterator.add（）的方法来添加元素到集合中？
3. 为什么迭代器没有一个方法直接得到下一个元素而不移动光标？
3. Iterator和ListIterator有什么不同？
3. 迭代列表有什么不同的方法？
3. 你怎么理解迭代器失败的快速属性？
3. 故障快速和故障安全有什么区别？
3. 如何在迭代集合时避免ConcurrentModificationException？
3. 为什么没有Iterator接口的具体实现？
3. 什么是UnsupportedOperationException？
3. HashMap如何在Java中工作？
19. hashCode()和equals()方法有何重要性？
3. 我们可以使用任何类作为Map键吗？
3. Map接口提供了哪些不同的集合视图？
3. HashMap和Hashtable有什么区别？
3. 如何决定HashMap和TreeMap？
3. ArrayList和Vector有什么相似之处？
3. Array和ArrayList有什么区别？ 你什么时候使用Array Array ArrayList？
3. ArrayList和LinkedList有什么区别？
3. 哪些集合类提供随机访问它的元素？
3. 什么是EnumSet？
3. 哪些集合类是线程安全的？
3. 什么是并发的集合类？
3. 什么是BlockingQueue？
3. 什么是队列和堆栈，列出他们的区别？
3. 什么是集合类？
3. 什么是Comparable和Comparator接口？
3. Comparable和Comparator接口有什么不同？
3. 我们如何排序对象列表？
3. 在将Collection作为参数传递给一个函数的时候，我们如何确保函数不能修改呢？
3. 我们如何从给定的集合创建一个同步的集合？
3. 在Collections Framework中实现的常用算法是什么？
3. 什么是大O符号？ 举一些例子？
3. 什么是与Java集合框架相关的最佳实践？
3. 什么是Java优先级队列？
3. 为什么我们不能把代码写成`List<Number> numbers = new ArrayList<Integer>();` ？
3. 为什么我们不能创建泛型数组？ 或者将代码编写为`List<Integer>[] array = new ArrayList<Integer>[10];`

## Java集合面试问题和答案

### 1. Java 8中新增与集合相关的功能是什么？

Java 8在Collection API中带来了重大变化。 一些变化是：

1. 用于集合类的Java Stream API ，用于支持顺序以及并行处理
2. 可迭代接口用forEach（）默认的方法扩展，我们可以使用它来遍历集合。在使用lambda表达式时非常有用，因为它的参数Consumer是一个函数接口 。
3. Miscellaneous Collection API改进，如Iterator接口中的`forEachRemaining(Consumer action)`方法，Map的`replaceAll()` ， `compute()` ， `merge()`方法。

### 2. Java集合框架是什么？ 列出它的好处？ 

每种编程语言都会使用集合，最初的java版本包含 Vector，Stack，Hashtable，Array几个集合的类。 但是考虑到更大范围使用，Java 1.2提出集合框架由集合接口、实现（类）和算法组成。
Java集合已经通过使用泛型和并发集合类来进行线程安全操作。 它还包括在java并发包中的阻塞接口及其实现。 

集合框架有如下好处：

* 通过使用核心集合类而不是实现我们自己的集合类来**减少开发工作量**。
* 通过使用经过良好测试的集合框架类来**提高代码质量**。
* 通过使用JDK附带的集合类**减少了代码维护的工作量**。
* **可重用性和互操作性**


### 3. 泛型在集合框架中的好处是什么？

Java 1.5引入泛型，所有的集合接口和实现都大量使用它。 泛型允许我们提供一个指定Object类型的类型集合，所以如果你尝试添加其他类型的元素，它会引发编译时错误。 

因为编译时会出现错误，从而可以避免运行时出现ClassCastException。此外，泛型使代码更简洁，因为我们不需要使用casting和instanceof操作符。


### 4. Java集合框架的基本接口有哪些？

`Collection`是集合层次结构的根。集合表示一组元素的对象。Java平台**不提供此接口的任何直接实现**。

`Set`是一个不能包含重复元素的集合。这个接口模拟数学集合抽象，并用来表示集合，例如**一副牌**。

`List`是一个有序的集合，可以包含重复的元素。 您可以从索引中访问任何元素。List更像是**动态长度的数组**。

`Map`是一个将键映射到值的对象。 Map不能包含重复键：每个键最多只能映射一个值。

其他一些接口是`Queue`，`Dequeue`，`Iterator`，`SortedSet`，`SortedMap`和`ListIterator`。


### 5. 为什么Collection接口不能扩展Cloneable和Serializable接口？

Collection接口指定了一组被称为元素的对象。元素如何维护取决于Collection的具体实现。例如，像List这样的一些Collection实现允许重复的元素，而像Set这样的其他实现不这样做。

很多集合实现都有一个公共的克隆方法。但是，将其包含在Collection的所有实现中并没有任何意义。这是因为Collection是一个抽象表示。 重要的是实现。

在处理实际的实现时，克隆或序列化的语义和含义起作用; 所以具体的实现应该决定如何克隆或序列化，甚至可以克隆或序列化。

因此，在所有实现中强制克隆和序列化实际上不那么灵活和更具限制性。 具体实施应该做出是否可以克隆或序列化的决定。


### 6. 为什么Map接口不能扩展Collection接口？

虽然Map接口和它的实现是集合框架的一部分，但Map不是集合，集合也不是Map。因此，Map对扩展Collection是没有意义的，反之亦然。

如果Map扩展了Collection接口，那么元素在哪里？Map包含键值对，它提供了将键或值列表作为集合检索的方法，但它不适合“元素组”范例。


### 7. 什么是Iterator接口？

Iterator接口提供了迭代任何Collection的方法。 我们可以使用iterator（）方法从一个Collection中获取迭代器实例。迭代器代替Java集合框架中的枚举。迭代器允许调用者在迭代期间从底层集合中移除元素。Java集合迭代器提供了一种遍历集合元素的通用方法，并实现了Iterator设计模式 。


### 8. Enumeration接口和Iterator接口有什么区别？

Enumeration接口的速度是Iterator接口的两倍，而且使用的内存很少。 Enumeration接口非常基本，适合基本需求。但是与Enumeration接口相比，Iterator接口更安全，因为它总是拒绝其他线程修改正在迭代的集合对象。 

Iterator接口代替Java集合框架中的Enumeration接口。Iterator接口允许调用者从底层集合中删除元素，但Enumeration接口中不能。 Iterator方法名称已被改进，以使其功能清晰。


### 9. 为什么没有类似Iterator.add（）的方法来添加元素到集合中？

语义不清楚，因为Iterator的合约不能保证迭代的顺序。但是请注意，ListIterator确实提供了一个添加操作，因为它确保了迭代的顺序。

### 10. 为什么Iterator没有一个方法直接得到下一个元素而不移动光标？

它可以在当前的Iterator接口之上实现，但是由于它的使用很少，所以将它包含在每个人都必须实现的接口中是没有意义的。


### 11. Iterator和ListIterator有什么不同？

* ListIterator继承自Iterator接口，并附带额外的功能，如添加元素，替换元素，获取前一个元素和下一个元素的索引位置。
* 我们可以使用Iterator遍历Set和List集合，而ListIterator只能用于List。
* Iterator只能沿正向移动，而ListIterator可以沿两个方向移动。

### 12. 迭代列表有什么不同的方法？

我们可以用两种不同的方式迭代列表 - 使用iterator和for-each循环。
```java
List<String> strList = new ArrayList<>();

//using for-each loop
for(String obj : strList){
    System.out.println(obj);
}

//using iterator
Iterator<String> it = strList.iterator();
while(it.hasNext()){
    String obj = it.next();
    System.out.println(obj);
}
 ```
使用iterator是更线程安全的，因为如果基础列表元素被修改，它将抛出ConcurrentModificationException。


### 13. 你怎么理解iterator fail-fast属性？

每当我们尝试获取下一个元素时，iterator fail-fast属性检查底层集合的结构中的任何修改。如果找到任何修改，则抛出ConcurrentModificationException。
Collection类中的Iterator的所有实现都是按设计fail-fast执行的，除了ConcurrentHashMap和CopyOnWriteArrayList等并发集合类。


### 14. fail-fast和fail-safe有什么区别？

iterator fail-safe属性与底层集合的克隆一起工作，因此它不受集合中任何修改的影响。 通过设计，java.util包中的所有集合类都是fail-fast的，而java.util.concurrent中的集合类是fail-safe的。

fail-fast iterator抛出ConcurrentModificationException，而fail-safe  iterator永远不抛出ConcurrentModificationException。 



### 15. 如何在迭代集合时避免ConcurrentModificationException？

我们可以使用并发集合类来避免ConcurrentModificationException迭代集合，例如CopyOnWriteArrayList而不是ArrayList。 



### 16. 为什么没有Iterator接口的具体实现？

Iterator接口声明迭代一个集合的方法，但它的实现是集合具体类的责任。每个返回遍历iterator的集合类都有自己的Iterator实现嵌套类。 

这允许集合类选择迭代器是fail-fast还是 fail-safe的。例如，ArrayList迭代器是fail-fast的，而CopyOnWriteArrayList迭代器是fail-safe的。


### 17. 什么是UnsupportedOperationException？

`UnsupportedOperationException`是用于指示操作不支持的异常。 它在JDK类中广泛使用，在集合框架`java.util.Collections.UnmodifiableCollection`对所有add和remove操作引发此异常。


### 18. HashMap如何在Java中工作？

HashMap在Map.Entry静态嵌套类实现中存储键值对。HashMap基于哈希算法进行工作，在put和get方法中使用hashCode（）和equals（）方法。

当我们通过传递键值对来调用put方法时，HashMap使用Key hashCode（）和hash来找出存储键值对的索引。 Entry存储在LinkedList中，所以如果已经存在，则使用equals（）方法检查传递的键是否已经存在，如果是则覆盖该值，否则会创建一个新Entry并保存。

当我们通过传递Key来调用get方法时，它再次使用hashCode（）来查找数组中的索引，然后使用equals（）方法来查找正确的Entry并返回它的值。 

其它关于HashMap比较重要的问题是容量、负荷系数和阀值调整。 HashMap初始默认容量为16 ，负载因子为0.75。 阈值是容量乘以负载因子，每当我们尝试添加entry时，如果映射大小大于阈值，则HashMap将映射的内容重新映射到具有更大容量的新数组中。 容量始终为2，所以如果你知道你需要存储大量的键值对，例如从数据库中缓存数据，最好用正确的容量和负载因子来初始化HashMap。


### 19. hashCode()和equals()方法有何重要性？

HashMap使用Key对象的hashCode（）和equals（）方法确定放置键值对的索引。 当我们试图从HashMap获取值时，也使用这些方法。 如果这些方法没有正确实现，两个不同的Key可能产生相同的hashCode（）和equals（）输出，在这种情况下，而不是将其存储在不同的位置，HashMap会认为它们相同并覆盖它们。

同样，所有不存储重复数据的集合类都使用hashCode（）和equals（）来查找重复项，所以正确实现它们非常重要。equals（）和hashCode（）的实现应遵循这些规则。

如果o1.equals(o2) ，那么o1.hashCode() == o2.hashCode()应该总是为true。

如果o1.hashCode() == o2.hashCode为true，那么并不意味着o1.equals(o2)将为true。
 
### 20. 我们可以使用任何类作为Map键吗？

我们可以使用任何类作为Map Key，但在使用它们之前应考虑以下几点。

* 如果类重写equals（）方法，它也应该重写hashCode（）方法。
* 该类应遵循与所有实例的equals（）和hashCode（）相关的规则。 请参阅前面的问题了解这些规则。
* 如果在equals（）中没有使用类字段，则不应在hashCode（）方法中使用它。
* 用户定义密钥类的最佳做法是使其不可变，以便可以高速缓存hashCode（）值以实现快速性能。 另外不可变的类确保hashCode（）和equals（）在将来不会改变，这将解决任何可变性问题。 

例如，假设我有一个用于HashMap键的类MyKey 。
```java
 //传递的MyKey name参数用于equals（）和hashCode（）
 MyKey key = new MyKey（“Pankaj”）;  //假定hashCode = 1234
 myHashMap.put（key，“Value”）;

 //下面的代码将改变密钥hashCode（）和equals（）
 //但是它的位置没有改变
 key.setName（ “阿米特”）;  //假定新的hashCode = 7890

 //下面将返回null，因为HashMap将尝试查找关键字
 //与它存储在同一个索引中，但是由于密钥发生了变化， 
 //将不会有匹配，它将返回null。
 myHashMap.get（new MyKey（“Pankaj”））; 
 ```
这就是为什么String和Integer主要用作HashMap键的原因。


### 21. Map接口提供了哪些不同的集合视图？

Map界面提供了三种集合视图：

1. `Set<K> keySet()`：返回包含在此映射中的键的Set视图。 该集合受Map支持，所以对地图的更改反映在集合中，反之亦然。 如果在对集合进行迭代的过程中修改了映射（除了通过迭代器自己的删除操作），迭代的结果是未定义的。该Set支持元素删除，通过Iterator.remove，Set.remove，removeAll，retainAll和clear操作从映射中删除相应的映射。 但它不支持add或addAll操作。
2. `Collection<V> values()`：返回此映射中包含的值的Collection视图。该集合受Map支持，所以对地图的更改反映在集合中，反之亦然。如果在迭代集合的过程中修改了映射（除了通过迭代器自己的删除操作），迭代的结果是未定义的。该集合支持元素删除，通过Iterator.remove，Collection.remove，removeAll，retainAll和Clear操作从映射中删除相应的映射。 但它不支持add或addAll操作。
3. `Set<Map.Entry<K, V>> entrySet()`：返回此映射中包含的映射的Set视图。该集合受Map支持，所以对地图的更改反映在集合中，反之亦然。 如果在对集合进行迭代的过程中修改了映射（除了通过迭代器自己的删除操作，或者通过迭代器返回的映射条目上的setValue操作），迭代的结果是未定义的。该Set支持元素删除，通过Iterator.remove，Set.remove，removeAll，retainAll和Clear操作从映射中删除相应的映射。但它不支持add或addAll操作。

### 22. HashMap和Hashtable有什么区别？

HashMap和Hashtable都实现了Map接口并且看起来很相似，但是HashMap和Hashtable之间存在以下区别。

1. HashMap允许空键和值，而Hashtable不允许空键和值。
2. Hashtable是同步的但HashMap不同步。所以HashMap对单线程环境更好，Hashtable适用于多线程环境。
3. LinkedHashMap是在Java 1.4中作为HashMap的子类引入的，所以如果你想要迭代次序，你可以很容易地从HashMap切换到LinkedHashMap，但是迭代顺序不可预测的Hashtable并不是这样。
4. HashMap提供了一组密钥来迭代，因此它是fail-fast的，但Hashtable提供了不支持这个特性的密钥枚举。
5. Hashtable被认为是遗留类，如果您在迭代时正在寻找Map的修改，则应该使用ConcurrentHashMap。

### 23. 如何决定HashMap和TreeMap？

为了插入，删除和定位Map中的元素，HashMap提供了最好的选择。但是，如果您需要按排序顺序遍历键，那么TreeMap是您更好的选择。 根据集合的大小，将元素添加到HashMap可能会更快，然后将映射转换为TreeMap以进行排序的键遍历。


### 24. ArrayList和Vector有什么相似之处？

ArrayList和Vector在很多方面都是类似的类。

1. 两者都是基于索引的，并由内部数组进行备份。
2. 两者都保持插入顺序，我们可以按照插入顺序获取元素。
3. ArrayList和Vector的迭代器实现都是fail-fast设计的。
4. ArrayList和Vector都允许空值和使用索引随机访问元素。

这些是ArrayList和Vector之间的区别。

1. Vector是同步的，而ArrayList不同步。但是，如果您在迭代时正在查找列表修改，则应该使用CopyOnWriteArrayList。
2. ArrayList比Vector快，因为它没有任何开销，因为同步。
3. ArrayList更通用，因为我们可以使用Collections实用程序类轻松地获得同步列表或只读列表。

### 25. Array和ArrayList有什么区别？ 你什么时候使用Array Array ArrayList？

Array可以包含原始类型或对象，而ArrayList只能包含对象。 
Array是固定大小，而ArrayList大小是动态的。 
Array不提供很多像ArrayList一样的功能，比如addAll，removeAll，iterator等

虽然ArrayList是我们在列表上工作的首选，但是Array有如下几个使用场景。

* 列表的大小是固定的，并且主要用于存储和遍历。
* 对于原始类型的列表，尽管集合使用自动装箱来减少编码工作，但是当处理固定大小的原始数据类型时，它仍会变慢。
* 如果您正在处理固定的多维情况，使用[] []比List <List <>>要容易得多。

### 26. ArrayList和LinkedList有什么区别？

ArrayList和LinkedList都实现了List接口，但是它们之间有一些区别。

1. ArrayList是一个由Array支持的基于索引的数据结构，因此它提供对性能为O（1）的元素的随机访问，但LinkedList将数据存储为节点列表，其中每个节点都链接到它的上一个节点和下一个节点。所以即使有一个方法来获取使用索引的元素，内部它从开始到达索引节点然后返回元素，所以性能是O（n）比ArrayList慢。
2. 在LinkedList中插入，添加或删除元素比ArrayList更快，因为在中间添加元素时，没有调整数组大小或更新索引的概念。
3. LinkedList比ArrayList消耗更多的内存，因为LinkedList中的每个节点都存储了前一个元素和下一个元素的引用。

### 27. 哪些集合类提供随机访问它的元素？

ArrayList，HashMap，TreeMap，Hashtable类提供随机访问它的元素。


### 28. 什么是EnumSet？

java.util.EnumSet被设置为与枚举类型一起使用。 枚举集合中的所有元素必须来自单个枚举类型，在创建集合时显式或隐式指定。 EnumSet不同步，不允许空元素。 它还提供了一些有用的方法，如copyOf（Collection c），（E first，E ... rest）和complementOf（EnumSet s）。

### 29. 哪些集合类是线程安全的？

Vector，Hashtable，Properties和Stack是同步类，所以它们是线程安全的，可以在多线程环境中使用。 Java 1.5 并发API包含一些集合类，允许在迭代时修改集合，因为它们工作在集合的克隆上，所以它们可以安全地在多线程环境中使用。

### 30. 什么是并发的集合类？

Java 1.5并发包（ java.util.concurrent ）包含线程安全的集合类，允许集合在迭代时被修改。 通过设计， java.util包中的迭代器实现fail-fast并引发ConcurrentModificationException。 但是java.util.concurrent包中的Iterator实现是自动安全的，我们可以在迭代时修改集合。 其中一些类是CopyOnWriteArrayList ， ConcurrentHashMap ， CopyOnWriteArraySet 。

### 31. 什么是BlockingQueue？

java.util.concurrent.BlockingQueue是一个队列，它支持在检索和删除元素时等待队列变为非空的操作，并且在添加元素时等待队列中的空间变为可用。

BlockingQueue接口是Java集合框架的一部分，主要用于实现生产者消费者问题。 BlockingQueue中的消费者可以使用BlockingQueue的实现类来处理生产者或对象的空间。

Java提供了几个BlockingQueue实现，如ArrayBlockingQueue，LinkedBlockingQueue，PriorityBlockingQueue，SynchronousQueue等 

### 32. 什么是Queue和Stack，列出他们的区别？

Queue和Stack都用于在处理数据之前存储数据。 java.util.Queue是一个接口，其实现类在java并发包中。 队列允许以先进先出（FIFO）顺序检索元素，但情况并非总是如此。 还有一个Deque接口，允许从队列的两端检索元素。 

堆栈与队列相似，只不过它允许以后进先出（LIFO）顺序检索元素。 

Stack是一个扩展Vector的类，而Queue则是一个接口。


### 33. 什么是Collections类？

java.util.Collections是一个实用工具类，它只包含对集合进行操作或返回集合的静态方法。 它包含对集合进行操作的多态算法，“包装器”，返回由指定集合支持的新集合，以及其他一些可能性和结束。

这个类包含用于收集框架算法的方法，例如二进制搜索，排序，混淆，反转等。

### 34. 什么是Comparable和Comparator接口？

Java提供了Comparable接口，如果我们想使用Arrays或Collections排序方法，应该由任何自定义类来实现。 可比较的接口有排序方法使用的compareTo（T obj）方法。如果“this”对象小于，等于或大于作为参数传递的对象，我们应该以这样的方式覆盖此方法，即返回负整数，零或正整数。

但是，在大多数现实生活场景中，我们希望根据不同的参数进行排序。比如，作为首席执行官，我想根据薪水对员工进行排序，人力资源部门会根据年龄对他们进行排序。 这是我们需要使用Comparator接口的情况，因为Comparable.compareTo(Object o)方法实现只能根据一个字段进行排序，而我们不能选择我们想要对该对象进行排序的字段。

Comparator接口中的compare(Object o1, Object o2)方法需要实现两个Object参数，它应该以这样的方式实现：如果第一个参数小于第二个参数，则返回负值int，如果相等则返回零如果第一个参数大于第二个参数，则为正值。


### 35. Comparable和Comparator接口有什么不同？

Comparable和Comparator接口用于排序集合或对象数组。

Comparable接口用于提供对象的自然排序，我们可以使用它来提供基于单一逻辑的排序。 （实体类实现）
Comparator接口用于提供不同的排序算法，我们可以选择我们想要用来对给定的对象集合进行排序的比较器。（调用方实现）


### 36. 我们如何排序对象列表？

如果我们需要排序一个对象数组，我们可以使用`Arrays.sort()`。 如果我们需要排序一个对象列表，我们可以使用`Collections.sort()`。 这两个类都有重载的sort（）方法用于自然排序（使用Comparable）或基于条件进行排序（使用Comparator）。 

集合内部使用Arrays排序方法，所以他们都有相同的性能，除了集合需要时间将列表转换为数组外。


### 37. 在将Collection作为参数传递给一个函数的时候，我们如何确保函数不能修改呢？

在传递参数之前，我们可以使用Collections.unmodifiableCollection(Collection c)方法创建一个只读集合，这将确保任何更改集合的操作都会抛出UnsupportedOperationException 。


### 38. 我们如何从给定的集合创建一个同步的集合？

我们可以使用Collections.synchronizedCollection(Collection c)来获得由指定集合支持的同步（线程安全）的集合。


### 39. 在Collections Framework中实现的常用算法是什么？

Java集合框架提供了常用的算法实现，如排序和搜索。 集合类包含这些方法的实现。这些算法大部分都在List上工作，但其中一些适用于各种集合。 
其中一些是排序，搜索，混淆，最小值最大值。


### 40. 什么是大O符号？ 举一些例子？

大O符号按照数据结构中元素的数量来描述算法的性能。由于Collection类实际上是数据结构，所以我们通常倾向于使用大O表示法来根据时间，内存和性能选择使用的集合实现。

示例1：ArrayList get(index i)是一个常量操作，不依赖于列表中元素的数量。 所以大O表示法的性能是O（1）。 
示例2：对数组或列表性能的线性搜索是O（n），因为我们需要搜索整个元素列表以查找元素。


### 41. 与Java  Collections框架相关的最佳实践是什么？

* 根据需要选择正确类型的集合，例如，如果大小是固定的，我们可能希望使用Array而不是ArrayList。如果我们必须按照插入次序遍历Map，那么我们需要使用TreeMap。 如果我们不想重复，我们应该使用Set。
* 有些集合类允许指定初始容量，因此如果我们预估了要存储的元素数量，我们可以使用它来避免重新哈希或调整大小。
* 根据接口而不是实现来编写程序，它使我们能够在更晚的时间点轻松地改变实现。
* 为了类型安全总是使用泛型，从而避免在运行时出现ClassCastException。
* 使用JDK提供的不可变类作为Map中的键，以避免为我们的自定义类实现hashCode（）和equals（）。
* 尽可能多地使用Collections工具类来获取算法，或者获取只读，同步或空集合，而不是编写自己的实现。它将增强代码重用的稳定性和可维护性。

### 42. Java PriorityQueue是什么？

PriorityQueue是基于优先级堆的无限队列，元素按照自然顺序排序，或者我们可以在创建时提供比较器进行排序。PriorityQueue不允许空值，我们不能添加任何不提供自然顺序的对象，或者我们没有任何比较器来排序。 Java PriorityQueue不是线程安全的，并提供了O（log（n））入队和出队操作的时间。 


### 43. 为什么我们不能把代码写成`List<Number> numbers = new ArrayList<Integer>();` ？

泛型不支持子类型，因为它会导致实现类型安全的问题。 这就是为什么`List <T>`不被认为是`List <S>`的子类型，其中S是T的超类型。为了理解为什么不被允许，让我们看看如果它被支持，会发生什么。
```java
 List <Long> listLong = new ArrayList <Long>（）;
 listLong.add（Long.valueOf（10））;
 List <Number> listNumbers = listLong;  //编译器错误
 listNumbers.add（Double.valueOf（1.23））;
 ```
正如你从上面的代码可以看到，IF泛型支持子类型输入，我们可以很容易地在Long列表中添加一个Double，这个Long列表在遍历Long列表的时候会在运行时导致ClassCastException 。


### 44. 为什么我们不能创建泛型数组？ 或者将代码编写为`List<Integer>[] array = new ArrayList<Integer>[10];`

我们不允许创建泛型数组，因为数组在运行时携带了元素的类型信息。如果元素类型与定义的类型不匹配，则在运行时使用此信息来抛出`ArrayStoreException` 。由于**泛型类型信息在编译时被类型擦除**，所以数组存储检查将会在应该失败的地方通过。让我们用一个简单的示例代码来理解这一点。
```java
 List <Integer> [] intList = new List <Integer> [5];  //编译错误
 Object [] objArray = intList;
 List <Double> doubleList = new ArrayList <Double>（）;
 doubleList.add（Double.valueOf（1.23））;
 objArray [0] = doubleList;  //这会失败，但会通过，因为在运行时intList和doubleList都只是List
 ```
数组是自然协变的，即当S是T的子类型时，S []是T []的一个子类型，但泛型不支持协方差或子类型，正如我们在上一个问题中看到的那样。所以如果我们被允许创建通用数组，因为类型擦除，我们不会得到数组存储异常，即使这两种类型都不相关。

## 引用
1. [原文](https://www.journaldev.com/1330/java-collections-interview-questions-and-answers)