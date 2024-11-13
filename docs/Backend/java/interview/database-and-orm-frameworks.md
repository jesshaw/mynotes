# 数据库及ORM框架

以下是 Java 中与数据库操作及 ORM 框架相关的常见面试题及答案，涵盖了 JDBC、Hibernate、MyBatis 等技术：

## 1. 什么是 JDBC？它的工作原理是什么？

**答案**：

- **JDBC（Java Database Connectivity）** 是 Java 提供的一套 API，允许 Java 应用程序与关系数据库进行交互。
- **工作原理**：
      - JDBC 通过驱动程序（如 MySQL、Oracle 等）实现与数据库的连接。
      - 主要步骤包括：加载驱动、创建连接、创建语句、执行查询或更新、处理结果、关闭连接。
- 示例代码：

```java
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM users");
while(rs.next()) {
    System.out.println(rs.getString("name"));
}
rs.close();
stmt.close();
conn.close();
```

## 2. 什么是 ORM？ORM 的优缺点是什么？

**答案**：

- **ORM（Object-Relational Mapping）** 是对象关系映射的技术，用于在对象模型与数据库关系模型之间建立映射。
- **优点**：
      - 提升开发效率：简化数据持久化操作，无需编写大量 SQL 代码。
      - 减少冗余代码：提供了基于对象的方式来操作数据库。
      - 数据库无关性：能够更方便地切换数据库。
- **缺点**：
      - 性能损耗：在复杂场景下，ORM 生成的 SQL 可能不够优化。
      - 难以实现复杂查询：对于多表连接和复杂业务逻辑，可能需要手写 SQL。

## 3. Hibernate 中有哪些重要注解？

**答案**：

- **@Entity**：用于将类声明为实体类。
- **@Table**：指定数据库表名称。
- **@Id**：定义主键字段。
- **@GeneratedValue**：主键生成策略。
- **@Column**：指定列的详细信息，如列名、类型等。
- **@OneToOne**、**@OneToMany**、**@ManyToOne**、**@ManyToMany**：定义实体关系。
- 示例代码：

```java
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username")
    private String username;

    @OneToMany(mappedBy = "user")
    private List<Order> orders;
}
```

## 4. 如何选择 Hibernate 的主键生成策略？

**答案**：

- **IDENTITY**：使用数据库的自增字段（如 MySQL 的 `AUTO_INCREMENT`）。
- **SEQUENCE**：基于数据库的序列（如 Oracle 的序列）。
- **TABLE**：使用一张专门的表来生成主键值。
- **AUTO**：自动选择主键生成策略，根据不同数据库选择最合适的策略。
- 示例代码：

```java
@Id
@GeneratedValue(strategy = GenerationType.SEQUENCE)
private Long id;
```

## 5. Hibernate 和 MyBatis 的区别是什么？

**答案**：

- **Hibernate**：
      - 完全的 ORM 框架，自动生成 SQL，适合关系型数据库映射。
      - 支持延迟加载、一级缓存、二级缓存等高级功能。
- **MyBatis**：
      - 半自动化 ORM 框架，需手写 SQL，适合复杂查询需求。
      - 灵活性高，可通过 XML 和注解自定义 SQL 语句。
- **适用场景**：Hibernate 适合结构化、变化少的系统；MyBatis 适合复杂查询、多样化需求的系统。

## 6. 什么是 Hibernate 的 Session 和 SessionFactory？

**答案**：

- **Session**：用于与数据库进行 CRUD 操作的对象，生命周期通常与事务一致，非线程安全。
- **SessionFactory**：Session 的工厂，用于生成 Session 对象，线程安全且在应用中通常为单例。
- **使用方式**：SessionFactory 创建时会根据配置文件读取所有数据库配置，并创建数据库连接池。

## 7. Hibernate 的一级缓存和二级缓存的区别？

**答案**：

- **一级缓存**：
      - 默认开启，属于 Session 范围缓存，缓存只对当前 Session 有效。
      - 在同一个事务中读取同一数据时，直接从缓存中获取，不用重复访问数据库。
- **二级缓存**：
      - 可配置启用，属于 SessionFactory 范围缓存，在多个 Session 间共享。
      - 适用于跨事务和会话的数据缓存，提高读操作性能。
      - 常用实现：EHCache、Infinispan 等。

## 8. 什么是 JPA？Hibernate 是 JPA 的实现吗？

**答案**：

- **JPA（Java Persistence API）** 是 **Java EE 提供的 ORM 规范**，提供了统一的数据持久化标准。
- **Hibernate 是 JPA 的实现之一**，除此之外还有 EclipseLink、OpenJPA 等实现。
- JPA 的优势是规范统一，方便在实现之间切换；**劣势是缺乏特性扩展**，某些高级功能需特定实现来支持。

## 9. 什么是 Hibernate 的 HQL？如何使用？

**答案**：

- **HQL（Hibernate Query Language）** 是 Hibernate 提供的面向对象的查询语言，类似于 SQL，但操作的是实体对象。
- 使用方法：通过 Session 的 `createQuery()` 方法执行 HQL 查询。
- 示例代码：

