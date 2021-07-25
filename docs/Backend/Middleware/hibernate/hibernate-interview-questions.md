---
title: Hibernate面试问题
tags: Hibernate,ORM
categories: 
  - db

thumbnail: /gallery/green-water2.jpg

---
Hibernate是Java应用程序中使用最广泛的ORM工具之一 用于许多的企业应用程序中的数据库操作。因此我决定写一篇关于Hibernate面试问题的文章，以便在面试前刷新你的相关知识。
<!-- more -->
无论你是新手还是老鸟，具有良好的知识或Hibernate的ORM工具有助于破解面试问题。在这里，我提供了重要的Hibernate面试问题和答案，以帮助您提高自己的知识面，并打动面试官 
 
最近我写了大量关于Hibernate的文章，其中大多数都包含完整的可下载项目 我会在需要时为他们提供参考，您可以通过他们来刷新您的知识。

## Hibernate面试问题

1. 什么是Hibernate框架？
2. 什么是Java Persistence API（JPA）？
2. 使用Hibernate Framework的主要优势是什么？
2. Hibernate相比JDBC有什么优势？
2. Hibernate框架的一些重要接口的名称是什么？
2. 什么是Hibernate配置文件？
2. 什么是Hibernate映射文件？
2. 用于Hibernate映射的一些重要注解的名称是什么？
2. 什么是Hibernate SessionFactory以及如何配置它？
2. Hibernate SessionFactory是线程安全的吗？
11. 什么是Hibernate Session以及如何获取它？
2. Hibernate会话是线程安全的吗？
2. openSession和getCurrentSession有什么区别？
2. Hibernate Session get（）和load（）方法有什么区别？
2. 什么是Hibernate缓存？ 解释Hibernate的第一级缓存？
2. 如何使用EHCache配置Hibernate二级缓存？
17. 实体bean的有些什么不同状态？
18. Hibernate Session merge（）用来做什么？
2. Hibernate的save（），saveOrUpdate（）和persist（）方法有什么区别？
2. 如果我们在Entity bean中没有无参数构造函数会发生什么？
21. 排序集合（sorted collection）和有序集合（ordered collection）之间有什么区别，哪一个更好？
2. Hibernate中的有哪些集合类型？
2. 如何在Hibernate中实现连接？
2. 为什么我们不应该让实体类final类？
2. 什么是HQL？它有什么好处？
2. 什么是Hibernate中的查询缓存？
2. 我们可以在Hibernate中执行原生的sql查询吗？
2. 原生SQL查询支持在Hibernate中的好处是什么？
2. 什么是命名SQL查询？
2. 命名SQL查询有什么好处？
2. Hibernate Criteria API有什么好处？
31. 如何在日志文件中记录Hibernate生成的sql查询？
2. 什么是Hibernate Proxy以及它如何在延迟加载中提供帮助？
2. 如何在Hibernate中实现关联？
2. 事务管理如何在Hibernate中工作？
2. 什么是级联，什么是不同类型的级联？
2. 如何将log4j日志集成到Hibernate应用程序中？
2. 如何在Hibernate框架中使用应用程序服务器JNDI DataSource？
2. 如何整合Hibernate和Spring框架？
2. 什么是HibernateTemplate类？
2. 如何将Hibernate与Servlet或Struts2 Web应用程序集成？
41. Hibernate框架中使用哪些设计模式？
2. Hibernate框架遵循的最佳实践是什么？
2. 什么是Hibernate验证框架？
2. Hibernate Tools Eclipse插件的好处是什么？

## Hibernate面试问题答

### 1. 什么是Hibernate框架？

对象关系映射或ORM是将应用程序域模型对象映射到关系数据库表的编程技术 Hibernate是基于Java的ORM工具，它提供了将应用程序域对象映射到关系数据库表的框架，反之亦然。

Hibernate提供了Java Persistence API的引用实现，这使得它成为具有松耦合优势的ORM工具的绝佳选择，我们可以使用Hibernate Persistence API进行CRUD操作，Hibernate框架提供了使用JPA注解以及基于XML的配置将普通的旧java对象映射到传统数据库表的选项。

同样，Hibernate配置也很灵活，可以通过XML配置文件以及编程方式完成，有关Hibernate框架用法的快速概述，您可以学习Hibernate初学者教程 。

### 2. 什么是Java Persistence API（JPA）？

