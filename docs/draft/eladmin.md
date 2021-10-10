SpringBoot前后端分离后台管理系统分析，真香
==========================
> 来源：
> https://mp.weixin.qq.com/s/TJwh1YrUmEDRCwYHcXl3Vg

有很多读者都希望我出一些详细介绍 Java 实战类项目的文章，毕竟项目实战经验还是挺重要的，不论是对于找工作还是提高个人工程能力。我自己也发现很多读者不怎么会学习开源项目，不知道如何把开源项目的一些精华为自己所用。

我们这里分析的是 **eladmin[1]** 这个基于 Spring Boot + Spring Security +JPA +Vue 的前后端分离的后台管理系统。

荐过这个项目。

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/1a619230be6e4be987564c2f2d90259a?from=pc)

后台首页

开源工具库
=====

这部分简单分析一下项目使用到的一些比较有用的开源工具库：**MapStruct(Java 对象映射框架)**、**OSHI（基于 JNA 的操作系统和硬件信息库）**、**Hutool（Java 工具类库）**。

MapStruct
=========

**MapStruct[2]** 不仅能够在 bean 之间复制属性，还能够在不同类型之间自动转换。

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/119cc940bc6f4cdba82929a035df079f?from=pc)

相比于其他常见的映射框架， Dozer、Orika、ModelMapper、JMapper，MapStruct 的性能更好。

OSHI
====

**OSHI[5]** 是一款为 Java 语言提供的基于 JNA 的（本机）操作系统和硬件信息库。

**通过 OSHI ，我们不需要安装任何其他本机库，就能查看内存和 CPU 使用率、磁盘和分区使用情况、设备、传感器等信息。**

OSHI 旨在提供一种跨平台的实现来检索系统信息，支持 Windows、Linux、MacOS、Unix 等主流操作系统。

使用 oshi 你可以轻松制作出项目常用的系统监控功能，如下图所示：

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/f4f636612e4c4e419c0d2137bb67de6e?from=pc)

Hutool
======

**Hutool[6]** 一个非常实用的 Java 工具类库，对文件、流、加密解密、转码、正则、线程、XML 等 JDK 方法进行了封装。

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/088bf66237484fe38fb99f582547bae5?from=pc)

小技巧
===

这部分内容会简单分析一下从这个开源项目中看到的一些亮点以及小技巧。

优化表命名
=====

根据项目不同的 Module 作为表名的前缀，这样看起来更加直观。

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/a392ed73eb8645ee981c8876d383336a?from=pc)

巧用 AOP 简化代码
===========

**AOP(Aspect-Oriented Programming:面向切面编程)** 能够将那些与业务无关，却为业务模块所共同调用的逻辑或责任（例如事务处理、日志管理、权限控制等）封装起来，便于**减少系统的重复代码**，**降低模块间的耦合度**，**提高系统可拓展性和可维护性**。

这个项目中就大量使用了 **AOP** 思想。简单举两个例子吧！

日志记录
====

利用 AOP 方式记录日志，只需要在 controller 的方法上使用 @Log("") 注解，就可以将用户操作记录到数据库，源码可查看 eladmin-logging这个 Module。。

```
<code>@Log("新增用户")
@PostMapping(value = "/users")
public ResponseEntity create(@Validated @RequestBody User resources){
    checkLevel(resources);
    return new ResponseEntity(userService.create(resources),HttpStatus.CREATED);
}</code>
```

Redis 限流
========

利用 AOP 方式对接口进行限流，只需要在 controller 的方法上使用@Limit("") 注解即可，源码可查看 eladmin-common这个 Module。

```
<code>/**
 * 测试限流注解，下面配置说明该接口 60秒内最多只能访问 10次，保存到redis的键名为 limit_test，
 */
@AnonymousGetMapping
@ApiOperation("测试")
@Limit(key = "test", period = 60, count = 10, name = "testLimit", prefix = "limit")
public int test() {
     return ATOMIC_INTEGER.incrementAndGet();
}</code>
```

基于 RBAC 的权限模块设计
===============

系统权限控制采用 **RBAC 基于角色的权限访问控制（Role-Based Access Control）** 思想（*一种最常见的权限管理思想，在一些对于全权限控制要求比较严格的系统会使用到*）。

**什么是 RBAC 呢？**

简单地说：一个用户可以拥有若干角色，每一个角色有可以被分配若干权限这样，就构造成"用户-角色-权限" 的授权模型。在这种模型中，用户与角色、角色与权限之间构成了多对多的关系，如下图

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/c9fa51977f8041a693ac57e9d54436f2?from=pc)