```java
List<User> users = session.createQuery("FROM User WHERE age > 18", User.class).list();
```

## 10. 如何使用 JPA 实现一对多关系？

**答案**：

- 使用 `@OneToMany` 注解定义一对多关系，并在从表上使用 `@ManyToOne` 注解建立反向关系。
- 示例代码：

```java
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(mappedBy = "user")
    private List<Order> orders;
}

@Entity
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
```

## 11. MyBatis 中的 #{} 和 ${} 有什么区别？

**答案**：

- `#{}` （Hash固定的占位用）用于预编译的参数占位符，能防止 SQL 注入。
- `${}` （Dollar美元符流动用的动态拼接用）是直接替换，容易发生 SQL 注入，但在动态 SQL 中使用较多。
- 示例代码：

```xml
<select id="selectUser" resultType="User">
    SELECT * FROM users WHERE username = #{username} AND age > ${age}
</select>
```

## 12. MyBatis 的 XML 配置文件中常见的标签有哪些？

**答案**：

- **`<select>`**：定义查询语句。
- **`<insert>`**：定义插入语句。
- **`<update>`**：定义更新语句。
- **`<delete>`**：定义删除语句。
- **`<resultMap>`**：映射查询结果到 Java 对象。
- **`<if>`**、**`<choose>`**、**`<foreach>`** 等：用于动态 SQL 生成。

## 13. 如何实现 MyBatis 分页查询？

**答案**：

- 可以在 SQL 中使用 `LIMIT` 和 `OFFSET`，也可以通过插件扩展如 PageHelper 实现。
- 示例代码：

```xml
<select id="selectUsersByPage" resultType="User">
    SELECT * FROM users LIMIT #{limit} OFFSET #{offset}
</select>
```

## 14. 如何在 Spring Boot 中集成 MyBatis？

**答案**：

- 需要引入 `mybatis-spring-boot-starter` 依赖，并在 `application.yml` 中配置数据源及 MyBatis 相关信息。
- 示例配置：

```yaml
spring:
    datasource:
    url: jdbc:mysql://localhost:3306/mydb
    username: root
    password: password
    mybatis:
    mapper-locations: classpath:/mappers/*.xml
```

## 15. 如何使用 MyBatis 动态 SQL？

**答案**：

- MyBatis 支持使用 `<if>`, `<choose>`, `<when>`, `<otherwise>`, `<foreach>` 等标签动态生成 SQL。
- 示例代码：

```xml
<select id="selectUsersByConditions" resultType="User">
    SELECT * FROM users
    <where>
        <if test="username != null">AND username = #{username}</if>
        <if test="age != null">AND age = #{age}</if>
    </where>
</select>
```

## 16. mybatis plus相对与mybatis有哪些改进？

**答案**：
MyBatis-Plus（简称 MP）在 MyBatis 的基础上增加了一些功能，使得开发更加便捷高效。相对于 MyBatis，它的主要改进如下：

1. **内置 CRUD 操作**：MyBatis-Plus 内置了大量常用的 CRUD 操作，开发者无需手动编写 XML 或 Mapper 方法，只需简单调用即可实现插入、查询、更新和删除，极大减少了代码量。
2. **条件构造器**：提供了强大的 `Wrapper` 条件构造器，可以通过链式调用的方式动态构造查询条件，避免了复杂的拼接 SQL，减少了代码的重复性和出错率。
3. **分页插件**：MyBatis-Plus 内置了分页插件，支持主流数据库的分页操作，配置简单、使用方便。相比 MyBatis 需要手动配置分页查询，MP 通过分页插件一行代码即可实现分页。
4. **自动填充**：支持字段的自动填充，例如创建时间、更新时间等字段，可以在插入或更新时自动填充，减少了开发者的手动设置。
5. **乐观锁插件**：MyBatis-Plus 支持乐观锁机制，开发者只需在实体类中增加注解，即可轻松实现乐观锁功能，避免了并发修改的问题。
6. **多租户插件**：支持多租户插件，可以为数据表自动添加租户条件，实现多租户隔离，适用于 SaaS 系统的开发需求。
7. **逻辑删除**：支持逻辑删除功能，使用注解即可实现“软删除”，即在查询时自动过滤逻辑删除的数据，而不是真正从数据库中删除。
8. **代码生成器**：MyBatis-Plus 提供了代码生成器，可以根据数据库表结构快速生成实体类、Mapper 接口等代码，极大提高了开发效率。
9. **性能优化插件**：MyBatis-Plus 提供了一些性能优化插件，如 SQL 性能分析插件、禁止全表更新插件等，帮助开发者优化 SQL 性能和规避一些危险操作。
10. **更好的扩展性**：MyBatis-Plus 支持自定义实现各类插件和拦截器，允许开发者根据业务需求做定制化开发。

综上所述，MyBatis-Plus 在 MyBatis 的基础上通过这些功能增强了开发效率，减少了样板代码，同时也引入了常见业务需求的插件，降低了开发复杂度。

## 17. mybatis plus 是如果让你来实现自动填充你是怎样来做？

**答案**：