Java Persistence API（JPA）提供了管理应用程序中的关系数据的规范，当前JPA 2.1版于2011年7月开始，名为JSR 338. 2013年5月22日，JPA 2.1被批准为最终版。

JPA规范是在javax.persistence包中，使用注解定义的，使用JPA注解有助于我们编写实现独立（无依赖）的代码。

### 3. 使用Hibernate Framework的主要优势是什么？

使用Hibernate框架的一些主要优势是：

1. Hibernate消除了JDBC附带的所有重复代码并负责管理资源，因此我们可以专注于业务逻辑。
2. Hibernate框架提供对XML和JPA注解的支持，这使得我们的代码实现独立。
3. Hibernate提供了一种类似于SQL的强大查询语言（HQL），然而，HQL完全是面向对象的，理解继承，多态和关联等概念。
4. Hibernate是红帽社区（ Red Hat Community）的一个开源项目，在世界各地都有使用这使得它成为比其他人更好的选择，因为学习曲线很小，并且有大量在线文档和帮助可以在论坛中轻松获得。
5. Hibernate很容易与其他Java EE框架集成，它非常流行，因此Spring Framework提供了内置的支持，将Hibernate与Spring应用程序集成在一起。
6. Hibernate支持使用代理对象进行延迟初始化，并仅在需要时执行实际的数据库查询。
7. Hibernate缓存有助于我们获得更好的性能。
8. 对于数据库供应商特定的功能，Hibernate是合适的，因为我们也可以执行本机sql查询。

总体来说，Hibernate是目前ORM工具市场上的最佳选择，它包含了ORM工具所需的所有功能。

### 4. Hibernate相比JDBC有什么优势？

Hibernate框架相对于JDBC的一些主要优势是：

1. Hibernate移除了JDBC API附带的大量重复代码，代码看起来更清晰可读。
2. Hibernate支持继承，关联和集合 这些功能在JDBC API中不存在。
3. Hibernate隐式提供事务管理，事实上大部分查询不能在事务外执行。在JDBC API中，我们需要使用提交和回滚编写事务管理代码，阅读更多关于JDBC事务管理 。
4. JDBC API在检测到异常时，会抛出SQLException ，所以我们需要编写大量的try-catch块代码 大多数情况下，在业务管理中，每次JDBC调用调用多次都是冗余的，Hibernate包装JDBC异常并抛出`JDBCException`或`HibernateException`未检查异常，所以我们不需要编写代码来处理它，Hibernate内置的事务管理消除了try-catch块的使用。
5. Hibernate查询语言（HQL）更加面向对象，接近于Java编程语言，对于JDBC，我们需要编写原生的SQL查询。
6. Hibernate支持缓存，性能更好，JDBC查询不会被缓存，因此性能很低。
7 Hibernate提供了选项，我们也可以通过它来创建数据库表，因为JDBC表必须存在于数据库中。
8. Hibernate配置可以帮助我们使用JDBC连接以及连接池的JNDI DataSource，这是企业应用程序中非常重要的特性，但在JDBC API中完全缺失。
9. Hibernate支持JPA注解，所以代码与实现无关，可以用其他ORM工具轻松替换，JDBC代码与应用程序耦合非常紧密。

### 5. Hibernate框架的一些重要接口的名称是什么？

Hibernate框架的一些重要接口是：

1. **SessionFactory（org.Hibernate.SessionFactory）**：SessionFactory是单个数据库的编译映射的不可变线程安全的缓存 我们需要初始化SessionFactory，然后我们可以缓存并重用它，SessionFactory实例用于获取数据库操作的Session对象。
2. **Session（org.Hibernate.Session）**：Session是一个单线程，暂存的对象，表示应用程序和持久性存储之间的会话，它封装了JDBC`java.sql.Connection`并作为`org.Hibernate.Transaction`的工厂工作 我们应该只在需要时才打开会话，并在我们完成使用后立即关闭会话。Session对象是java应用程序代码和Hibernate框架之间的接口，并提供CRUD操作的方法。
3. **Transaction（org.Hibernate.Transaction）**：Transaction是应用程序用来指定原子工作单元的单线程，暂存对象，它从底层的JDBC或JTA(Java Transaction API)事务中抽象出应用程序，在某些情况下，org.Hibernate.Session可能跨越多个org.Hibernate.Transaction。

### 6. 什么是Hibernate配置文件？

Hibernate配置文件包含特定于数据库的配置并用于初始化SessionFactory，我们在Hibernate配置xml文件中提供数据库凭证或JNDI资源信息。Hibernate配置文件的其他一些重要部分是Dialect信息，以便Hibernate知道数据库类型和映射文件或类的详细信息。