RBAC

**在 RBAC 中，权限与角色相关联，用户通过成为适当角色的成员而得到这些角色的权限。这就极大地简化了权限的管理。**

本系统的权限设计相关的表如下（一共 5 张表，2 张用户建立表之间的联系）：

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/673ee6e52b48446ca884cf8db0a94d58?from=pc)

通过这个权限模型，我们可以创建不同的角色并为不同的角色分配不同的权限范围（菜单）。

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/015e338bf26d4fb78c4588b0e308e376?from=pc)

自定义权限验证方式
=========

Spring Security 提供了Spring EL表达式，允许我们在定义接口的方法上面添加注解来实现权限控制。比如下面的接口表示用户拥有 admin、menu:edit 权限中的任意一个就能能访问update接口。

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/9335e1be36264504967eb9292e152c5b?from=pc)

但是，由于每个接口都需要给超级管理员放行，所以单纯使用这种注解的方式每次都需要重复的添加 admin 权限、

因此我们可以加入自定义权限验证方式，在验证的时候默认给拥有 admin 权限的用户放行。

**源码：**

```
<code>// eladmin-common -> me.zhengjie.config.ElPermissionConfig
@Service(value = "el")
public class ElPermissionConfig {

    public Boolean check(String ...permissions){
        // 获取当前用户的所有权限
        List<String> elPermissions = SecurityUtils.getCurrentUser().getAuthorities().stream().map(GrantedAuthority::getAuthority).collect(Collectors.toList());
        // 判断当前用户的所有权限是否包含接口上定义的权限
        return elPermissions.contains("admin") || Arrays.stream(permissions).anyMatch(elPermissions::contains);
    }
}</code>
```

**使用方式：**

```
<code>@ApiOperation("查询任务执行日志")
@GetMapping(value = "/logs")
@PreAuthorize("@el.check('timing:list')")
public ResponseEntity<Object> queryJobLog(JobQueryCriteria criteria, Pageable pageable){
    return new ResponseEntity<>(quartzJobService.queryAllLog(criteria,pageable), HttpStatus.OK);
}</code>
```

对应的数据库内容如下：

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/515a11e4ecf54e57809b2aae204f4c6e?from=pc)![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/d9e24959a5814f809ff9b567465d2ae8?from=pc)

审计功能
====

在这个项目中，继承了 BaseEntity 的类会自动写入创建时间、修改时间、创建人、更新人这些数据。

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/9dded153d6ab463082a044de9127e89a?from=pc)

简单介绍一下上面涉及到的一些注解：

1.  @CreationTimestamp : 创建对象的时候自动生成时间戳。
2.  @UpdateTimestamp:创建对象的时候自动生成时间戳。
3.  @CreatedBy :表示该字段为创建人，在这个实体被 insert 的时候会设置值，@LastModifiedBy同理。

审计功能对应的配置类:

![SpringBoot前后端分离后台管理系统分析，真香](https://p6.toutiaoimg.com/origin/pgc-image/1cb39df41f7b42ba99ce015f5b99c982?from=pc)

可优化点
====

1.  可以考虑使用阿里开源的 easyexcel 来做 Excel 的导入导出，避免 OOM。
2.  可以参考 **《实际项目中我们是这样做异常处理的》[7]** 对项目全局异常处理部分进行优化。
3.  一些重复代码可以抽取出来，比如eladmin-common 模块中的 BaseDTO.java和 BaseEntity.java的toString()方法。
4.  项目的 json 解析库用到了 fastjson。实际上，我更推荐使用 Spring 默认的 JSON 解析库 Jackson。这两者中， Fastjson 的代码质量以及设计更差，并且，经常被爆出有安全漏洞（*设计问题*）。虽然 Fastjson 在速度方面稍稍取胜，但是，速度方面的优势不太明显，影响不大。
5.  可以使用 **Caffeine** 来做本地缓存。

后记
==

我发现很多人对于开源项目的态度就是：**克隆下来就简单玩玩功能就算了。**

我觉得这样不太好。你把项目克隆下来之后，首先肯定是自己体验一下系统的核心功能。体验了核心功能之后，你可以分析分析项目代码，检查一下有没有 bug，看看有没有可以优化的代码/模块，思考一下有没有需要完善的功能模块......。我在自己分析、调试这个开源项目的时候，就发现了一个小 bug 并提交了相应的 issue （*目前已经被采纳*）。