MyBatis-Plus 的自动填充功能通常用于在数据库操作时自动填入一些默认值，如创建时间、更新时间、操作用户等。它的设计和实现主要通过拦截和注解的方式来完成。拦截可以通过实现MyBatis的Interceptor接口或Spring AOP定义切面类实现。

## 18. 如果让你来实现mybatis plus的乐观锁怎样来做？

**答案**：

乐观锁的基本思路是：在更新记录时增加一个“version版本号”字段，数据库表中的记录每次被修改时，版本号都会自动递增。如果两个事务同时读取了一条数据并试图更新，则只有版本号符合条件的更新才会成功。更新不成功的事务将接收到更新失败的提示，从而避免了数据的冲突。

同样是通过实现MyBatis的Interceptor接口，在更新前增加version字段值实现。

在某些场景，也可以根据更新不成功的记录条数，如果受影响行数为 0，则视为更新失败，可以捕获该异常进行相应的重试逻辑或错误提示。

## 19. 结合一个更新两条记录的例子，说明MyBatis是如何实现事务的？

在 Spring 中的 MyBatis 事务中，如果一个事务内包含两条更新操作（例如更新两个表），Spring 的事务管理器会确保这两个更新操作在同一事务中进行，保证一致性。具体过程如下：

**假设场景**有一个 `@Transactional` 注解的方法 `updateTwoTables()`，其中包含对两个数据库表的更新操作：

```java
@Transactional
public void updateTwoTables(int id1, String newValue1, int id2, String newValue2) {
    mapper.updateTable1(id1, newValue1);
    mapper.updateTable2(id2, newValue2);
}
```

详细执行过程

1. **代理和事务拦截**：
      - Spring AOP 代理会拦截对 `updateTwoTables()` 方法的调用，检测到 `@Transactional` 注解后，开始事务管理过程。
      - AOP 代理会通过 `PlatformTransactionManager` 调用 `getTransaction()`，在数据源上开启一个新事务，并创建一个 `TransactionStatus` 对象来记录事务状态。

2. **获取数据库连接并开启事务**：
      - 事务管理器 `DataSourceTransactionManager` 向数据源请求一个数据库连接，并设置连接的自动提交为 `false`（关闭自动提交）。
      - 此时，MyBatis 的 `SqlSession` 也会绑定到该数据库连接上，从而确保同一 `SqlSession` 内的所有操作都在同一事务上下文中进行。

3. **执行第一条更新操作**：
      - 事务管理器打开事务后，Spring 继续执行 `updateTwoTables()` 方法中的第一条更新操作，即 `mapper.updateTable1(id1, newValue1)`。
      - `SqlSession` 使用同一个数据库连接执行 `updateTable1` 操作，并缓存或锁定相关的数据行，保持操作的一致性。

4. **执行第二条更新操作**：
      - 在第一条更新成功执行后，Spring 执行 `updateTwoTables()` 方法中的第二条更新操作，即 `mapper.updateTable2(id2, newValue2)`。
      - `SqlSession` 仍然使用同一个数据库连接执行 `updateTable2`，同样保持在当前事务中。

5. **提交或回滚事务**：
      - 如果方法执行完成且没有抛出异常，Spring 事务管理器调用 `commit()` 提交事务，将两条更新操作的结果一并持久化到数据库。
      - 如果方法中抛出了非检查异常（`RuntimeException` 或 `Error`），事务管理器会调用 `rollback()`，撤销所有操作的更改，包括 `updateTable1` 和 `updateTable2` 的操作结果，确保数据一致性。

6. **释放数据库连接**：
      - 事务提交或回滚后，事务管理器会释放数据库连接，`SqlSession` 也会关闭该连接。
      - Spring AOP 代理方法执行完成，将控制权交还给调用者。

总之：

- 在 Spring 的 MyBatis 事务管理中，事务管理器 `DataSourceTransactionManager` 在方法调用前开启事务，并确保 `SqlSession` 的所有数据库操作使用同一数据库连接。
- 事务提交和回滚逻辑由 Spring AOP 代理和事务管理器控制，确保在异常情况下自动回滚，避免部分更新导致的数据不一致问题。

## 20. Spring注解Transactional有哪些属性？

@Transactional 提供了一些属性，可以进一步控制事务的行为：

- **propagation**：事务传播行为，控制方法是否需要开启新事务，或者加入现有事务。例如：
    - **REQUIRED（默认）**：如果存在一个事务，则加入该事务；如果没有事务，则创建一个新的事务。
    - **REQUIRES_NEW**：每次都创建一个新事务，若已有事务，则暂停当前事务。
- **isolation**：事务的隔离级别，控制事务的隔离程度。常用的隔离级别包括：
    - **READ_COMMITTED**：已提交读。防止脏读。
    - **REPEATABLE_READ**：可重复读。防止脏读、不可重复读。
    - **SERIALIZABLE**：串行化。防止所有并发问题，但性能较差。
- **timeout**：事务超时时间，指定事务应在多少秒内完成，否则回滚。
- **rollbackFor**：指定遇到哪些异常类型时，事务需要回滚。
- **noRollbackFor**：指定遇到哪些异常类型时，事务不回滚。