### 7. 什么是Hibernate映射文件？

Hibernate映射文件用于定义实体bean字段和数据库表列映射。我们知道JPA注解可用于映射，但有时在使用第三方类时，XML映射文件可能更方便，而不能使用注解。

### 8. 用于Hibernate映射的一些重要注解的名称是什么？

Hibernate支持JPA注解，并且在org.Hibernate.annotations包中有一些其他注解，使用的一些重要的JPA和Hibernate注解是：

1. **javax.persistence.Entity** ：与模型类一起使用来指定它们是实体bean。
2. **javax.persistence.Table** ：与实体bean一起用于在数据库中定义相应的表名。
3. **javax.persistence.Access** ：用于定义访问类型，字段或属性。默认值是field，如果你想让Hibernate使用getter/setter方法，那么你需要将它设置为属性。
4. **javax.persistence.Id** ：用于在实体bean中定义主键。
5. **javax.persistence.EmbeddedId** ：用于在实体bean中定义复合主键。
6. **javax.persistence.Column** ：用于在数据库表中定义列名。
7. **javax.persistence.GeneratedValue** ：用于定义用于生成主键的策略 与javax.persistence.GenerationType enum一起使用。
8. **javax.persistence.OneToOne** ：用于定义两个实体bean之间的一对一映射 我们还有其他类似的注解，如OneToMany，ManyToOne和ManyToMany
9. **org.Hibernate.annotations.Cascade** ：用于定义两个实体bean之间的级联，与映射一起使用。它与org.Hibernate.annotations.CascadeType一起使用
10. **javax.persistence.PrimaryKeyJoinColumn** ：用于为外键定义属性。与org.Hibernate.annotations.GenericGenerator和org.Hibernate.annotations.Parameter

以下是显示这些注解使用情况的两个类。
```java
import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;

@Entity
@Table(name = "EMPLOYEE")
@Access(value=AccessType.FIELD)
public class Employee {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "emp_id")
	private long id;

	@Column(name = "emp_name")
	private String name;

	@OneToOne(mappedBy = "employee")
	@Cascade(value = org.hibernate.annotations.CascadeType.ALL)
	private Address address;

	//getter setter methods
}
```
```java
import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "ADDRESS")
@Access(value=AccessType.FIELD)
public class Address {

	@Id
	@Column(name = "emp_id", unique = true, nullable = false)
	@GeneratedValue(generator = "gen")
	@GenericGenerator(name = "gen", strategy = "foreign", parameters = { @Parameter(name = "property", value = "employee") })
	private long id;

	@Column(name = "address_line1")
	private String addressLine1;

	@OneToOne
	@PrimaryKeyJoinColumn
	private Employee employee;

	//getter setter methods
}
```

### 9. 什么是Hibernate SessionFactory以及如何配置它？

SessionFactory是用于获取Session对象的工厂类。SessionFactory负责读取Hibernate配置参数并连接到数据库并提供Session对象。通常应用程序具有一个SessionFactory实例，并且服务于客户端请求的线程从该工厂获取Session实例。

SessionFactory的内部状态是不可变的。一旦它被创建，这个内部状态就被设置了。这个内部状态包括关于对象/关系映射的所有元数据。

SessionFactory还提供获取Class元数据和Statistics实例以获取查询执行状态，二级缓存详细信息等的方法。

### 10. Hibernate SessionFactory是线程安全的吗？

SessionFactory的内部状态是不可变的，所以它是线程安全的。多个线程可以同时访问它以获取Session实例。


### 11. 什么是Hibernate Session以及如何获取它？

Hibernate Session是java应用层和Hibernate之间的接口。这是用来执行数据库操作的核心接口。会话的生命周期受事务开始和结束的约束。

会话提供方法来执行持久对象的创建，读取，更新和删除操作。我们可以执行HQL查询，SQL本机查询并使用Session对象创建条件。

### 12. Hibernate会话是线程安全的吗？

Hibernate Session对象不是线程安全的，每个线程都应该获得它自己的会话实例，并在工作完成后关闭它。

### 13. openSession和getCurrentSession有什么区别？

Hibernate SessionFactory getCurrentSession（）方法返回绑定到上下文的会话。但为了这个工作，我们需要在Hibernate配置文件中配置它。由于这个会话对象属于Hibernate上下文，所以我们不需要关闭它。一旦会话工厂关闭，此会话对象就会关闭。
```xml
<property name="hibernate.current_session_context_class">thread</property>
```

