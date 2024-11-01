# 数据库及ORM框架

以下是 Java 中与数据库操作及 ORM 框架相关的常见面试题及答案，涵盖了 JDBC、Hibernate、MyBatis 等技术：


## 1. **什么是 JDBC？它的工作原理是什么？**

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

## 2. **什么是 ORM？ORM 的优缺点是什么？**

**答案**：

- **ORM（Object-Relational Mapping）** 是对象关系映射的技术，用于在对象模型与数据库关系模型之间建立映射。
- **优点**：
- 提升开发效率：简化数据持久化操作，无需编写大量 SQL 代码。
- 减少冗余代码：提供了基于对象的方式来操作数据库。
- 数据库无关性：能够更方便地切换数据库。
- **缺点**：
- 性能损耗：在复杂场景下，ORM 生成的 SQL 可能不够优化。
- 难以实现复杂查询：对于多表连接和复杂业务逻辑，可能需要手写 SQL。


## 3. **Hibernate 中有哪些重要注解？**

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

## 4. **如何选择 Hibernate 的主键生成策略？**

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

## 5. **Hibernate 和 MyBatis 的区别是什么？**

**答案**：

- **Hibernate**：
- 完全的 ORM 框架，自动生成 SQL，适合关系型数据库映射。
- 支持延迟加载、一级缓存、二级缓存等高级功能。
- **MyBatis**：
- 半 ORM 框架，需手写 SQL，适合复杂查询需求。
- 灵活性高，可通过 XML 和注解自定义 SQL 语句。
- **适用场景**：Hibernate 适合结构化、变化少的系统；MyBatis 适合复杂查询、多样化需求的系统。

## 6. **什么是 Hibernate 的 Session 和 SessionFactory？**

**答案**：

- **Session**：用于与数据库进行 CRUD 操作的对象，生命周期通常与事务一致，非线程安全。
- **SessionFactory**：Session 的工厂，用于生成 Session 对象，线程安全且在应用中通常为单例。
- **使用方式**：SessionFactory 创建时会根据配置文件读取所有数据库配置，并创建数据库连接池。


## 7. **Hibernate 的一级缓存和二级缓存的区别？**

**答案**：

- **一级缓存**：
- 默认开启，属于 Session 范围缓存，缓存只对当前 Session 有效。
- 在同一个事务中读取同一数据时，直接从缓存中获取，不用重复访问数据库。
- **二级缓存**：
- 可配置启用，属于 SessionFactory 范围缓存，在多个 Session 间共享。
- 适用于跨事务和会话的数据缓存，提高读操作性能。
- 常用实现：EHCache、Infinispan 等。


## 8. **MyBatis 中的 #{} 和 ${} 有什么区别？**

**答案**：

- `#{}` 用于预编译的参数占位符，能防止 SQL 注入。
- `${}` 是直接替换，容易发生 SQL 注入，但在动态 SQL 中使用较多。
- 示例代码：

```xml
<select id="selectUser" resultType="User">
    SELECT * FROM users WHERE username = #{username} AND age > ${age}
</select>
```

## 9. **MyBatis 的 XML 配置文件中常见的标签有哪些？**

**答案**：

- **\<select>**：定义查询语句。
- **\<insert>**：定义插入语句。
- **\<update>**：定义更新语句。
- **\<delete>**：定义删除语句。
- **\<resultMap>**：映射查询结果到 Java 对象。
- **\<if>**、**\<choose>**、**\<foreach>** 等：用于动态 SQL 生成。

## 10. **什么是 JPA？Hibernate 是 JPA 的实现吗？**

**答案**：

- **JPA（Java Persistence API）** 是 Java EE 提供的 ORM 规范，提供了统一的数据持久化标准。
- Hibernate 是 JPA 的实现之一，除此之外还有 EclipseLink、OpenJPA 等实现。
- JPA 的优势是规范统一，方便在实现之间切换；劣势是缺乏特性扩展，某些高级功能需特定实现来支持。

## 11. **如何使用 JPA 实现一对多关系？**

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

## 12. **如何实现 MyBatis 分页查询？**

**答案**：

- 可以在 SQL 中使用 `LIMIT` 和 `OFFSET`，也可以通过插件扩展如 PageHelper 实现。
- 示例代码：

```xml
<select id="selectUsersByPage" resultType="User">
    SELECT * FROM users LIMIT #{limit} OFFSET #{offset}
</select>
```


## 13. **如何在 Spring Boot 中集成 MyBatis？**

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


## 14. **什么是 Hibernate 的 HQL？如何使用？**

**答案**：

- **HQL（Hibernate Query Language）** 是 Hibernate 提供的面向对象的查询语言，类似于 SQL，但操作的是实体对象。
- 使用方法：通过 Session 的 `createQuery()` 方法执行 HQL 查询。
- 示例代码：

```java
List<User> users = session.createQuery("FROM User WHERE age > 18", User.class).list();
```

## 15. **如何使用 MyBatis 动态 SQL？**

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

这些面试题涵盖了数据库操作、ORM 框架的基础知识以及实际操作的细节。掌握这些问题能够帮助你更好地应对 Java 数据库面试。