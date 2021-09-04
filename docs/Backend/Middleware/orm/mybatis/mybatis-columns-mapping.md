---
title: mybatis列映射的几种方式
tags: java,mybatis,columns mapping,列映射
categories: 
  - java

thumbnail: /gallery/blue-water3.jpg
---

不同于hibernate实现活动记录模式，mybatis实现了数据映射模式，其中列的映射有多种实现方式，有简单的也有复杂的，分别适用不同的业务场景

<!-- more -->
## 1. 使用注解@Results和@Result

```java
@Mapper
public interface UserDao {
    @Select("SELECT * FROM users")
    @Results({
            @Result(property = "firstName", column = "first_name"),
            @Result(property = "lastName", column = "last_name")
    })
    List<User> findUsers();


    @Select("SELECT * FROM users")
    @ResultMap("BaseResultMap")
    List<User> findUsers1();
}
```
XML配置如下
```xml
<resultMap id="BaseResultMap" type="package.for.User">
  <result property = "firstName", column = "first_name" jdbcType="VARCHAR" />
  <result property = "lastName", column = "last_name" jdbcType="VARCHAR" />  
</resultMap>
```

* 优点

映射关系简单明了

* 缺点

相同实体类型的返回变多之后，注解的工作量加大，容易不同步和出错

避免重复的话，需要与XML配置结合，如此一来，由于使用两种方式感觉麻烦了


## 2. 使用别名
```java
@Mapper
public interface UserDao {
    @Select("SELECT first_name as firstName, last_name as lastName FROM users")
    List<User> findUsers();

    @Select({
            "SELECT",
            "  first_name as firstName,",
            "  last_name as lastName",
            "FROM users"})
    List<User> findUsers1();
}
```
* 优点

最直接，简单明了

* 缺点

多人开发，可能带来db命名的不规范

## 3. 使用全局配置
在application.properties中，增加以下配置
```
mybatis.configuration.mapUnderscoreToCamelCase=true
```
或者使用自定义配置Bean
```java
    @Bean
    ConfigurationCustomizer mybatisConfigurationCustomizer() {
        return new ConfigurationCustomizer() {
            public void customize(Configuration configuration) {
                configuration.setMapUnderscoreToCamelCase(true);
            }
        };
    }
```

* 优点

全局设置之后，只要遵守下划线映射到驼峰命名规范，就省出了大量的手动映射工作

* 缺点

对已有老系统无按此规则的db，无法映射

## 4. 使用XML映射
XML配置如下
```xml
<resultMap id="BaseResultMap" type="package.for.User">
  <result property = "firstName", column = "first_name" jdbcType="VARCHAR" />
  <result property = "lastName", column = "last_name" jdbcType="VARCHAR" />  
</resultMap>

<select id="findUsers" resultMap="BaseResultMap">
  SELECT * FROM users WHERE ID = #{id}
</select>
<select id="findUsers1" resultType="package.for.User">
  SELECT * FROM users WHERE ID = #{id}
</select>
```
java就不需要再一一配置了
```java
@Mapper
public interface UserDao {
    List<User> findUsers();
    List<User> findUsers1();
}

```
* 优点

字段映射关系和对象完全分离

* 缺点

XML硬编码，维护内容多时容易出错

## 总结

以上各种方法各有优劣，完全注解方式硬编码少，维护不容易出错。完全XML方式更加灵活，可以发布之后变动。具体使用单个或者混合方式取决于具体业务场景。

参考:
[MyBatis-Spring-Boot-Starter介绍](http://www.mybatis.org/spring-boot-starter/mybatis-spring-boot-autoconfigure/)


