---
title: ORM常用的设计模式
tags: orm,gateway pattern, active record pattern, data mapper pattern,对象关系映射， 网关模式, 活动记录模式 , 数据映射模式
categories: 
  - java

thumbnail: /gallery/blue-water2.jpg
---

ORM(Object Relational Mapping)即对象关系映射，一种用于实现对象语言与不同类型的关系型数据之间的转换。

<!-- more -->

我们讨论该问题目的在于如何让我们系统中的对象与数据库进行交互。由于数据库与对象之间存在着结构上的差异，Mapping是相当困难的。不推荐开发人员自己进行Mapping Layer的开发，这是危险的也是及其可能失败的。更加推荐购买专业的工具，虽然这些工具通常很昂贵。到目前为止，我所接触的项目确实有Mapping layer，但它并不是典型的Mapping layer between Relational Database and Object，它是处于JSP页面与Database之间的Mapping，用于自动地将用户在页面上填写的数据更新到数据库中。这在Web项目中是很好用的，但目前这个Mapping Layer还不能做到general，它只能适用与特定的Web Application架构。

下面开始与大家聊聊三种Database Mapping层的常用的系统架构。 

## 1. 网关模式（Gateway） 

之所以称之“网关”，顾名思义，Mapping层扮演着一个代理的角色，应用逻辑层无需知道具体Mapping的细节，而只需通过网关的公共接口，提交数据更新或者数据加载请求，由网关去执行具体的Object到Record或者Record到Object的转换。从而实现了数据层的透明。应用逻辑层所要了解的只有网关的信息和其公共接口。使用公共接口同时有助应用逻辑代码在不同的数据层的复用：无需改变应用逻辑层的任何代码，只需为特定的数据层实现特定的网关。网关模式具体分为两种：Row Data Gateway & Table Data Gateway 

共同的特点： 

对应于数据库中的每个Table，有一个Mapping Class，并且在这个class中每个column有其对应的字段；所有的数据库mapping代码都存在于在Mapping Class之中，使数据库访问代码与应用逻辑完全分离； 

### Row Data Gateway 

Mapping Class是一个对应于数据库中某张表格的一条记录。记录的每个字段对应于Class中的一个Field。所有访问数据的细节都被封装在这个接口中。Row Data Gateway与Transaction Script配合使用，效果很好 

典型案例: Java中的SessionBean（Transaction Script）和EntityBean（Row Data Gateway） 

适用情况：应用逻辑相对复杂，对象与对象之间交互繁多的大规模系统； 

### Table Data Gateway： 

这个接口定义了关于某个Table的所有查询（find），更新，插入和删除代码。Table Data Gateway将输入的参数mapping成对应的SQL，并执行SQL，最后返回适当的数据结构。如何返回Query的信息是一个具有欺骗性的决策问题。当需要返回多个记录并且函数只允许返回一个结果时，你将面临着多种选择：Map & Data Transfer Object & Record Set。 

Map：不是一个好方法，map中的Key常常是一种HardCode； 

Data Transfer Object：是避免map的一个方法，并且可以被重用； 

Record Set：虽然会使Business Logic Layer不能完全与数据库访问层相分离，但是如果我们的开发平台有很多基于Record Set的工具，采用它不失为一个好方法（.NET）。 

典型案例：Window DNA架构； 

适用情况：以显示信息，修改信息为功能的MIS（信息管理系统）； 

## 2. 活动记录模式（Active Record） 

将Business Logic与数据库访问放置于同一个Business Object中。这种模式出现的原因是业务逻辑与数据库模型非常相似。Active Record同时负责数据库存取和基于这些数据的应用逻辑的执行。应用程序的所有逻辑可以都在Active Record中，也可以是部分。有一点是默认前提，Active Record的数据结构和数据库Schema必须保持一致（在我看来这是个缺点！） 

Active Record中通常有以下方法： 

从SQL数据集创建Active Record的构建方法； 

静态的finder方法用于封装SQL查询并且返回Active Record记录； 

用Active Record中的数据更新数据库的方法； 

所有字段getting和settting方法； 

实现应用逻辑的方法； 

活动记录模式的优点在于简单，其缺点在于没有隐藏数据库层，从而导致很难应用其他OR Mapping模式在活动记录模式之上。另外一方面，活动记录模式与Row Data Gateway的区别在于数据库存取代码是在Business Object中（Active Record）还是在一个单独的Mapping Class中（Row Data Gateway），当然也有同时存在于两者的情况；如果应用逻辑的复杂程度迫使你适用面向对象的一些机制（Direct relationships，collections and Inheritance），这时直接将数据库存取代码置于Business Object中，由于有大量的转换，会使事情变得混乱，这时应该适用Data Mapper。