Hibernate SessionFactory openSession（）方法总是打开一个新的会话。一旦我们完成了所有的数据库操作，我们应该关闭这个会话对象。我们应该在多线程环境中为每个请求打开一个新会话。

还有另一种方法openStatelessSession（）返回无状态会话，有关示例的更多详细信息，请阅读Hibernate openSession vs getCurrentSession。

### 14. Hibernate Session get（）和load（）方法有什么区别？

Hibernate会话有不同的方法来从数据库加载数据。get和load是最常用的方法，首先看起来它们很相似，但它们之间有一些差异。

1. get（）在调用数据后立即加载数据，而load（）返回代理对象并仅在实际需要时才加载数据，所以load（）更好，因为它支持延迟加载。
2. 由于load（）在没有找到数据时抛出异常，所以只有当我们知道数据存在时才应该使用它。（get方法返回null，但load若为null则报异常）
3. 当我们想要确保数据库中存在数据时，我们应该使用get（）。

有关差异的说明，请阅读Hibernate get vs load 。


### 15. 什么是Hibernate缓存？解释Hibernate的一级缓存？

顾名思义，Hibernate缓存查询数据以使我们的应用程序更快。如果使用正确，Hibernate Cache可以在获得快速应用程序性能方面非常有用 缓存背后的想法是减少数据库查询的数量，从而减少应用程序的吞吐时间。

Hibernate一级缓存与Session对象相关联。Hibernate一级缓存默认启用，无法禁用它。然而，Hibernate提供了一些方法，我们可以通过这些方法从缓存中删除选定的对象或完全清除缓存。

在会话中缓存的任何对象对其他会话都不可见，并且在会话关闭时，所有缓存的对象也将丢失。

为了更好的解释，请阅读Hibernate一级缓存 。


### 16. 如何使用EHCache配置Hibernate二级缓存？

EHCache是​​利用Hibernate二级缓存的最佳选择。在Hibernate应用程序中启用EHCache需要执行以下步骤。

在Maven项目中添加Hibernate-ehcache依赖项，如果它不是maven，则添加相应的jar。
```xml
<dependency>
        <groupId>org.hibernate</groupId>
        <artifactId>hibernate-ehcache</artifactId>
        <version>4.3.5.Final</version>
</dependency>
```

在Hibernate配置文件中添加以下属性。
 ```xml
 <property name="hibernate.cache.region.factory_class">org.hibernate.cache.ehcache.EhCacheRegionFactory</property>
         
<!-- For singleton factory -->
<!-- <property name="hibernate.cache.region.factory_class">org.hibernate.cache.ehcache.SingletonEhCacheRegionFactory</property>
-->
          
<!-- enable second level cache and query cache -->
<property name="hibernate.cache.use_second_level_cache">true</property>
<property name="hibernate.cache.use_query_cache">true</property>
<property name="net.sf.ehcache.configurationResourceName">/myehcache.xml</property>
 ```
创建EHCache配置文件，示例文件myehcache.xml如下所示。
```xml
<?xml version="1.0" encoding="UTF-8"?>
<ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="ehcache.xsd" updateCheck="true"
    monitoring="autodetect" dynamicConfig="true">
 
    <diskStore path="java.io.tmpdir/ehcache" />
 
    <defaultCache maxEntriesLocalHeap="10000" eternal="false"
        timeToIdleSeconds="120" timeToLiveSeconds="120" diskSpoolBufferSizeMB="30"
        maxEntriesLocalDisk="10000000" diskExpiryThreadIntervalSeconds="120"
        memoryStoreEvictionPolicy="LRU" statistics="true">
        <persistence strategy="localTempSwap" />
    </defaultCache>
 
    <cache name="employee" maxEntriesLocalHeap="10000" eternal="false"
        timeToIdleSeconds="5" timeToLiveSeconds="10">
        <persistence strategy="localTempSwap" />
    </cache>
 
    <cache name="org.hibernate.cache.internal.StandardQueryCache"
        maxEntriesLocalHeap="5" eternal="false" timeToLiveSeconds="120">
        <persistence strategy="localTempSwap" />
    </cache>
 
    <cache name="org.hibernate.cache.spi.UpdateTimestampsCache"
        maxEntriesLocalHeap="5000" eternal="true">
        <persistence strategy="localTempSwap" />
    </cache>
</ehcache>
```

