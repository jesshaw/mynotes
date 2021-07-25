---
title: Spring Boot热部署：spring-boot-devtools
tags: java,spring,spring boot,spring-boot-devtools,热部署
categories: 
  - java

thumbnail: /gallery/blue-water14.jpg
---

spring-boot-devtools 是一个为开发者服务的一个模块，其中最重要的功能就是热部署。

<!-- more -->

当我们修改了classpath下的文件（包括类文件、属性文件、页面等）时，会重新启动应用（由于其采用的双类加载器机制，这个启动会非常快，另外也可以选择使用jrebel）。

spring-boot-devtools使用了两个类加载器来实现重启（restart）机制：

base类加载器（base ClassLoader）, restart类加载器（restart ClassLoader）。

* base ClassLoader：用于加载不会改变的jar（eg.第三方依赖的jar）
* restart ClassLoader：用于加载我们正在开发的jar（eg.整个项目里我们自己编写的类）。当应用重启后，原先的restart ClassLoader被丢掉、重新new一个restart ClassLoader来加载这些修改过的东西，而base ClassLoader却不需要动一下。这就是devtools重启速度快的原因。

<<<<<<< HEAD
使用devtools，只需要添加其依赖即可 :
=======
使用devtools，需要添加其依赖即可 :
>>>>>>> master_bak

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
        <optional>true</optional>
    </dependency>
</dependencies>
<<<<<<< HEAD
=======

<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                <!-- fork:如果没有该配置，这个devtools不会起作用，即应用不会restart -->
                <fork>true</fork>
            </configuration>
        </plugin>
    </plugins>
</build>
>>>>>>> master_bak
```
默认情况下，
`/META-INF/maven，/META-INF/resources，/resources，/static，/templates，/public`
这些文件夹下的文件修改不会使应用重启，但是会重新加载（devtools内嵌了一个LiveReload server，当资源发生改变时，浏览器刷新）。

另外，使用Intellij的可能会遇到这个问题，即使项目使用了spring-boot-devtools，修改了类或者html、js等，idea还是不会自动重启，非要手动去make一下或者重启，就更没有使用热部署一样。出现这种情况，并不是你的配置问题，其根本原因是因为Intellij IEDA和Eclipse不同，Eclipse设置了自动编译之后，修改类它会自动编译，而IDEA在非RUN或DEBUG情况下才会自动编译（前提是你已经设置了Auto-Compile）。

首先，IDEA设置里面Setting->Builder,Excution,Deployment->Compiler的Make project automatically，把这个选项打勾

然后 Shift+Ctrl+Alt+/(Mac: Shift+Command+Alt+/)，选择Registry
把compiler.automake.allow.when.app.running 打勾

OK了，重启一下项目，然后改一下类里面的内容，IDEA就会自动去make了。


