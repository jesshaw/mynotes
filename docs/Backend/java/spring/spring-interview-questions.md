# Spring面试问题

Spring框架是最受欢迎的Java企业级web应用框架。*依赖注入*和*面象方面*是*Spring框架*的核心。
<!-- more -->

我最近提交了许多[Spring教程](https://www.journaldev.com/2888/spring-tutorial-spring-core-tutorial)，它将有助于帮你详细的解释Spring面试问题的核心概念。

## Spring面试问题列表

1. Spring框架是什么？
2. Spring框架有些什么重要的特性和优势？
3. 你对依赖注入的理解是什么？
4. Spring框架中怎么样实现依赖注入？
5. 使用Spring工具套件有什么好处？
6. 重要的Spring模块名称有哪些？
7. 你对面向切面编程的理解是什么？
8. AOP中的Aspect, Advice, Pointcut, JointPoint and Advice Arguments是什么？
9. Spring AOP 和AspectJ AOP有什么区别？
10. Spring IoC容器是什么？
11. Spring Bean是什么？
12. Spring Bean配置文件的重要性是什么？
13. 把一个类配置成Spring Bean有些什么不同方法？
14. Spring Bean有些什么不同作用域？
15. [Spring Bean生命周期是什么？](#spring-bean-life-cycle)
16. 在Spring Bean中怎么获得ServletContext和ServletConfig对象
17. Bean装配和@Autowired注解是什么？
18. Spring Bean自动装配有几种不同类型？
19. Spring Bean是线程安全的吗？
20. 在Spring MVC的Controller是什么？
21. 在Spring中 @Component, @Repository 和 @Service注解有什么区别？
22. DispatcherServlet 和 ContextLoaderListener是什么？
23. 在Spring中的ViewResolver是什么？
24. MultipartResolver是什么？什么时候使用？
25. Spring MVC框架怎样处理异常？
26. 在Java程序中怎样创建ApplicationContext？
27. 能有多个Spring配置文件吗？
28. ContextLoaderListener是什么？
29. 为了创建Spring MVC应用，至少需要配置什么？
30. [相对与MVC架构，你对Spring MVC框架的理解是怎样的？](#spring-mvc-architecture)
31. Spring MVC应用怎样实现平地化？
32. 使用Spring怎样创建Restful Web服务并返回JSON？
33. 你使用过哪些重要的Spring注解？
34. 我们可以发送一个Object作为Controller handler方法的响应吗？
35. Spring MVC应用怎样上传文件？
36. Spring Web MVC架构怎样验证表单数据？
37. Spring MVC拦截器（Interceptor）是什么？怎样使用？
38. Spring JdbcTemplate类是什么？怎样使用？
39. Spring Web应用中怎样使用Tomcat JNDI数据资源？
40. 在Spring中怎样实现事务管理？
41. Spring DAO是什么？
42. 怎样集成Spring和Hibernate框架？
43. Spring Security是什么？
44. 怎样注入一个java.util.Properties到Spring Bean？
45. Spring框架使用哪些设计模式？
46. Spring框架有些什么最佳实践？


## Spring面试问题及答案

### 1. Spring框架是什么？

Spring是使用最为广泛的Java企业级框架。 Spring框架是“依赖注入”和“面向切面编程”。

Spring框架可以用于一般的java应用中。通过依赖注入的实现不同组件中的松耦合，使用Spring支持的面向切面编程我们可以像日志和认证那样跨截面执行任务。

我喜欢Spring是因它提供了许多特性和不同的功能模块，如Spring MVC和Spring JDBC。由于它是开源的，有许多在线资源和活跃的社区，使用Spring框架，在相同的时间内，工作起来更加的容易和有趣。

### 2. Spring框架有些什么重要的特性和优势？

Spring框架是基于“依赖注入”和“面向切面编程”两个设计概念建立。

Spring框架有如下特性：  
* 对开发来讲使用该框架有极少的开销，且它是一个轻量级的框架。  
* 依赖注入和控制反转编写的组件是相互独立的，Spring容器负责一起装配组件，帮助实现我们的工作。  
* Spring IoC容器管理Spring Bean的生命周期和规划具体的配置，如JNDI查找。 
* Spring MVC框架可以用于创建web应用，也可以创建返回XML或JSON的web服务。 
* 只需要非常少的配置便能支持事务管理，JDBC操作，文件上传，异常处理等。配置你可以使用注解或者配置文件实现。

使用Spring框架有如下优势：  
* 减少在应用中两个不同组件的直接依赖，一般来说Spring IoC容器负责初始化资源或beans并注入它们的依赖。  
* 在Spring框架中写单元测试更加容易。因为业务逻辑不直接依赖实际的资源实现类。可以容易的编写测试配置和注入测试目的模拟的beans。  
* 减少了重复代码的数量，如初始化对象，打开或关闭资源。我很喜欢JdbcTemplate类，是因为它帮助我们移除了所有来自JDBC编程的重复代码。  
* Spring框架被分成多个模块，它帮助我们保证我们的应用变得轻量级。例如若不需要Spring事件管理特性，则可以不添加它的依赖到项目中。  
* Spring框架支持大部分Java企业级特性，甚至更多。它总是与时俱进，如它有Android的Spring项目，帮助我们写出更好的native android的应用。这些使得Spring框架更完整，不需要因为新需求再引入不同的框架。

### 3. 你对依赖注入的理解是什么？

依赖注入设计模式允许我们移除硬编码依赖，确保应用松耦合，可扩展，可维护。把依赖解析从编译时移动运行时，我们就能够实现依赖注入模式。

使用依赖注入有这些好处：分享了关注点，减少了重复代码，组件可配置和更易单元测试。

### 4. Spring框架中怎么样实现依赖注入？

在Spring应用中我们可以基于“Spring XML”以及“注解”配置实现依赖注入。更好的理解，请阅读[Spring依赖注入实例](https://www.journaldev.com/2410/spring-dependency-injection)。

### 5. 使用Spring工具套件有什么好处？

安装扫描件到Eclipse将获得更多Spring工具套件的特性。无论如何，Eclipse中的Spring工具套件有诸如Maven支持，创建不同Spring项目类型的模板和更好Spring应用性能的tc服务。

我喜欢Spring工具套件，是因为在使用AOP切入点（pointcuts）和APO通知（advices）时，高亮显示了这些Spring组件。它清楚的显示了哪个方法将来自指定的切入点。因此相较与安装每一件小工具，在开发Spring应用时，我更喜欢使用Spring工具套件。

### 6. 重要的Spring模块名称有哪些？

Spring框架一些重要的模块如下：  
* Spring Context – 用于依赖注入。  
* Spring AOP –用于面向切面编程。  
* Spring DAO – 用于DAO模式的数据操作。  
* Spring JDBC – 用于JDBC和数据的支持。  
* Spring ORM – 用于ORM工具的支持，如Hibernate。
* Spring Web Module – 用于创建web应用。
* Spring MVC – 为创建web应用，web服务等的MVC实现。

### 7. 你对面向切面编程的理解是什么？

企业级应用有一些对不同类型的对象和应用模块的公用横向关注点是合适必要的。例始日志，事务管理，数据验证，身份认证等。
在面向切面编程中，应用模块是通过类实现的。如AOP应用模块是通过配置在不同类的方法上的模向关注点Aspects实现的。

AOP从类中分离了横向关注点任务的直接依赖，这在一般的面向对象编程中是不可做到的。例如，你可以把日志从类中分离，但这个类不午不将要调用这些方法记录日志数据（AOP就不需要）。

### 8. AOP中的连接点（Joinpoint）, 切点（Pointcut），通知（Advice），引介（Introduction），切面（Aspect），织入（Weaving）是什么？

* 连接点（Joinpoint）
程序执行的某个特定位置：如类某个方法调用前、调用后、方法抛出异常后。一个类或一段程序代码拥有一些具有边界性质的特定点，这些点中的特定点就称为“连接点”。Spring仅支持方法的连接点，即仅能在方法调用前、方法调用后、方法抛出异常时以及方法调用前后这些程序执行点织入通知。连接点由两个信息确定：第一是用方法表示的程序执行点；第二是用相对点表示的方位。连接点是在应用执行过程中能够插入切面的一个点。

以查电表为例子：电力公司为多个住户提供服务，连接点就是每一家的电表所在的位置（类中的方法的调用前、调用后...）。

* 切点（Pointcut）
AOP通过“切点”定位特定的连接点。切点和连接点不是一对一的关系，一个切点可以匹配多个连接点。在Spring中，切点通过org.springframework.aop.Pointcut接口进行描述，它使用类和方法作为连接点的查询条件，Spring AOP的规则解析引擎负责切点所设定的查询条件，找到对应的连接点。其实确切地说，不能称之为查询连接点，因为连接点是方法执行前、执行后等包括方位信息的具体程序执行点，而切点只定位到某个方法上，所以如果希望定位到具体连接点上，还需要提供方位信息。

电力公司为每一个抄表员都分别指定某一块区域的住户。切点就是划分的区域。

* 通知（Advice）
切面的工作被称为通知。是织入到目标类连接点上的一段程序代码。
Spring切面可以应用5种类型的通知：
-前置通知（Before）：在目标方法被调用之前调用通知功能；
-后置通知（After）：在目标方法完成之后调用通知，此时不会关心方 法的输出是什么；
-返回通知（After-returning）：在目标方法成功执行之后调用通知；
-异常通知（After-throwing）：在目标方法抛出异常后调用通知；
-环绕通知（Around）：通知包裹了被通知的方法，在被通知的方法调 用之前和调用之后执行自定义的行为。

抄表员的本职工作是登记用电量，但他们还需要向电力公司汇报的信息。
登记用电量是目标对象，汇报的信息就是通知。 

* 引介（Introduction）  

引入允许我们向现有的类添加新方法或属性，是一种特殊的通知。这样，即使一个业务类原本没有实现某个接口，通过AOP的引介功能，我们可以动态地为该业务类添加接口的实现逻辑，让业务类成为这个接口的实现类。

* 切面（Aspect）

切面由切点和通知（引介）组成，它既包括了横切逻辑的定义，也包括了连接点的定义。

抄表员的开始一天的工作时，他要知道从哪些区域（切点）收集信息，从而进行汇报（通知）。

* 织入（Weaving）

织入是把切面应用到目标对象并创建新的代理对象的过程。
AOP有三种织入的方式：
a、编译期：切面在目标类编译时被织入。这种方式需要特殊的编译器。AspectJ的织入编译器就是以这种方式织入切面的。
b、类加载期：切面在目标类加载到JVM时被织入。这种方式需要特殊的类加载器（ClassLoader），它可以在目标类被引入应用之前增
强该目标类的字节码。AspectJ 5的加载时织入（load-time weaving，LTW）就支持以这种方式织入切面。
c、运行期：切面在应用运行的某个时刻被织入。一般情况下，在织入切面时，AOP容器会为目标对象动态地创建一个代理对象。Spring
AOP就是以这种方式织入切面的。

### 9. Spring AOP 和AspectJ AOP有什么区别？

AspectJ是面向方向的一个工业标准级实现，而Spring仅实现了一些案例的AOP。Spring AOP 和AspectJ AOP主要有以下区别：

* 相较与AspectJ，Spring AOP使用更简单，因为不需要担心织入（weaving）处理。 
* Spring AOP支持AspectJ 注解,因此你熟悉AspectJ，使用Spring AOP也是容易的。
* Spring AOP仅支持基于代理的AOP，因此它仅能应用到方法执行连接点上。AspectJ支持所有种类的切点。
* Spring AOP缺点之一是它通过Spring上下文仅能应用到beans创建时。

### 10. Spring IoC容器是什么？

控制反转（Inversion of Control）是在两对象依赖之间实现松耦合的机制。为了实现松耦合和在运行时对象的动态绑定，对象定义依赖是通过其他装配对象被注入的。Spring IoC容器是注入依赖到某个对象和待我们使用的一种程序。

Spring框架的IoC容器类由`org.springframework.beans`和`org.springframework.context`包组成。提供给我们多种不同的方式实现对象依赖的解耦。

一些常用的应用上下文实现如下：

* `AnnotationConfigApplicationContext`: 对于基于注角配置的独立java应用程序。
* `ClassPathXmlApplicationContext`: 对于基于XML配置的独立java应用程序。
* `FileSystemXmlApplicationContext`: 除xml配置可以在文件系统中的从任何地方加载之外，与`ClassPathXmlApplicationContext`类似。
* `AnnotationConfigWebApplicationContext` 和 `XmlWebApplicationContext`：对于web应用程序。

### 11. Spring Bean是什么？

Spring IoC容器初始化任何普通的java类被称为Spring Bean。我们使用Spring ApplicationContext得到Spring Bean实例.

Spring IoC容器管理Spring Bean生命周期，bean作用域并在bean中注入任何所需要的依赖关系。

### 12. Spring Bean配置文件的重要性是什么？

我们使用Spring Bean配置文件定义的所有beans将通过Spring Context初始化。在我们创建Spring ApplicationContext的实例时，它将读取spring bean xml文件和初始化所有的实例。一旦ApplicationContext初始化成功，我们就能够使用它得到不同的bean实例了。

除了Spring Bean配置外，该文件还包含Spring MVC拦截器，视图解析器和其他元素，以支持基于注释的配置。

### 13. 把一个类配置成Spring Bean有些什么不同方法？

有以下三种方案配置Spring Bean：

**XML 配置**: 这是非常受欢迎的配置方式，我们可以使用在context文件中的元素来配置Spring Bean。例如：
```xml
<bean name="myBean" class="com.journaldev.spring.beans.MyBean"></bean>
```
**基于Java的配置**：如果仅使用注释，则可以使用@Bean注释配置Spring Bean。 此注释与@Configuration类配合使用即配置成Spring bean。 示例配置如下：
```java
@Configuration
@ComponentScan(value="com.journaldev.spring.main")
public class MyConfiguration {

	@Bean
	public MyService getService(){
		return new MyService();
	}
}
```

为了从spring context得到这个bean，我们需要使用所以代码段：

```java
AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(
		MyConfiguration.class);
MyService service = ctx.getBean(MyService.class);
```

**基于注解的配置**：我们还可以使用@Component，@Service，@Repository和@Controller注释与类配置为spring bean。 对于这些，我们需要提供基本的包位置来扫描这些类。 例如：
```xml
<context:component-scan base-package="com.journaldev.spring" />
```

### 14. Spring Bean有些什么不同作用域？

Spring Beans定义了5种作用域。

**singleton**: 将为每个容器创建一个Bean的一个实例。 这是Spring bean的默认作用域。 在使用此作用域时，确保spring bean没有共享实例变量，否则可能导致数据不一致性问题，因为它不是线程安全的。
**prototype**: 每次请求bean时都会创建一个新的实例。
**request**: 这与prototype作用域相同，但它意在用于Web应用程序。 将为每个HTTP请求创建一个新的bean实例。该作用域仅在基于web的Spring上下文中才有效。该作用域仅在基于web的Spring上下文中才有效。
**session**: 将为容器的每个HTTP会话创建一个新的bean。该作用域仅在基于web的Spring上下文中才有效。
**global-session**: 这用于为Portlet应用程序创建全局会话bean。该作用域仅在Portlet上下文中才有效。
Spring框架是可扩展的，我们也可以创建我们自己的作用域，但是大多数时候，我们使用框架提供的作用域就够了。

要设置Spring bean作用域，我们可以在bean元素或@Scope注解中使用“scope”属性来进行基于注解的配置。

<a name="spring-bean-life-cycle"></a>
### 15. Spring Bean生命周期是什么？

Spring Beans通过Spring容器被初始化并所有依赖也被注入。在上下文多销毁时，所有初始化的beans也销毁。这在大多数情况下运行良好，但有时我们希望初始化其他资源或进行一些验证，然后才能使我们的bean准备被使用。Spring框架提供了对Spring bean中的初始化后和销毁前方法的支持。

我们可以通过两种方法来实现 - 通过在Spring bean配置中实现InitializingBean和DisposableBean接口或使用init-method和destroy-method属性。有关更多详细信息，请参阅[Spring Bean生命周期方法](https://www.journaldev.com/2637/spring-bean-life-cycle)。

### 16. 在Spring Bean中怎么获得ServletContext和ServletConfig对象

在Spring Bean中有两种方法获得容器指定的对象。

1. 实现Spring * Aware接口。对于这些ServletContextAware和ServletConfigAware接口，有关这些aware接口的完整示例，请阅读[Spring Aware Interfaces](https://www.journaldev.com/2637/spring-bean-life-cycle)。   
2. 使用@Autowired注释与类型为ServletContext和ServletConfig的Bean变量。 它们只能在servlet容器的特定环境中工作。 
```java
@Autowired
ServletContext servletContext;
```

### 17. Bean装配和@Autowired注解是什么？

spring bean依赖注入的处理，在初始化它时被称作spring bean装配。

通常来讲显示的装配所有的bean依赖是最佳实践，但spring框架也支持自动装配。我们也可以使用@Autowired注解和域或方法通过类型的方式自动装配。为了使此注解工作，我们还需要在spring bean配置文件中启用基于注释的配置。 这可以通过上下文来完成：annotation-config元素。

有关@Autowired注释的更多详细信息，请阅读[Spring Autowire示例](https://www.journaldev.com/2623/spring-autowired-annotation)。

### 18. Spring Bean自动装配有几种不同类型？

spring框架有4种类型的自动装配：

1. 据名称自动装配  
2. 据类型自动装配  
3. 据构造类自动装配  
4. 据@Autowired和@Qualifier注解自动装配
Prior to Spring 3.1, autowire by autodetect was also supported that was similar to autowire by constructor or byType. For more details about these options, please read Spring Bean Autowiring.

在Spring 3.1之前，据自动探测自动装配也被支持，它类似于构造器或按类型自动装配。有关这些选项的更多详细信息，请参阅[Spring Bean自动装配](https://www.journaldev.com/2623/spring-autowired-annotation)。

### 19. Spring Bean是线程安全的吗？

Spring bean的默认作用域是单例的，因此每个上下文只有一个实例。 这意味着所有类级别的变量在任何线程可以更新它，导致数据不一致。 因此，在默认模式下，spring bean不是线程安全的。

但是我们可以改变spring bean的作用域到request, prototype or session，在牺牲性能的基础上，来实现线程安全。 这是一个设计决策，并根据项目要求。

### 20. 在Spring MVC的Controller是什么？

就像MVC设计模式一样，Controller是负责处理所有客户端请求的类，并将它们分发到配置的资源去处理它。在Spring MVC中，org.springframework.web.servlet.DispatcherServlet是基于spring bean配置初始化上下文的前端控制器类。

Controller类负责根据请求映射来处理不同类型的客户端请求。 我们可以使用@Controller注解创建一个控制器类。 通常它与@RequestMapping注释一起使用来指定特定URI映射的处理程序方法。

### 21. 在Spring中 @Component, @Repository 和 @Service注解有什么区别？

`@Component`注解用于指示该类是一个组件。 当使用基于注解的配置时，这些类将自动检测并配置为bean被使用。

`@Controller`注解是一种特定类型的组件，用于MVC应用程序，大多与@RequestMapping注解一起使用。

`@Repository`注解用于指示组件用作存储库，以及用于存储/检索/搜索数据的机制。 我们可以使用DAO模式实现类应用此注解。

`@Service`注解用于表示该类是一个服务。 通常会提供一些服务的业务门面类使用该注解。

为了类可以自动检测到，我们可以使用任何以上注解，但不同的类型的注解被提供后，你可以轻松区分类的意图。

### 22. DispatcherServlet 和 ContextLoaderListener是什么？

`DispatcherServlet`是Spring MVC应用程序中的前台控制器，它加载spring bean配置文件并初始化配置的所有bean。 如果注解已启用，它还会扫描程序包和配置使用`@Component`，`@Controller`，`@Repository`或`@Service`注解的任何bean。

`ContextLoaderListener`是启动和关闭Spring的根`WebApplicationContext`的侦听器。 重要的功能是将`ApplicationContext`的生命周期与`ServletContext`的生命周期结合起来，并自动创建`ApplicationContext`。 我们可以跨越不同spring上下文中,使用它定义共享bean。

### 23. 在Spring中的ViewResolver是什么？

`ViewResolver`实现被用于按名称解析视图页面。 通常我们在spring bean配置文件中配置它。 例如：
```xml
<!-- Resolves views selected for rendering by @Controllers to .jsp resources in the /WEB-INF/views directory -->
<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	<beans:property name="prefix" value="/WEB-INF/views/" />
	<beans:property name="suffix" value=".jsp" />
</beans:bean>
```
`InternalResourceViewResolver`是`ViewResolver`接口的实现之一，我们通过bean属性提供了view pages目录和后缀位置。 因此，如果控制器处理程序方法返回“home”，则视图解析器将使用位于/WEB-INF/views/home.jsp的视图页面。

### 24. MultipartResolver是什么？什么时候使用？

`MultipartResolver`接口用于上传文件 - `CommonsMultipartResolver`和`StandardServletMultipartResolver`是由spring框架提供的用于文件上传的两个实现。 默认情况下，没有配置多部分解析器，但是要使用它们来上传文件，我们需要在spring bean配置中定义一个名为“multipartResolver”的bean，其类型为MultipartResolver。

一旦配置完成后，任何多部分请求将由配置的`MultipartResolver`解析，并传递一个包装的`HttpServletRequest`。 然后在控制器类中使用它来获取文件并处理它。 这里提供一个完整的例子，请阅读[Spring MVC文件上传示例](https://www.journaldev.com/2573/spring-mvc-file-upload-example-single-multiple-files)。

### 25. Spring MVC框架怎样处理异常？

Spring MVC框架提供了以下方法来帮助我们实现强大的异常处理。

1. **基于控制器** - 我们可以在控制器类中定义异常处理程序方法。 我们需要的是使用@ExceptionHandler注解来注解这些方法。
2. **全局异常处理程序** - 异常处理是一个横切关注的问题，Spring提供了`@ControllerAdvice`注解，让我们可以使用任何类来定义我们的全局异常处理程序。  
3. **`HandlerExceptionResolver`实现** - 对于一般异常，大多数时候我们提供静态页面。 Spring Framework提供了`HandlerExceptionResolver`接口，我们可以实现这个接口来创建全局异常处理程序。 这种额外的方法来定义全局异常处理程序的原因是Spring框架还提供了我们可以在spring bean配置文件中定义的默认实现类，以获得Spring框架异常处理的好处。

有关完整的示例，请参阅[Spring异常处理](https://www.journaldev.com/2651/spring-mvc-exception-handling-controlleradvice-exceptionhandler-handlerexceptionresolver)示例。

### 26. 在Java程序中怎样创建ApplicationContext？

在独立的java程序中创建`ApplicationContext`有以下几种方法。

1. **`AnnotationConfigApplicationContext`**：如果我们在独立的Java应用程序中使用Spring，并使用注解进行配置，那么我们可以使用它来初始化容器并获取bean对象。  
2. **`ClassPathXmlApplicationContext`**：如果我们在独立应用程序中有spring bean配置xml文件，那么我们可以使用此类来加载文件并获取容器对象。  
3. **`FileSystemXmlApplicationContext`**：类似于`ClassPathXmlApplicationContext`，除了可以从文件系统中的任何位置之外的任何地方加载xml配置文件。 

### 27. 能有多个Spring配置文件吗？

对于Spring MVC应用程序，我们可以通过contextConfigLocation定义多个Spring上下文配置文件。 该位置字符串可以由多个位置组成，并以任意数量的逗号和空格分隔。 例如;
```xml
<servlet>
	<servlet-name>appServlet</servlet-name>
	<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
	<init-param>
            <param-name>contextConfigLocation</param-name>
	    <param-value>/WEB-INF/spring/appServlet/servlet-context.xml,/WEB-INF/spring/appServlet/servlet-jdbc.xml</param-value>
	</init-param>
	<load-on-startup>1</load-on-startup>
</servlet>
```
我们还可以定义多个根级Spring配置，并通过上下文参数加载它们。 例如;
```xml
<context-param>
	<param-name>contextConfigLocation</param-name>
	<param-value>/WEB-INF/spring/root-context.xml /WEB-INF/spring/root-security.xml</param-value>
</context-param>
```
另一个选择是在上下文配置文件中使用import元素来导入其他配置，例如：
```xml
<beans:import resource="spring-jdbc.xml"/>
```

### 28. ContextLoaderListener是什么？

ContextLoaderListener是用于加载根上下文的侦听器类，并定义将对所有其他上下文可见的spring bean配置。 它在web.xml文件中配置为：
```xml
<context-param>
	<param-name>contextConfigLocation</param-name>
	<param-value>/WEB-INF/spring/root-context.xml</param-value>
</context-param>
	
<listener>
	<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
```

### 29. 为了创建Spring MVC应用，至少需要配置什么？

要创建一个简单的Spring MVC应用程序，我们需要执行以下任务。
1. 在项目中添加spring-context和spring-webmvc依赖项。
2. 在web.xml文件中配置DispatcherServlet，以通过spring容器处理请求。
3. Spring bean配置文件来定义bean，如果使用注解，那么必须在这里配置。 此外，我们还需要为视图页面配置视图解析器。
4. 控制器类与请求映射定义为处理客户端请求。
以上步骤应该足以创建一个简单的Spring MVC Hello World应用程序。

<a name="spring-mvc-architecture"></a>

### 30. 相对与MVC架构，你对Spring MVC框架的理解是怎样的？

正如名称所示，Spring MVC建立在Model-View-Controller架构之上。 DispatcherServlet是Spring MVC应用程序中的前端控制器，负责处理所有传入的请求并将其委托给不同的控制器处理程序方法。

模型可以是Spring框架中的任何Java Bean，就像任何其他MVC框架Spring一样，提供了将表单数据自动绑定到java bean。 我们可以将模型bean设置为在视图页面中使用的属性。

查看页面可以是JSP，静态HTML等，视图解析器负责查找正确的视图页面。 一旦查看页面被识别到，控制将返回给DispatcherServlet控制器。 DispatcherServlet负责呈现视图，并向客户端返回最终响应。

### 31. Spring MVC应用怎样实现本地化？

Spring通过资源包为本地化或i18n提供了极好的支持。 使我们的应用程序本地化所需的基本步骤是：

1. 为不同的区域设置创建消息资源束，如messages_en.properties，messages_fr.properties等。
2. 在`ResourceBundleMessageSource`或`ReloadableResourceBundleMessageSource`类型的spring bean配置文件中定义messageSource bean。
3. 要更改区域设置支持，请定义类型为CookieLocaleResolver的localeResolver bean并配置LocaleChangeInterceptor拦截器。
示例配置可以如下所示：
```xml
<beans:bean id="messageSource"
class="org.springframework.context.support.ReloadableResourceBundleMessageSource">
<beans:property name="basename" value="classpath:messages" />
<beans:property name="defaultEncoding" value="UTF-8" />
</beans:bean>
 
<beans:bean id="localeResolver"
    class="org.springframework.web.servlet.i18n.CookieLocaleResolver">
    <beans:property name="defaultLocale" value="en" />
    <beans:property name="cookieName" value="myAppLocaleCookie"></beans:property>
    <beans:property name="cookieMaxAge" value="3600"></beans:property>
</beans:bean>
 
<interceptors>
    <beans:bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <beans:property name="paramName" value="locale" />
    </beans:bean>
</interceptors>
```

4. 在具有键名称的视图页面中使用spring:message元素，DispatcherServlet选择相应的值，并将页面呈现在相应的区域设置中，并作为响应返回。

有关完整的示例，请阅读[Spring本地化](https://www.journaldev.com/2610/spring-mvc-internationalization-i18n-and-localization-l10n-example)示例 。

### 32. 使用Spring怎样创建Restful Web服务并返回JSON？

我们可以使用Spring Framework创建返回JSON数据的Restful Web服务。 Spring提供与[Jackson JSON](https://www.journaldev.com/2324/jackson-json-java-parser-api-example-tutorial) API的集成，我们可以使用它在安静的Web服务中发送JSON响应。

我们需要执行以下步骤来配置我们的Spring MVC应用程序以发送JSON响应：
1. 添加Jackson JSON依赖项，如果您使用Maven，可以使用以下代码：
```xml
<!-- Jackson -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>${jackson.databind-version}</version>
</dependency>
```
2. 在Spring bean配置文件中配置RequestMappingHandlerAdapter bean，并将messageConverters属性设置为MappingJackson2HttpMessageConverter bean。 样品配置将是：
```xml
<!-- Configure to plugin JSON as request and response in method handler -->
<beans:bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter">
    <beans:property name="messageConverters">
        <beans:list>
            <beans:ref bean="jsonMessageConverter"/>
        </beans:list>
    </beans:property>
</beans:bean>

<!-- Configure bean to convert JSON to POJO and vice versa -->
<beans:bean id="jsonMessageConverter" class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter">
</beans:bean>
```
3. 在控制器处理程序方法中，使用@ResponseBody注释返回Object作为响应。 示例代码：
```java
@RequestMapping(value = EmpRestURIConstants.GET_EMP, method = RequestMethod.GET)
public @ResponseBody Employee getEmployee(@PathVariable("id") int empId) {
    logger.info("Start getEmployee. ID="+empId);
     
    return empData.get(empId);
}
```
4. 您可以通过任何API调用其余服务，但是如果要使用Spring，那么我们可以使用RestTemplate类来轻松实现。
有关一个完整的例子，请阅读[Spring Restful Webservice](https://www.journaldev.com/2552/spring-rest-example-tutorial-spring-restful-web-services)示例 。

### 33. 你使用过哪些重要的Spring注解？

我在项目中使用的一些Spring注解是：

**@Controller** - 用于Spring MVC项目中的控制器类。
**@RequestMapping** - 用于在控制器处理程序方法中配置URI映射。 这是一个非常重要的注释。
**@ResponseBody** - 用于发送Object作为响应，通常用于发送XML或JSON数据作为响应。
**@PathVariable** - 用于将动态值从URI映射到处理程序方法参数。
**@Autowired** - 用于spring bean的自动装配依赖。
**@Qualifier** - 与@Autowired注解一起使用，以避免多个Bean类型的实例存在混淆。
**@Service** - 用于服务类。
**@Scope** - 用于配置spring bean的作用域。
**@Configuration**， **@ComponentScan**和**@Bean** - 用于基于Java的配置。
用于配置切面和通知的AspectJ注解， **@Aspect** ， **@Before** ， **@After** ， **@Around** ， **@Pointcut**等。

### 34. 我们可以发送一个Object作为Controller handler方法的响应吗？

可以，我们可以使用@ResponseBody注解。 这就是我们如何在restful的Web服务中发送基于JSON或XML的响应。

### 35. Spring MVC应用怎样上传文件？

Spring提供内置的支持，可通过MultipartResolver接口实现上传文件。 它非常易于使用，只需要配置更改才能使其正常工作。 显然，我们需要编写控制器处理程序方法来处理传入的文件并进行处理。 有关完整的示例，请参阅[Spring文件上传](https://www.journaldev.com/2573/spring-mvc-file-upload-example-single-multiple-files)示例 。

### 36. Spring Web MVC架构怎样验证表单数据？

Spring支持基于JSR-303注释的验证，并提供我们可以实现的Validator接口来创建我们自己的自定义验证器。 对于使用基于JSR-303的验证，我们需要使用所需的验证来注释bean变量。

对于自定义验证器实现，我们需要在controller类中进行配置。 有关完整的示例，请参阅[Spring MVC表单验证](https://www.journaldev.com/2668/spring-validation-example-mvc-validator)示例 。

### 37. Spring MVC拦截器（Interceptor）是什么？怎样使用？

Spring MVC拦截器就像Servlet过滤器，允许我们拦截客户端请求并处理它。 我们可以在三个地方拦截客户端请求 - **preHandle** ， **postHandle**和**afterCompletion** 。

我们可以通过实现HandlerInterceptor接口或扩展抽象类HandlerInterceptorAdapter来创建spring拦截器。

我们需要在spring bean配置文件中配置拦截器。 我们可以定义拦截器来拦截所有的客户端请求，也可以为特定的URI映射进行配置。 有关详细的示例，请参考[Spring MVC拦截器](https://www.journaldev.com/2676/spring-mvc-interceptor-example-handlerinterceptor-handlerinterceptoradapter)示例 。

### 38. Spring JdbcTemplate类是什么？怎样使用？

Spring Framework提供与JDBC API的良好集成，并提供JdbcTemplate实用程序类，我们可以使用它来避免数据库操作逻辑（如打开/关闭连接，ResultSet，PreparedStatement等）的bolier-plate代码。

对于JdbcTemplate示例，请参考[Spring JDBC](https://www.journaldev.com/2593/spring-jdbc-example)示例 。

### 39. Spring Web应用中怎样使用Tomcat JNDI数据资源？

对于使用servlet容器配置的JNDI DataSource，我们需要在spring bean配置文件中进行配置，然后将其注入spring beans作为依赖关系。 然后我们可以使用它与JdbcTemplate来执行数据库操作。

示例配置如下：
```xml
<beans:bean id="dbDataSource" class="org.springframework.jndi.JndiObjectFactoryBean">
    <beans:property name="jndiName" value="java:comp/env/jdbc/MyLocalDB"/>
</beans:bean>
```
有关完整的例子，请参考[Spring Tomcat JNDI](https://www.journaldev.com/2597/spring-datasource-jndi-with-tomcat-example)示例 。

### 40. 在Spring中怎样实现事务管理？

Spring框架通过声明式事务管理以及编程式事务管理来提供事务管理支持。 声明式事务管理被广泛使用，因为它在大多数情况下易于使用和工作。

我们使用@Transactional注释的注释方法进行声明式事务管理。 我们需要在Spring bean配置文件中为DataSource配置事务管理器。
```xml
<bean id="transactionManager"
    class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="dataSource" />
</bean>
```

### 41. Spring DAO是什么？

提供Spring DAO支持，以一致和简单的方式处理JDBC，Hibernate等数据访问技术。 例如，对于各自的技术，我们有`JdbcDaoSupport` ， `HibernateDaoSupport` ， `JdoDaoSupport`和`JpaDaoSupport` 。

Spring DAO还提供了异常层次结构的一致性，我们不需要捕获特定的异常。

### 42. 怎样集成Spring和Hibernate框架？

我们可以使用Spring ORM模块来集成Spring和Hibernate框架，如果您正在使用Hibernate 3+，SessionFactory提供当前会话，那么您应该避免使用`HibernateTemplate`或`HibernateDaoSupport`类，并更好地使用依赖注入的DAO模式进行集成。

Spring ORM还提供对使用Spring声明性事务管理的支持，所以您应该利用这一点，而不是使用hibernate的锅炉代码进行事务管理。

为了更好地理解，您应该请阅读以下教程：

[Spring Hibernate集成](https://www.journaldev.com/3524/spring-hibernate-integration-example-tutorial)示例
[Spring MVC Hibernate集成](https://www.journaldev.com/3531/spring-mvc-hibernate-mysql-integration-crud-example-tutorial)示例

### 43. Spring Security是什么？

Spring Security框架关注的焦点是在java应用程序中提供身份验证和授权。 它解决了大多数常见的安全漏洞问题，如CSRF攻击。

通过使用注解,如@EnableWebSecurity ，在Web应用程序中使用Spring Security是很有好处的且易于使用。 您应该通过以下文章来了解如何使用Spring Security框架。

[Servlet Web应用程序中的Spring Security](https://www.journaldev.com/2715/spring-security-example-tutorial)
[Spring MVC和Spring Security集成](https://www.journaldev.com/2736/spring-security-example-userdetailsservice)示例

### 44. 怎样注入一个java.util.Properties到Spring Bean？

我们需要定义propertyConfigurer bean，该bean将从给定的属性文件加载属性。 然后我们可以使用Spring EL支持将属性注入其他bean依赖关系。 例如;
```xml
<bean id="propertyConfigurer" 
  class="org.springframework.context.support.PropertySourcesPlaceholderConfigurer">
    <property name="location" value="/WEB-INF/application.properties" />
</bean> 

<bean class="com.journaldev.spring.EmployeeDaoImpl">
    <property name="maxReadResults" value="${results.read.max}"/>
</bean>
 ```
如果您使用注解来配置spring bean，则可以像下面那样注入属性。
```java
@Value("${maxReadResults}") 
private int maxReadResults;
 ```

### 45. Spring框架使用哪些设计模式？

Spring框架正在使用很多设计模式，其中一些常见的是：

1. 单例模式：创建具有默认范围的bean。
2. 工厂模式 ：Bean Factory类
3. 原型模式 ：Bean作用域
4. 适配器模式 ：Spring Web和Spring MVC
5. 代理模式 ：Spring Aspect面向编程支持
6. 模板方法模式 ：JdbcTemplate，HibernateTemplate等
7. 前端控制器：Spring MVC DispatcherServlet
8. 数据访问对象：Spring DAO支持
9. 依赖注入和面向方面的编程

### 46. Spring框架有些什么最佳实践？

Spring Framework的一些最佳实践是：
1. 避免模​​式引用中的版本号，以确保我们有最新的配置。
2. 根据spring-jdbc.xml，spring-security.xml等关注的问题来分隔spring bean配置。
3. 对于在Spring MVC中的多个上下文中使用的spring bean，在根上下文中创建它们并使用listener进行初始化。
4. 尽可能多地配置bean依赖关系，尽量避免自动装配。
5. 对于应用程序级属性，最佳方法是创建一个属性文件，并在spring bean配置文件中读取它。
6. 对于较小的应用程序，注解是有用的，但对于较大的应用程序注解可能会变得很痛苦。 如果我们在xml文件中有所有配置，维护它将会更容易。
7. 为组件使用正确的注解，轻松了解其意图。 对于服务，使用@Service和DAO bean使用@Repository。
8. Spring框架有很多模块，使用你需要的。 删除通过Spring Tool Suite模板创建项目时添加的所有额外的依赖项。
9. 如果您正在使用Aspects，请确保连接点范围尽可能的窄，以避免对不需要的方法的发送通知。 考虑更容易使用的自定义注解，可以避免任何问题。
10. 当有实际利益时，使用依赖注入，只是为了松散耦合而不使用它，因为它更难维护。

这就是Spring Framework面试的问题。 我希望这些问题能帮助您进行Java EE面试。 一旦有新的面试问题我将即时更新！

=======
---
title: Spring面试问题
tags: java,spring,interview,面试
categories: 
  - java

thumbnail: /gallery/blue-water6.jpg
---


Spring框架是最受欢迎的Java企业级web应用框架。*依赖注入*和*面象方面*是*Spring框架*的核心。
<!-- more -->

我最近提交了许多[Spring教程](https://www.journaldev.com/2888/spring-tutorial-spring-core-tutorial)，它将有助于帮你详细的解释Spring面试问题的核心概念。

## Spring面试问题列表

1. Spring框架是什么？
2. Spring框架有些什么重要的特性和优势？
3. 你对依赖注入的理解是什么？
4. Spring框架中怎么样实现依赖注入？
5. 使用Spring工具套件有什么好处？
6. 重要的Spring模块名称有哪些？
7. 你对面向切面编程的理解是什么？
8. AOP中的Aspect, Advice, Pointcut, JointPoint and Advice Arguments是什么？
9. Spring AOP 和AspectJ AOP有什么区别？
10. Spring IoC容器是什么？
11. Spring Bean是什么？
12. Spring Bean配置文件的重要性是什么？
13. 把一个类配置成Spring Bean有些什么不同方法？
14. Spring Bean有些什么不同作用域？
15. [Spring Bean生命周期是什么？](#spring-bean-life-cycle)
16. 在Spring Bean中怎么获得ServletContext和ServletConfig对象
17. Bean装配和@Autowired注解是什么？
18. Spring Bean自动装配有几种不同类型？
19. Spring Bean是线程安全的吗？
20. 在Spring MVC的Controller是什么？
21. 在Spring中 @Component, @Repository 和 @Service注解有什么区别？
22. DispatcherServlet 和 ContextLoaderListener是什么？
23. 在Spring中的ViewResolver是什么？
24. MultipartResolver是什么？什么时候使用？
25. Spring MVC框架怎样处理异常？
26. 在Java程序中怎样创建ApplicationContext？
27. 能有多个Spring配置文件吗？
28. ContextLoaderListener是什么？
29. 为了创建Spring MVC应用，至少需要配置什么？
30. [相对与MVC架构，你对Spring MVC框架的理解是怎样的？](#spring-mvc-architecture)
31. Spring MVC应用怎样实现平地化？
32. 使用Spring怎样创建Restful Web服务并返回JSON？
33. 你使用过哪些重要的Spring注解？
34. 我们可以发送一个Object作为Controller handler方法的响应吗？
35. Spring MVC应用怎样上传文件？
36. Spring Web MVC架构怎样验证表单数据？
37. Spring MVC拦截器（Interceptor）是什么？怎样使用？
38. Spring JdbcTemplate类是什么？怎样使用？
39. Spring Web应用中怎样使用Tomcat JNDI数据资源？
40. 在Spring中怎样实现事务管理？
41. Spring DAO是什么？
42. 怎样集成Spring和Hibernate框架？
43. Spring Security是什么？
44. 怎样注入一个java.util.Properties到Spring Bean？
45. Spring框架使用哪些设计模式？
46. Spring框架有些什么最佳实践？


## Spring面试问题及答案

### 1. Spring框架是什么？

Spring是使用最为广泛的Java企业级框架。 Spring框架是“依赖注入”和“面向切面编程”。

Spring框架可以用于一般的java应用中。通过依赖注入的实现不同组件中的松耦合，使用Spring支持的面向切面编程我们可以像日志和认证那样跨截面执行任务。

我喜欢Spring是因它提供了许多特性和不同的功能模块，如Spring MVC和Spring JDBC。由于它是开源的，有许多在线资源和活跃的社区，使用Spring框架，在相同的时间内，工作起来更加的容易和有趣。

### 2. Spring框架有些什么重要的特性和优势？

Spring框架是基于“依赖注入”和“面向切面编程”两个设计概念建立。

Spring框架有如下特性：  
* 对开发来讲使用该框架有极少的开销，且它是一个轻量级的框架。  
* 依赖注入和控制反转编写的组件是相互独立的，Spring容器负责一起装配组件，帮助实现我们的工作。  
* Spring IoC容器管理Spring Bean的生命周期和规划具体的配置，如JNDI查找。 
* Spring MVC框架可以用于创建web应用，也可以创建返回XML或JSON的web服务。 
* 只需要非常少的配置便能支持事务管理，JDBC操作，文件上传，异常处理等。配置你可以使用注解或者配置文件实现。

使用Spring框架有如下优势：  
* 减少在应用中两个不同组件的直接依赖，一般来说Spring IoC容器负责初始化资源或beans并注入它们的依赖。  
* 在Spring框架中写单元测试更加容易。因为业务逻辑不直接依赖实际的资源实现类。可以容易的编写测试配置和注入测试目的模拟的beans。  
* 减少了重复代码的数量，如初始化对象，打开或关闭资源。我很喜欢JdbcTemplate类，是因为它帮助我们移除了所有来自JDBC编程的重复代码。  
* Spring框架被分成多个模块，它帮助我们保证我们的应用变得轻量级。例如若不需要Spring事件管理特性，则可以不添加它的依赖到项目中。  
* Spring框架支持大部分Java企业级特性，甚至更多。它总是与时俱进，如它有Android的Spring项目，帮助我们写出更好的native android的应用。这些使得Spring框架更完整，不需要因为新需求再引入不同的框架。

### 3. 你对依赖注入的理解是什么？

依赖注入设计模式允许我们移除硬编码依赖，确保应用松耦合，可扩展，可维护。把依赖解析从编译时移动运行时，我们就能够实现依赖注入模式。

使用依赖注入有这些好处：分享了关注点，减少了重复代码，组件可配置和更易单元测试。

### 4. Spring框架中怎么样实现依赖注入？

在Spring应用中我们可以基于“Spring XML”以及“注解”配置实现依赖注入。更好的理解，请阅读[Spring依赖注入实例](https://www.journaldev.com/2410/spring-dependency-injection)。

### 5. 使用Spring工具套件有什么好处？

安装扫描件到Eclipse将获得更多Spring工具套件的特性。无论如何，Eclipse中的Spring工具套件有诸如Maven支持，创建不同Spring项目类型的模板和更好Spring应用性能的tc服务。

我喜欢Spring工具套件，是因为在使用AOP切入点（pointcuts）和APO通知（advices）时，高亮显示了这些Spring组件。它清楚的显示了哪个方法将来自指定的切入点。因此相较与安装每一件小工具，在开发Spring应用时，我更喜欢使用Spring工具套件。

### 6. 重要的Spring模块名称有哪些？

Spring框架一些重要的模块如下：  
* Spring Context – 用于依赖注入。  
* Spring AOP –用于面向切面编程。  
* Spring DAO – 用于DAO模式的数据操作。  
* Spring JDBC – 用于JDBC和数据的支持。  
* Spring ORM – 用于ORM工具的支持，如Hibernate。
* Spring Web Module – 用于创建web应用。
* Spring MVC – 为创建web应用，web服务等的MVC实现。

### 7. 你对面向切面编程的理解是什么？

企业级应用有一些对不同类型的对象和应用模块的公用横向关注点是合适必要的。例始日志，事务管理，数据验证，身份认证等。
在面向切面编程中，应用模块是通过类实现的。如AOP应用模块是通过配置在不同类的方法上的模向关注点Aspects实现的。

AOP从类中分离了横向关注点任务的直接依赖，这在一般的面向对象编程中是不可做到的。例如，你可以把日志从类中分离，但这个类不午不将要调用这些方法记录日志数据（AOP就不需要）。

### 8. AOP中的连接点（Joinpoint）, 切点（Pointcut），通知（Advice），引介（Introduction），切面（Aspect），织入（Weaving）是什么？

* 连接点（Joinpoint）
程序执行的某个特定位置：如类某个方法调用前、调用后、方法抛出异常后。一个类或一段程序代码拥有一些具有边界性质的特定点，这些点中的特定点就称为“连接点”。Spring仅支持方法的连接点，即仅能在方法调用前、方法调用后、方法抛出异常时以及方法调用前后这些程序执行点织入通知。连接点由两个信息确定：第一是用方法表示的程序执行点；第二是用相对点表示的方位。连接点是在应用执行过程中能够插入切面的一个点。

以查电表为例子：电力公司为多个住户提供服务，连接点就是每一家的电表所在的位置（类中的方法的调用前、调用后...）。

* 切点（Pointcut）
AOP通过“切点”定位特定的连接点。切点和连接点不是一对一的关系，一个切点可以匹配多个连接点。在Spring中，切点通过org.springframework.aop.Pointcut接口进行描述，它使用类和方法作为连接点的查询条件，Spring AOP的规则解析引擎负责切点所设定的查询条件，找到对应的连接点。其实确切地说，不能称之为查询连接点，因为连接点是方法执行前、执行后等包括方位信息的具体程序执行点，而切点只定位到某个方法上，所以如果希望定位到具体连接点上，还需要提供方位信息。

电力公司为每一个抄表员都分别指定某一块区域的住户。切点就是划分的区域。

* 通知（Advice）
切面的工作被称为通知。是织入到目标类连接点上的一段程序代码。
Spring切面可以应用5种类型的通知：
-前置通知（Before）：在目标方法被调用之前调用通知功能；
-后置通知（After）：在目标方法完成之后调用通知，此时不会关心方 法的输出是什么；
-返回通知（After-returning）：在目标方法成功执行之后调用通知；
-异常通知（After-throwing）：在目标方法抛出异常后调用通知；
-环绕通知（Around）：通知包裹了被通知的方法，在被通知的方法调 用之前和调用之后执行自定义的行为。

抄表员的本职工作是登记用电量，但他们还需要向电力公司汇报的信息。
登记用电量是目标对象，汇报的信息就是通知。 

* 引介（Introduction）  

引入允许我们向现有的类添加新方法或属性，是一种特殊的通知。这样，即使一个业务类原本没有实现某个接口，通过AOP的引介功能，我们可以动态地为该业务类添加接口的实现逻辑，让业务类成为这个接口的实现类。

* 切面（Aspect）

切面由切点和通知（引介）组成，它既包括了横切逻辑的定义，也包括了连接点的定义。

抄表员的开始一天的工作时，他要知道从哪些区域（切点）收集信息，从而进行汇报（通知）。

* 织入（Weaving）

织入是把切面应用到目标对象并创建新的代理对象的过程。
AOP有三种织入的方式：
a、编译期：切面在目标类编译时被织入。这种方式需要特殊的编译器。AspectJ的织入编译器就是以这种方式织入切面的。
b、类加载期：切面在目标类加载到JVM时被织入。这种方式需要特殊的类加载器（ClassLoader），它可以在目标类被引入应用之前增
强该目标类的字节码。AspectJ 5的加载时织入（load-time weaving，LTW）就支持以这种方式织入切面。
c、运行期：切面在应用运行的某个时刻被织入。一般情况下，在织入切面时，AOP容器会为目标对象动态地创建一个代理对象。Spring
AOP就是以这种方式织入切面的。

### 9. Spring AOP 和AspectJ AOP有什么区别？

AspectJ是面向方向的一个工业标准级实现，而Spring仅实现了一些案例的AOP。Spring AOP 和AspectJ AOP主要有以下区别：

* 相较与AspectJ，Spring AOP使用更简单，因为不需要担心织入（weaving）处理。 
* Spring AOP支持AspectJ 注解,因此你熟悉AspectJ，使用Spring AOP也是容易的。
* Spring AOP仅支持基于代理的AOP，因此它仅能应用到方法执行连接点上。AspectJ支持所有种类的切点。
* Spring AOP缺点之一是它通过Spring上下文仅能应用到beans创建时。

### 10. Spring IoC容器是什么？

控制反转（Inversion of Control）是在两对象依赖之间实现松耦合的机制。为了实现松耦合和在运行时对象的动态绑定，对象定义依赖是通过其他装配对象被注入的。Spring IoC容器是注入依赖到某个对象和待我们使用的一种程序。

Spring框架的IoC容器类由`org.springframework.beans`和`org.springframework.context`包组成。提供给我们多种不同的方式实现对象依赖的解耦。

一些常用的应用上下文实现如下：

* `AnnotationConfigApplicationContext`: 对于基于注角配置的独立java应用程序。
* `ClassPathXmlApplicationContext`: 对于基于XML配置的独立java应用程序。
* `FileSystemXmlApplicationContext`: 除xml配置可以在文件系统中的从任何地方加载之外，与`ClassPathXmlApplicationContext`类似。
* `AnnotationConfigWebApplicationContext` 和 `XmlWebApplicationContext`：对于web应用程序。

### 11. Spring Bean是什么？

Spring IoC容器初始化任何普通的java类被称为Spring Bean。我们使用Spring ApplicationContext得到Spring Bean实例.

Spring IoC容器管理Spring Bean生命周期，bean作用域并在bean中注入任何所需要的依赖关系。

### 12. Spring Bean配置文件的重要性是什么？

我们使用Spring Bean配置文件定义的所有beans将通过Spring Context初始化。在我们创建Spring ApplicationContext的实例时，它将读取spring bean xml文件和初始化所有的实例。一旦ApplicationContext初始化成功，我们就能够使用它得到不同的bean实例了。

除了Spring Bean配置外，该文件还包含Spring MVC拦截器，视图解析器和其他元素，以支持基于注释的配置。

### 13. 把一个类配置成Spring Bean有些什么不同方法？

有以下三种方案配置Spring Bean：

**XML 配置**: 这是非常受欢迎的配置方式，我们可以使用在context文件中的元素来配置Spring Bean。例如：
```xml
<bean name="myBean" class="com.journaldev.spring.beans.MyBean"></bean>
```
**基于Java的配置**：如果仅使用注释，则可以使用@Bean注释配置Spring Bean。 此注释与@Configuration类配合使用即配置成Spring bean。 示例配置如下：
```java
@Configuration
@ComponentScan(value="com.journaldev.spring.main")
public class MyConfiguration {

	@Bean
	public MyService getService(){
		return new MyService();
	}
}
```

为了从spring context得到这个bean，我们需要使用所以代码段：

```java
AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(
		MyConfiguration.class);
MyService service = ctx.getBean(MyService.class);
```

**基于注解的配置**：我们还可以使用@Component，@Service，@Repository和@Controller注释与类配置为spring bean。 对于这些，我们需要提供基本的包位置来扫描这些类。 例如：
```xml
<context:component-scan base-package="com.journaldev.spring" />
```

### 14. Spring Bean有些什么不同作用域？

Spring Beans定义了5种作用域。

**singleton**: 将为每个容器创建一个Bean的一个实例。 这是Spring bean的默认作用域。 在使用此作用域时，确保spring bean没有共享实例变量，否则可能导致数据不一致性问题，因为它不是线程安全的。
**prototype**: 每次请求bean时都会创建一个新的实例。
**request**: 这与prototype作用域相同，但它意在用于Web应用程序。 将为每个HTTP请求创建一个新的bean实例。该作用域仅在基于web的Spring上下文中才有效。该作用域仅在基于web的Spring上下文中才有效。
**session**: 将为容器的每个HTTP会话创建一个新的bean。该作用域仅在基于web的Spring上下文中才有效。
**global-session**: 这用于为Portlet应用程序创建全局会话bean。该作用域仅在Portlet上下文中才有效。
Spring框架是可扩展的，我们也可以创建我们自己的作用域，但是大多数时候，我们使用框架提供的作用域就够了。

要设置Spring bean作用域，我们可以在bean元素或@Scope注解中使用“scope”属性来进行基于注解的配置。

<a name="spring-bean-life-cycle"></a>
### 15. Spring Bean生命周期是什么？

Spring Beans通过Spring容器被初始化并所有依赖也被注入。在上下文多销毁时，所有初始化的beans也销毁。这在大多数情况下运行良好，但有时我们希望初始化其他资源或进行一些验证，然后才能使我们的bean准备被使用。Spring框架提供了对Spring bean中的初始化后和销毁前方法的支持。

我们可以通过两种方法来实现 - 通过在Spring bean配置中实现InitializingBean和DisposableBean接口或使用init-method和destroy-method属性。有关更多详细信息，请参阅[Spring Bean生命周期方法](https://www.journaldev.com/2637/spring-bean-life-cycle)。

### 16. 在Spring Bean中怎么获得ServletContext和ServletConfig对象

在Spring Bean中有两种方法获得容器指定的对象。

1. 实现Spring * Aware接口。对于这些ServletContextAware和ServletConfigAware接口，有关这些aware接口的完整示例，请阅读[Spring Aware Interfaces](https://www.journaldev.com/2637/spring-bean-life-cycle)。   
2. 使用@Autowired注释与类型为ServletContext和ServletConfig的Bean变量。 它们只能在servlet容器的特定环境中工作。 
```java
@Autowired
ServletContext servletContext;
```

### 17. Bean装配和@Autowired注解是什么？

spring bean依赖注入的处理，在初始化它时被称作spring bean装配。

通常来讲显示的装配所有的bean依赖是最佳实践，但spring框架也支持自动装配。我们也可以使用@Autowired注解和域或方法通过类型的方式自动装配。为了使此注解工作，我们还需要在spring bean配置文件中启用基于注释的配置。 这可以通过上下文来完成：annotation-config元素。

有关@Autowired注释的更多详细信息，请阅读[Spring Autowire示例](https://www.journaldev.com/2623/spring-autowired-annotation)。

### 18. Spring Bean自动装配有几种不同类型？

spring框架有4种类型的自动装配：

1. 据名称自动装配  
2. 据类型自动装配  
3. 据构造类自动装配  
4. 据@Autowired和@Qualifier注解自动装配
Prior to Spring 3.1, autowire by autodetect was also supported that was similar to autowire by constructor or byType. For more details about these options, please read Spring Bean Autowiring.

在Spring 3.1之前，据自动探测自动装配也被支持，它类似于构造器或按类型自动装配。有关这些选项的更多详细信息，请参阅[Spring Bean自动装配](https://www.journaldev.com/2623/spring-autowired-annotation)。

### 19. Spring Bean是线程安全的吗？

Spring bean的默认作用域是单例的，因此每个上下文只有一个实例。 这意味着所有类级别的变量在任何线程可以更新它，导致数据不一致。 因此，在默认模式下，spring bean不是线程安全的。

但是我们可以改变spring bean的作用域到request, prototype or session，在牺牲性能的基础上，来实现线程安全。 这是一个设计决策，并根据项目要求。

### 20. 在Spring MVC的Controller是什么？

就像MVC设计模式一样，Controller是负责处理所有客户端请求的类，并将它们分发到配置的资源去处理它。在Spring MVC中，org.springframework.web.servlet.DispatcherServlet是基于spring bean配置初始化上下文的前端控制器类。

Controller类负责根据请求映射来处理不同类型的客户端请求。 我们可以使用@Controller注解创建一个控制器类。 通常它与@RequestMapping注释一起使用来指定特定URI映射的处理程序方法。

### 21. 在Spring中 @Component, @Repository 和 @Service注解有什么区别？

`@Component`注解用于指示该类是一个组件。 当使用基于注解的配置时，这些类将自动检测并配置为bean被使用。

`@Controller`注解是一种特定类型的组件，用于MVC应用程序，大多与@RequestMapping注解一起使用。

`@Repository`注解用于指示组件用作存储库，以及用于存储/检索/搜索数据的机制。 我们可以使用DAO模式实现类应用此注解。

`@Service`注解用于表示该类是一个服务。 通常会提供一些服务的业务门面类使用该注解。

为了类可以自动检测到，我们可以使用任何以上注解，但不同的类型的注解被提供后，你可以轻松区分类的意图。

### 22. DispatcherServlet 和 ContextLoaderListener是什么？

`DispatcherServlet`是Spring MVC应用程序中的前台控制器，它加载spring bean配置文件并初始化配置的所有bean。 如果注解已启用，它还会扫描程序包和配置使用`@Component`，`@Controller`，`@Repository`或`@Service`注解的任何bean。

`ContextLoaderListener`是启动和关闭Spring的根`WebApplicationContext`的侦听器。 重要的功能是将`ApplicationContext`的生命周期与`ServletContext`的生命周期结合起来，并自动创建`ApplicationContext`。 我们可以跨越不同spring上下文中,使用它定义共享bean。

### 23. 在Spring中的ViewResolver是什么？

`ViewResolver`实现被用于按名称解析视图页面。 通常我们在spring bean配置文件中配置它。 例如：
```xml
<!-- Resolves views selected for rendering by @Controllers to .jsp resources in the /WEB-INF/views directory -->
<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	<beans:property name="prefix" value="/WEB-INF/views/" />
	<beans:property name="suffix" value=".jsp" />
</beans:bean>
```
`InternalResourceViewResolver`是`ViewResolver`接口的实现之一，我们通过bean属性提供了view pages目录和后缀位置。 因此，如果控制器处理程序方法返回“home”，则视图解析器将使用位于/WEB-INF/views/home.jsp的视图页面。

### 24. MultipartResolver是什么？什么时候使用？

`MultipartResolver`接口用于上传文件 - `CommonsMultipartResolver`和`StandardServletMultipartResolver`是由spring框架提供的用于文件上传的两个实现。 默认情况下，没有配置多部分解析器，但是要使用它们来上传文件，我们需要在spring bean配置中定义一个名为“multipartResolver”的bean，其类型为MultipartResolver。

一旦配置完成后，任何多部分请求将由配置的`MultipartResolver`解析，并传递一个包装的`HttpServletRequest`。 然后在控制器类中使用它来获取文件并处理它。 这里提供一个完整的例子，请阅读[Spring MVC文件上传示例](https://www.journaldev.com/2573/spring-mvc-file-upload-example-single-multiple-files)。

### 25. Spring MVC框架怎样处理异常？

Spring MVC框架提供了以下方法来帮助我们实现强大的异常处理。

1. **基于控制器** - 我们可以在控制器类中定义异常处理程序方法。 我们需要的是使用@ExceptionHandler注解来注解这些方法。
2. **全局异常处理程序** - 异常处理是一个横切关注的问题，Spring提供了`@ControllerAdvice`注解，让我们可以使用任何类来定义我们的全局异常处理程序。  
3. **`HandlerExceptionResolver`实现** - 对于一般异常，大多数时候我们提供静态页面。 Spring Framework提供了`HandlerExceptionResolver`接口，我们可以实现这个接口来创建全局异常处理程序。 这种额外的方法来定义全局异常处理程序的原因是Spring框架还提供了我们可以在spring bean配置文件中定义的默认实现类，以获得Spring框架异常处理的好处。

有关完整的示例，请参阅[Spring异常处理](https://www.journaldev.com/2651/spring-mvc-exception-handling-controlleradvice-exceptionhandler-handlerexceptionresolver)示例。

### 26. 在Java程序中怎样创建ApplicationContext？

在独立的java程序中创建`ApplicationContext`有以下几种方法。

1. **`AnnotationConfigApplicationContext`**：如果我们在独立的Java应用程序中使用Spring，并使用注解进行配置，那么我们可以使用它来初始化容器并获取bean对象。  
2. **`ClassPathXmlApplicationContext`**：如果我们在独立应用程序中有spring bean配置xml文件，那么我们可以使用此类来加载文件并获取容器对象。  
3. **`FileSystemXmlApplicationContext`**：类似于`ClassPathXmlApplicationContext`，除了可以从文件系统中的任何位置之外的任何地方加载xml配置文件。 

### 27. 能有多个Spring配置文件吗？

对于Spring MVC应用程序，我们可以通过contextConfigLocation定义多个Spring上下文配置文件。 该位置字符串可以由多个位置组成，并以任意数量的逗号和空格分隔。 例如;
```xml
<servlet>
	<servlet-name>appServlet</servlet-name>
	<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
	<init-param>
            <param-name>contextConfigLocation</param-name>
	    <param-value>/WEB-INF/spring/appServlet/servlet-context.xml,/WEB-INF/spring/appServlet/servlet-jdbc.xml</param-value>
	</init-param>
	<load-on-startup>1</load-on-startup>
</servlet>
```
我们还可以定义多个根级Spring配置，并通过上下文参数加载它们。 例如;
```xml
<context-param>
	<param-name>contextConfigLocation</param-name>
	<param-value>/WEB-INF/spring/root-context.xml /WEB-INF/spring/root-security.xml</param-value>
</context-param>
```
另一个选择是在上下文配置文件中使用import元素来导入其他配置，例如：
```xml
<beans:import resource="spring-jdbc.xml"/>
```

### 28. ContextLoaderListener是什么？

ContextLoaderListener是用于加载根上下文的侦听器类，并定义将对所有其他上下文可见的spring bean配置。 它在web.xml文件中配置为：
```xml
<context-param>
	<param-name>contextConfigLocation</param-name>
	<param-value>/WEB-INF/spring/root-context.xml</param-value>
</context-param>
	
<listener>
	<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
```

### 29. 为了创建Spring MVC应用，至少需要配置什么？

要创建一个简单的Spring MVC应用程序，我们需要执行以下任务。
1. 在项目中添加spring-context和spring-webmvc依赖项。
2. 在web.xml文件中配置DispatcherServlet，以通过spring容器处理请求。
3. Spring bean配置文件来定义bean，如果使用注解，那么必须在这里配置。 此外，我们还需要为视图页面配置视图解析器。
4. 控制器类与请求映射定义为处理客户端请求。
以上步骤应该足以创建一个简单的Spring MVC Hello World应用程序。

<a name="spring-mvc-architecture"></a>

### 30. 相对与MVC架构，你对Spring MVC框架的理解是怎样的？

正如名称所示，Spring MVC建立在Model-View-Controller架构之上。 DispatcherServlet是Spring MVC应用程序中的前端控制器，负责处理所有传入的请求并将其委托给不同的控制器处理程序方法。

模型可以是Spring框架中的任何Java Bean，就像任何其他MVC框架Spring一样，提供了将表单数据自动绑定到java bean。 我们可以将模型bean设置为在视图页面中使用的属性。

查看页面可以是JSP，静态HTML等，视图解析器负责查找正确的视图页面。 一旦查看页面被识别到，控制将返回给DispatcherServlet控制器。 DispatcherServlet负责呈现视图，并向客户端返回最终响应。

### 31. Spring MVC应用怎样实现本地化？

Spring通过资源包为本地化或i18n提供了极好的支持。 使我们的应用程序本地化所需的基本步骤是：

1. 为不同的区域设置创建消息资源束，如messages_en.properties，messages_fr.properties等。
2. 在`ResourceBundleMessageSource`或`ReloadableResourceBundleMessageSource`类型的spring bean配置文件中定义messageSource bean。
3. 要更改区域设置支持，请定义类型为CookieLocaleResolver的localeResolver bean并配置LocaleChangeInterceptor拦截器。
示例配置可以如下所示：
```xml
<beans:bean id="messageSource"
class="org.springframework.context.support.ReloadableResourceBundleMessageSource">
<beans:property name="basename" value="classpath:messages" />
<beans:property name="defaultEncoding" value="UTF-8" />
</beans:bean>
 
<beans:bean id="localeResolver"
    class="org.springframework.web.servlet.i18n.CookieLocaleResolver">
    <beans:property name="defaultLocale" value="en" />
    <beans:property name="cookieName" value="myAppLocaleCookie"></beans:property>
    <beans:property name="cookieMaxAge" value="3600"></beans:property>
</beans:bean>
 
<interceptors>
    <beans:bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor">
        <beans:property name="paramName" value="locale" />
    </beans:bean>
</interceptors>
```

4. 在具有键名称的视图页面中使用spring:message元素，DispatcherServlet选择相应的值，并将页面呈现在相应的区域设置中，并作为响应返回。

有关完整的示例，请阅读[Spring本地化](https://www.journaldev.com/2610/spring-mvc-internationalization-i18n-and-localization-l10n-example)示例 。

### 32. 使用Spring怎样创建Restful Web服务并返回JSON？

我们可以使用Spring Framework创建返回JSON数据的Restful Web服务。 Spring提供与[Jackson JSON](https://www.journaldev.com/2324/jackson-json-java-parser-api-example-tutorial) API的集成，我们可以使用它在安静的Web服务中发送JSON响应。

我们需要执行以下步骤来配置我们的Spring MVC应用程序以发送JSON响应：
1. 添加Jackson JSON依赖项，如果您使用Maven，可以使用以下代码：
```xml
<!-- Jackson -->
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>${jackson.databind-version}</version>
</dependency>
```
2. 在Spring bean配置文件中配置RequestMappingHandlerAdapter bean，并将messageConverters属性设置为MappingJackson2HttpMessageConverter bean。 样品配置将是：
```xml
<!-- Configure to plugin JSON as request and response in method handler -->
<beans:bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter">
    <beans:property name="messageConverters">
        <beans:list>
            <beans:ref bean="jsonMessageConverter"/>
        </beans:list>
    </beans:property>
</beans:bean>

<!-- Configure bean to convert JSON to POJO and vice versa -->
<beans:bean id="jsonMessageConverter" class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter">
</beans:bean>
```
3. 在控制器处理程序方法中，使用@ResponseBody注释返回Object作为响应。 示例代码：
```java
@RequestMapping(value = EmpRestURIConstants.GET_EMP, method = RequestMethod.GET)
public @ResponseBody Employee getEmployee(@PathVariable("id") int empId) {
    logger.info("Start getEmployee. ID="+empId);
     
    return empData.get(empId);
}
```
4. 您可以通过任何API调用其余服务，但是如果要使用Spring，那么我们可以使用RestTemplate类来轻松实现。
有关一个完整的例子，请阅读[Spring Restful Webservice](https://www.journaldev.com/2552/spring-rest-example-tutorial-spring-restful-web-services)示例 。

### 33. 你使用过哪些重要的Spring注解？

我在项目中使用的一些Spring注解是：

**@Controller** - 用于Spring MVC项目中的控制器类。
**@RequestMapping** - 用于在控制器处理程序方法中配置URI映射。 这是一个非常重要的注释。
**@ResponseBody** - 用于发送Object作为响应，通常用于发送XML或JSON数据作为响应。
**@PathVariable** - 用于将动态值从URI映射到处理程序方法参数。
**@Autowired** - 用于spring bean的自动装配依赖。
**@Qualifier** - 与@Autowired注解一起使用，以避免多个Bean类型的实例存在混淆。
**@Service** - 用于服务类。
**@Scope** - 用于配置spring bean的作用域。
**@Configuration**， **@ComponentScan**和**@Bean** - 用于基于Java的配置。
用于配置切面和通知的AspectJ注解， **@Aspect** ， **@Before** ， **@After** ， **@Around** ， **@Pointcut**等。

### 34. 我们可以发送一个Object作为Controller handler方法的响应吗？

可以，我们可以使用@ResponseBody注解。 这就是我们如何在restful的Web服务中发送基于JSON或XML的响应。

### 35. Spring MVC应用怎样上传文件？

Spring提供内置的支持，可通过MultipartResolver接口实现上传文件。 它非常易于使用，只需要配置更改才能使其正常工作。 显然，我们需要编写控制器处理程序方法来处理传入的文件并进行处理。 有关完整的示例，请参阅[Spring文件上传](https://www.journaldev.com/2573/spring-mvc-file-upload-example-single-multiple-files)示例 。

### 36. Spring Web MVC架构怎样验证表单数据？

Spring支持基于JSR-303注释的验证，并提供我们可以实现的Validator接口来创建我们自己的自定义验证器。 对于使用基于JSR-303的验证，我们需要使用所需的验证来注释bean变量。

对于自定义验证器实现，我们需要在controller类中进行配置。 有关完整的示例，请参阅[Spring MVC表单验证](https://www.journaldev.com/2668/spring-validation-example-mvc-validator)示例 。

### 37. Spring MVC拦截器（Interceptor）是什么？怎样使用？

Spring MVC拦截器就像Servlet过滤器，允许我们拦截客户端请求并处理它。 我们可以在三个地方拦截客户端请求 - **preHandle** ， **postHandle**和**afterCompletion** 。

我们可以通过实现HandlerInterceptor接口或扩展抽象类HandlerInterceptorAdapter来创建spring拦截器。

我们需要在spring bean配置文件中配置拦截器。 我们可以定义拦截器来拦截所有的客户端请求，也可以为特定的URI映射进行配置。 有关详细的示例，请参考[Spring MVC拦截器](https://www.journaldev.com/2676/spring-mvc-interceptor-example-handlerinterceptor-handlerinterceptoradapter)示例 。

### 38. Spring JdbcTemplate类是什么？怎样使用？

Spring Framework提供与JDBC API的良好集成，并提供JdbcTemplate实用程序类，我们可以使用它来避免数据库操作逻辑（如打开/关闭连接，ResultSet，PreparedStatement等）的bolier-plate代码。

对于JdbcTemplate示例，请参考[Spring JDBC](https://www.journaldev.com/2593/spring-jdbc-example)示例 。

### 39. Spring Web应用中怎样使用Tomcat JNDI数据资源？

对于使用servlet容器配置的JNDI DataSource，我们需要在spring bean配置文件中进行配置，然后将其注入spring beans作为依赖关系。 然后我们可以使用它与JdbcTemplate来执行数据库操作。

示例配置如下：
```xml
<beans:bean id="dbDataSource" class="org.springframework.jndi.JndiObjectFactoryBean">
    <beans:property name="jndiName" value="java:comp/env/jdbc/MyLocalDB"/>
</beans:bean>
```
有关完整的例子，请参考[Spring Tomcat JNDI](https://www.journaldev.com/2597/spring-datasource-jndi-with-tomcat-example)示例 。

### 40. 在Spring中怎样实现事务管理？

Spring框架通过声明式事务管理以及编程式事务管理来提供事务管理支持。 声明式事务管理被广泛使用，因为它在大多数情况下易于使用和工作。

我们使用@Transactional注释的注释方法进行声明式事务管理。 我们需要在Spring bean配置文件中为DataSource配置事务管理器。
```xml
<bean id="transactionManager"
    class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="dataSource" />
</bean>
```

### 41. Spring DAO是什么？

提供Spring DAO支持，以一致和简单的方式处理JDBC，Hibernate等数据访问技术。 例如，对于各自的技术，我们有`JdbcDaoSupport` ， `HibernateDaoSupport` ， `JdoDaoSupport`和`JpaDaoSupport` 。

Spring DAO还提供了异常层次结构的一致性，我们不需要捕获特定的异常。

### 42. 怎样集成Spring和Hibernate框架？

我们可以使用Spring ORM模块来集成Spring和Hibernate框架，如果您正在使用Hibernate 3+，SessionFactory提供当前会话，那么您应该避免使用`HibernateTemplate`或`HibernateDaoSupport`类，并更好地使用依赖注入的DAO模式进行集成。

Spring ORM还提供对使用Spring声明性事务管理的支持，所以您应该利用这一点，而不是使用hibernate的锅炉代码进行事务管理。

为了更好地理解，您应该请阅读以下教程：

[Spring Hibernate集成](https://www.journaldev.com/3524/spring-hibernate-integration-example-tutorial)示例
[Spring MVC Hibernate集成](https://www.journaldev.com/3531/spring-mvc-hibernate-mysql-integration-crud-example-tutorial)示例

### 43. Spring Security是什么？

Spring Security框架关注的焦点是在java应用程序中提供身份验证和授权。 它解决了大多数常见的安全漏洞问题，如CSRF攻击。

通过使用注解,如@EnableWebSecurity ，在Web应用程序中使用Spring Security是很有好处的且易于使用。 您应该通过以下文章来了解如何使用Spring Security框架。

[Servlet Web应用程序中的Spring Security](https://www.journaldev.com/2715/spring-security-example-tutorial)
[Spring MVC和Spring Security集成](https://www.journaldev.com/2736/spring-security-example-userdetailsservice)示例

### 44. 怎样注入一个java.util.Properties到Spring Bean？

我们需要定义propertyConfigurer bean，该bean将从给定的属性文件加载属性。 然后我们可以使用Spring EL支持将属性注入其他bean依赖关系。 例如;
```xml
<bean id="propertyConfigurer" 
  class="org.springframework.context.support.PropertySourcesPlaceholderConfigurer">
    <property name="location" value="/WEB-INF/application.properties" />
</bean> 

<bean class="com.journaldev.spring.EmployeeDaoImpl">
    <property name="maxReadResults" value="${results.read.max}"/>
</bean>
 ```
如果您使用注解来配置spring bean，则可以像下面那样注入属性。
```java
@Value("${maxReadResults}") 
private int maxReadResults;
 ```

### 45. Spring框架使用哪些设计模式？

Spring框架正在使用很多设计模式，其中一些常见的是：

1. 单例模式：创建具有默认范围的bean。
2. 工厂模式 ：Bean Factory类
3. 原型模式 ：Bean作用域
4. 适配器模式 ：Spring Web和Spring MVC
5. 代理模式 ：Spring Aspect面向编程支持
6. 模板方法模式 ：JdbcTemplate，HibernateTemplate等
7. 前端控制器：Spring MVC DispatcherServlet
8. 数据访问对象：Spring DAO支持
9. 依赖注入和面向方面的编程

### 46. Spring框架有些什么最佳实践？

Spring Framework的一些最佳实践是：
1. 避免模​​式引用中的版本号，以确保我们有最新的配置。
2. 根据spring-jdbc.xml，spring-security.xml等关注的问题来分隔spring bean配置。
3. 对于在Spring MVC中的多个上下文中使用的spring bean，在根上下文中创建它们并使用listener进行初始化。
4. 尽可能多地配置bean依赖关系，尽量避免自动装配。
5. 对于应用程序级属性，最佳方法是创建一个属性文件，并在spring bean配置文件中读取它。
6. 对于较小的应用程序，注解是有用的，但对于较大的应用程序注解可能会变得很痛苦。 如果我们在xml文件中有所有配置，维护它将会更容易。
7. 为组件使用正确的注解，轻松了解其意图。 对于服务，使用@Service和DAO bean使用@Repository。
8. Spring框架有很多模块，使用你需要的。 删除通过Spring Tool Suite模板创建项目时添加的所有额外的依赖项。
9. 如果您正在使用Aspects，请确保连接点范围尽可能的窄，以避免对不需要的方法的发送通知。 考虑更容易使用的自定义注解，可以避免任何问题。
10. 当有实际利益时，使用依赖注入，只是为了松散耦合而不使用它，因为它更难维护。

这就是Spring Framework面试的问题。 我希望这些问题能帮助您进行Java EE面试。 一旦有新的面试问题我将即时更新！

[原文](https://www.journaldev.com/2696/spring-interview-questions-and-answers)