使用@Cache注解和缓存策略注解实体bean 例如，
```java
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "ADDRESS")
@Cache(usage=CacheConcurrencyStrategy.READ_ONLY, region="employee")
public class Address {

}
 ```
就是这样，我们完成了 Hibernate将使用EHCache进行二级缓存，请阅读Hibernate EHCache示例以获得完整的解释示例。


### 17. 实体bean的有些什么不同状态？

实体bean实例可以以下三种状态的其中之一。

1. **瞬时态（Transient）** ：当对象永远不会持久或与任何会话无关联时，它处于瞬态状态。通过调用save（），persist（）或saveOrUpdate（），可以使瞬态实例持久化 通过调用delete（）可以使持久性实例成为暂态。
2. **持久态（Persistent）** ：当对象与唯一会话关联时，它处于持久状态。由get（）或load（）方法返回的任何实例都是持久的。
3. **游离态（Detached）** ：当一个对象先前是持久性的，但没有与任何会话相关联时，它处于游离状态。游离的实例可以通过调用update（），saveOrUpdate（），lock（）或replicate（）来持久化。通过调用merge（），瞬时或游离实例的状态也可以作为新的持久实例持久化。

### 18. Hibernate Session merge（）用来做什么？

Hibernate合并可以用来更新现有的值，但是这种方法从传递的实体对象中创建一个副本并返回它。返回的对象是持久化上下文的一部分，并对任何更改进行跟踪，传递的对象不被跟踪。 示例程序，阅读Hibernate合并 。


### 19. Hibernate的save（），saveOrUpdate（）和persist（）方法有什么区别？

Hibernate保存可用于将实体保存到数据库。save（）的问题是它可以在没有事务的情况下被调用，如果我们有映射实体，那么只有主对象被保存，导致数据不一致。另外保存立即返回生成的ID。

Hibernate persist与事务保存类似。我觉得它比保存更好，因为我们不能在事务边界外使用它，所以所有的对象映射都被保留下来。此外，persist不会立即返回生成的ID，因此数据持久化发生在需要的时候。

根据提供的数据将Hibernate saveOrUpdate结果插入或更新查询。如果数据存在于数据库中，则执行更新查询。我们也可以在没有事务的情况下使用saveOrUpdate（），但如果会话不刷新，您将再次遇到映射对象未保存的问题。例如使用这些方法，请阅读Hibernate save vs persist 。


### 20. 如果我们在Entity bean中没有无参数构造函数会发生什么？

Hibernate使用Reflection API来创建实体bean的实例，通常在调用get（）或load（）方法时 方法Class.newInstance()用于此，它需要无参数构造函数。因此，如果你在实体bean中没有无参数构造函数，Hibernate将无法实例化它，你将得到HibernateException 。


### 21. 排序集合（sorted collection）和有序集合（ordered collection）之间有什么区别，哪一个更好？

当我们使用Collection API排序算法对一个集合进行排序时，它被称为排序集合。对于小型集合来说，它没有多少开销，但对于较大的集合，它可能导致性能下降和OutOfMemory错误。另外，实体bean应该实现`Comparable`或`Comparator`接口，以便在Java对象列表排序时进行更多的工作。

如果我们使用Hibernate框架从数据库加载集合数据，我们可以使用它的Criteria API来使用“order by”子句来获得有序列表。下面的代码片段显示了如何获取它。

```java
List<Employee> empList = session.createCriteria(Employee.class)
						.addOrder(Order.desc("id")).list();
```
有序列表比排序列表要好，因为实际的排序是在数据库级完成的，速度很快并且不会导致内存问题。


### 22. Hibernate中的有哪些集合类型？

Hibernate中有五种集合类型用于一对多关系映射。

1. Bag
2. Set
3. List
4. Array
5. Map

### 23. 如何在Hibernate中实现连接？

有多种方法可以在Hibernate中实现连接。

1. 使用诸如一对一，一对多等关联。
2. 在HQL查询中使用JOIN。还有另一种形式“联合提取”来同时加载相关数据，没有延迟加载。
3. 我们可以触发原生的sql查询并使用join关键字。

### 24. 为什么我们不应该让实体类final类？

只有在需要的时候，Hibernate才会使用代理类来延迟加载数据。这是通过扩展实体bean来完成的，如果实体bean是final类，那么延迟加载将不可能，因此性能低下。

### 25. 什么是HQL？它有什么好处？