但这并不是个好方法，因为它将面向对象设计和数据库设计紧密耦合在一起，这随着项目进展会使对设计的重构工作变得及其困难。通常我们会将数据库访问代码分离到一个Gateway中。有一种情况例外，当你对Transaction Script & Row Data Gateway的架构进行重构的时候，为了去除Transaction Script中的重复代码，将其放进Row Data Gateway中，这是就转变成Active Record了。 

适用情况：当应用逻辑不复杂，主要是创建，更新，插入，删除操作，而且操作主要是针对单条记录时； 

## 3. 数据映射模式（Data Mapper） 

这是最复杂，但最灵活的一种架构模式。使用Data Mapper，Business Objects可以与数据库结构完全的分离，他们无需知道数据库的结构和数据更新的细节。Data Mapper对于那些无法在关系型数据库表示的对象系统特性非常有效，例如Collection成员结构和继承关系。Data Mapper是内存中对象与数据库之间的媒介。它负责双方之间的数据传输。数据映射模式（Data Mapper）与网关模式最大的（Gateway）最大的区别在于依赖和控制的位置相反。在网关模式中，应用逻辑层需要了解数据库中的数据结构，二在数据映射模式中，应用逻辑无需了解数据库设计，提高了应用层（business logic）和数据层（data source）的分离，便于两者的开发和测试。

面向对象的对象系统与面向关系的关系型数据库是两种异构的结构，因此在对象系统中的很多机制（collections, inheritance等）都无法在关系型数据库中得到直接的表示，这就是数据映射模式产生的原因。在这种情况下，在两种模式下的数据转换变得相当复杂，因此我们有必要将它分层，否则任何一方（对象系统和数据库）的改变都将波及对方。 

数据映射层的最大目标就是将业务逻辑（domain）和数据层（data source）分离。整个数据映射层（Data Mapper）完全独立于系统其他部分，可以被完全替换或者允许一个逻辑层重用于不同的数据层上。但要实现它有很多重要的问题必须解决，而且不同人可以采用不同的方法实现这个数据映射模式（Data Mapper）。因此这里只介绍几个重要的实现问题。 

### ① Finder方法的处理 

处理方法： 

在一个独立的Package中，为Finder方法定义一个接口，然后在数据映射层实现这个接口。逻辑层通过接口调用Finder方法，后者通过数据映射层加载数据。 

原因：之所以使用接口的原因，在于使Finder方法标准化，这样应用逻辑层虽然可能在任何地方都会调用Finder方法取得带有数据的Business Object，但却不依赖于数据映射层。 

Finder方法：将方法调用转换成SQL查询； 

数据映射层：从数据集中获得数据并创建Business Object； 

遗留问题： 

数据映射层如何知道那些Object被更新了，哪些被创建，哪些被删除了？ 

如何控制每次查询获得的记录数，以尽量减少查询的数目？ 

其他模式如何用在数据映射层（Lazy Load, Registry, Identity Map）? 

### ② 如何将数据映射到Business Object的字段中 

数据映射层需要访问Business Object的所有字段，因此这些方法必须被设置为public，但这不不是我们所预想的。这个问题没有明确的答案，几种可选的方法都有两面性。 

* 将数据映射层于逻辑层放置于同一个包下 

缺点：有可能使事情变得更混乱； 

* 使用Reflection方法来访问Object的字段 

缺点：速度慢； 

增加状态标志来保证在数据库加载环境下访问这些字段 

针对这个问题，在创建Business Object的时候，你有两个选择，使用胖构造函数（这个名词是我自己取的:^)）空构造函数。 

* 胖构造函数（Rich Constructor） 

优点：保证Object至少包含必须的数据；对于常量字段，无需setting方法； 

缺点：必须考虑循环引用问题（cyclic reference）； 

* 空构造函数（Empty Constructor） 

优点：不会出现循环引用问题（cyclic reference）； 

缺点：对于常量字段，仍然需要setting方法，可能引入潜在错误； 

### ③ 基于元数据的映射（Metadata based Mapping） 

* 显式代码：这要求每个Business Object有一个Mapping class； 
* Metadata Mapping：元数据被存储在单独的class和文件中，我倾向于文件，随着xml的广泛使用，以XML形式存储元数据会增强移植性； 

## 3种OR Mapping架构模式的取舍和选用 

OR Mapping架构取决于应用逻辑层的架构。如果使用表模式（Table Module）来组织应用逻辑，那么Table Data Gateway是你的最佳选择；如果使用Transaction Script模式来组织应用逻辑，那么如果开发平台提供了使用数据集的方便就采用Table Data Gateway，否则采用Row Data Gateway；如果是使用Domain Model来建立应用逻辑模型，那么对于复杂的大系统，颖毫不犹豫地选择数据映射模式，对于逻辑简单的小系统，Active Record也是一个可选方案。