Hibernate Framework带有一个强大的面向对象的查询语言--Hibernate Query Language（HQL）。它与SQL很相似，除了我们使用对象而不是表名，这使得它更接近于面向对象的编程。

除java类和变量名之外，Hibernate查询语言不区分大小写的。因此，SeLeCT与sELEct与SELECT相同，但com.lexiangmiao.model.Employee与com.lexiangmiao.model.EMPLOYEE不同。

HQL查询被缓存，但我们应尽可能避免它，否则我们将不得不照顾关联。 然而，由于面向对象的方法，它是比原生SQL查询更好的选择。 阅读HQL示例 。


### 26. 什么是Hibernate中的查询缓存？

Hibernate为查询结果集实现了一个缓存区域，该查询结果集与Hibernate二级缓存紧密集成。

这是一个可选功能，需要额外的代码步骤。这只对使用相同参数频繁运行的查询很有用。首先我们需要在Hibernate配置文件中配置下面的属性。
```xml
<property name="hibernate.cache.use_query_cache">true</property>
```

在代码中，我们需要使用Query的setCacheable（true）方法，快速示例如下所示。
```java
Query query = session.createQuery("from Employee");
query.setCacheable(true);
query.setCacheRegion("ALL_EMP");
```

### 27. 我们可以在Hibernate中执行原生的sql查询吗？

Hibernate提供了通过使用SQLQuery对象来执行原生SQL查询的选项。

然而，对于正常情况来说，它不是推荐的方法，因为我们失去了与Hibernate关联和Hibernate一级缓存相关的好处。阅读Hibernate Native SQL查询示例。

### 28. 原生SQL查询支持在Hibernate中的好处是什么？

当我们想要执行Hibernate API不支持的特定于数据库的查询（如查询提示或Oracle数据库中的CONNECT关键字）时，原生SQL Query便于使用。

### 29. 什么是命名SQL查询？

Hibernate提供了可以在中心位置定义的命名查询（ Named Query），并在代码中的任何地方使用它们。我们可以为HQL和Native SQL创建命名查询。

Hibernate命名查询可以在Hibernate映射文件中定义，也可以通过使用JPA注角@NamedQuery和@NamedNativeQuery来定义。

### 30. 命名SQL查询有什么好处？

1. Hibernate命名查询（ Named Query）帮助我们将查询分组在一个中心位置（便于管理），而不是让它们遍布整个代码。 
2. 在创建Hibernate会话工厂时检查Hibernate命名查询语法，从而在命名查询出现任何错误的情况下使应用程序快速失败。（便于查错） 
3. Hibernate命名查询是全局的，意味着一旦定义它可以在整个应用程序中使用。 

然而，命名查询的一个主要缺点是很难调试，因为我们需要找出它的定义位置。

### 31. Hibernate Criteria API有什么好处？

Hibernate提供的Criteria API更加面向对象，用于查询数据库和获取结果。我们不能使用Criteria来运行更新或删除查询或任何DDL语句。它仅用于使用更多面向对象的方法从数据库中获取结果。

Criteria API的一些常见用法是：

1. Criteria API提供了Projection，我们可以使用sum（），min（），max（）等集合函数。
2. Criteria API可以与ProjectionList一起使用来仅提取选定的列。
3. Criteria API可以通过连接多个表来用于连接查询，有用的方法是createAlias（），setFetchMode（）和setProjection（）
4. Criteria API可用于获取带有条件的结果，有用的方法是add（），我们可以在其中添加限制条件。
5. Criteria API提供了可用于排序结果的addOrder（）方法。

在Hibernate标准示例中学习一些快速示例。


### 32. 如何在日志文件中记录Hibernate生成的sql查询？

我们可以在Hibernate配置下面设置属性来记录SQL查询。
```xml
  <property name="hibernate.show_sql">true</property>
```
但是，我们应该只在开发或测试环境中使用它，并在生产环境中关闭它。


### 33. 什么是Hibernate Proxy以及它如何在延迟加载中提供帮助？

Hibernate使用代理对象来支持延迟加载。基本上，当你从表中加载数据时，Hibernate不加载所有的映射对象。只要通过getter方法引用子对象或查找对象，如果链接的实体不在会话缓存中，则代理代码将转到数据库并加载链接的对象。它使用javassist来有效地动态生成实体对象的子类实现。

### 34. 如何在Hibernate中实现关联？

我们可以在Hibernate中轻松实现一对一，一对多和多对多的关联。 它可以使用JPA注解以及基于XML的配置来完成 为了更好地理解，你应该阅读以下教程。

1. Hibernate一对一映射
2. Hibernate一对多映射
3. Hibernate多对多映射

### 35. 事务管理如何在Hibernate中工作？

在Hibernate中事务管理非常简单，因为大多数操作在事务之外是不允许的。所以在从SessionFactory获得会话之后，我们可以调用会话`beginTransaction()`来启动事务。此方法返回事务引用，我们稍后可以使用该引用来提交或回滚事务。

总的来说，Hibernate事务管理比JDBC事务管理要好，因为我们不需要依赖异常来回滚。**会话方法引发的任何异常都会自动回滚事务**。

### 36. 什么是级联，什么是不同类型的级联？

当我们有实体之间的关系时，我们需要定义不同的操作将如何影响另一个实体。这是通过级联完成的，它有不同的类型。

以下是在主要和次要实体之间应用级联的简单示例。
```java
 import org.hibernate.annotations.Cascade;

@Entity
@Table(name = "EMPLOYEE")
public class Employee {

@OneToOne(mappedBy = "employee")
@Cascade(value = org.hibernate.annotations.CascadeType.ALL)
private Address address;

}
```

请注意，Hibernate CascadeType枚举常量与JPA `javax.persistence.CascadeType`稍有不同，因此我们需要使用Hibernate。CascadeType和Cascade批注进行映射，如上例所示 

CascadeType枚举中定义的常用级联类型有：

1. None：没有级联，它不是一种类型，但是当我们没有定义任何级联时，父级没有任何操作会影响孩子。
2. ALL：级联save, delete, update, evict, lock, replicate, merge, persist。基本上一切。
3. SAVE_UPDATE：级联保存和更新，仅在Hibernate时可用。
4. DELETE：仅在Hibernate中对应于Hibernate本机DELETE操作。
5. DETATCH，MERGE，PERSIST，REFRESH和REMOVE - 此类类似的操作
6. LOCK：对应于Hibernate本地LOCK动作。
7. REPLICATE：对应于Hibernate本地REPLICATE操作。

### 37. 如何将log4j日志集成到Hibernate应用程序中？

Hibernate 4使用JBoss日志记录，而不是早期版本中使用的slf4j。对于log4j配置，我们需要遵循以下步骤。

1. 为maven项目添加log4j依赖项，如果不是maven，则添加相应的jar文件。
2. 创建log4j.xml配置文件或log4j.properties文件并将其保存在类路径中。无论您想要什么，您都可以保留文件名，因为我们将在下一步中加载它。
3. 对于独立项目，使用静态块使用DOMConfigurator或PropertyConfigurator配置log4j。对于Web应用程序，您可以使用ServletContextListener来配置它。

就是这样，我们的设置已经准备就绪。在java类中创建org.apache.log4j.Logger实例并开始记录。对于完整的示例代码，您应该参阅Hibernate log4j示例和Servlet log4j示例。

### 38. 如何在Hibernate框架中使用应用程序服务器JNDI DataSource？

对于Web应用程序，最好允许servlet容器管理连接池。这就是我们为DataSource定义JNDI资源的原因，并且我们可以在Web应用程序中使用它 在Hibernate中使用非常简单，我们需要的是删除所有数据库特定的属性，并使用下面的属性来提供JNDI数据源名称。
```xml
<property name="hibernate.connection.datasource">java:comp/env/jdbc/MyLocalDB</property>
```
有关完整示例，请参阅Hibernate JNDI数据源示例 。


### 39. 如何整合Hibernate和Spring框架？

Spring是最常用的Java EE框架之一，Hibernate是最流行的ORM框架。这就是Spring Hibernate组合在企业应用程序中被广泛使用的原因。Spring最好的部分就是它提供了Spring ORM模块对Hibernate的开箱即用集成支持。将Spring和Hibernate框架集成在一起需要执行以下步骤。

1. 添加Hibernate-entitymanager，Hibernate-core和spring-orm依赖项。
2. 为数据库操作创建模型类和相应的DAO实现。 请注意，DAO类将使用将由Spring Bean配置注入的SessionFactory。
3. 如果您使用Hibernate 3，则需要在Spring Bean配置文件中配置org.springframework.orm.Hibernate3.LocalSessionFactoryBean或org.springframework.orm.Hibernate3.annotation.AnnotationSessionFactoryBean。对于Hibernate 4，应该配置单个类org.springframework.orm.Hibernate4.LocalSessionFactoryBean 。
4. 请注意，我们不需要使用Hibernate事务管理，我们可以使用@Transactional注解将它留给Spring声明式事务管理。

有关完整的示例，请参阅Spring Hibernate集成和Spring MVC Hibernate集成 。


### 40. 什么是HibernateTemplate类？

当Spring和Hibernate集成开始时，Spring ORM提供了两个辅助类HibernateDaoSupport和HibernateTemplate。使用它们的原因是从Hibernate获取Session并获得Spring事务管理的好处。 但是从Hibernate 3.0.1开始，我们可以使用SessionFactory getCurrentSession（）方法获取当前会话并使用它来获得Spring事务管理的好处。如果你通过上面的例子，你会看到它是多么容易，这就是为什么我们不应该再使用这些类。

HibernateTemplate另一个好处是异常转换，但可以通过在服务类中使用@Repository注解轻松实现，如上面的spring mvc示例所示。这是判断你的知识的一个诡计问题，以及你是否知道最近的事态发展。


### 41. 如何将Hibernate与Servlet或Struts2 Web应用程序集成？

Hibernate与Servlet或Struts2的集成需要使用ServletContextListener完成，在Hibernate Struts2集成示例中可以找到完整的示例。

### 42. Hibernate框架中使用哪些设计模式？

Hibernate框架中使用的一些设计模式是：

领域模型（Domain Model）模式 - 包含行为和数据的领域的对象模型。
数据映射器（Data Mapper） - 一层映射器，它可以在对象和数据库之间移动数据，同时保持对象和映射器本身的独立性。
代理模式用于延迟加载
SessionFactory中的工厂模式

### 43. Hibernate框架遵循的最佳实践是什么？

在Hibernate中遵循的一些最佳实践是：

1. 总是检查主键字段的访问权限，如果它是在数据库层生成的，那么你不应该为此设置setter。
2. 默认情况下，Hibernate直接设置字段值，而不使用setter 所以如果你想让Hibernate使用setter，那么确保正确的访问被定义为`@Access(value=AccessType.PROPERTY)` 。
3. 如果访问类型是属性，请确保注解与getter方法而不是setter方法一起使用 避免在提交和获取方法上混合使用注解。
4. 仅当使用原生SQL查询是在无法使用HQL完成时（例如使用数据库特定功能），才使用原生SQL查询。
5. 如果您必须对集合进行排序，请使用有序列表，而不要使用Collection API进行排序。
6. 明智地使用命名查询，将其保存在一个地方以便于调试 仅将它们用于常用查询 对于特定于实体的查询，您可以将它们保留在实体bean本身中。
7. 对于Web应用程序，总是尝试使用JNDI DataSource而不是配置来在Hibernate中创建连接。
8. 避免多对多关系，可以使用双向一对多和多对一关系轻松实现。
9. 对于集合，尝试使用Lists, maps and sets。避免使用array，因为你没有得到延迟加载的好处。
10. 不要将异常视为可恢复，回滚事务并关闭会话。如果你不这样做，Hibernate不能保证内存状态准确地表示持久状态。
11. 首选DAO模式来暴露可用于实体bean的不同方法。
12. 倾向于关联的延迟抓取。

### 44. 什么是Hibernate验证框架？

数据验证是任何应用程序的组成部分。您将在表示层使用Javascript找到数据验证，然后在处理它之前在服务器端代码，在持久化之前也要进行数据验证，以确保它遵循正确的格式。

验证是一项横切任务，所以我们应该尽量保持它与业务逻辑的区分。这就是为什么JSR303和JSR349提供通过使用注解来验证bean的规范。Hibernate Validator提供了这两个bean验证规范的参考实现。在Hibernate验证示例中阅读更多内容。


### 45. Hibernate Tools Eclipse插件的好处是什么？

Hibernate Tools插件可以帮助我们轻松编写Hibernate配置和映射文件。主要的好处是内容帮助可以帮助我们使用属性或xml标签。它还会根据Hibernate DTD文件来验证它们，所以我们事先知道任何错误。学习如何安装和使用Hibernate Tools Eclipse插件。

这就是Hibernate面试的问题和答案，我希望它能帮助你作为新人或有经验的人面试。


## 引用
1. [原文](https://www.journaldev.com/3633/hibernate-interview-questions-and-answers?utm_source=website&utm_medium=menubar&utm_campaign=Top-Menu-Bar)
