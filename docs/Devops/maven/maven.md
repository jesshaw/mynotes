# Maven

## 第三方更新策略

在做版本升级的时候，有时需要从第3方把jar升级合并到本地，这时就会涉及到更新策略的问题。
    - 每日更新（默认）
    - 永远检查更新
    - 从不检查更新和自定义时间间隔更新
配置snapshot

## scope依赖范围

compile

This is the default scope, used if none is specified. Compile dependencies are available in all classpaths of a project. Furthermore, those dependencies are propagated to dependent projects.

provided

This is much like compile, but indicates you expect the JDK or a container to provide the dependency at runtime. For example, when building a web application for the Java Enterprise Edition, you would set the dependency on the Servlet API and related Java EE APIs to scope provided because the web container provides those classes. This scope is only available on the compilation and test classpath, and is not transitive.

runtime

This scope indicates that the dependency is not required for compilation, but is for execution. It is in the runtime and test classpaths, but not the compile classpath.
test

This scope indicates that the dependency is not required for normal use of the application, and is only available for the test compilation and execution phases. This scope is not transitive.

system

This scope is similar to provided except that you have to provide the JAR which contains it explicitly. The artifact is always available and is not looked up in a repository.

import (only available in Maven 2.0.9 or later)

This scope is only supported on a dependency of type pom in the section. It indicates the dependency to be replaced with the effective list of dependencies in the specified POM’s section. Since they are replaced, dependencies with a scope of import do not actually participate in limiting the transitivity of a dependency.

中文

1. compile 默认的范围，编译测试运行都有效。
2. provided 编译和测试时有效，最后是在运行的时候不会被加入。官方举了一个例子。比如在JavaEE web项目中我们需要使用servlet的API，但是呢Tomcat中已经提供这个jar，我们在编译和测试的时候需要使用这个api，但是部署到tomcat的时候，如果还加入servlet构建就会产生冲突，这个时候就可以使用provided。
3. runtime 在测试和运行时有效。
4. test 在测试时有效。
5. system 与本机系统相关联，可移植性差。编译和测试时有效。
6. import 导入的范围，它只在使用dependencyManagement中，表示从其他pom中导入dependecy的配置。

| scope取值 | 有效范围（compile, runtime, test） | 依赖传递 | 例子        |
| --------- | ---------------------------------- | -------- | ----------- |
| compile   | all                                | 是       | spring-core |
| provided  | compile, test                      | 否       | servlet-api |
| runtime   | runtime, test                      | 是       | JDBC驱动    |
| test      | test                               | 否       | JUnit       |
| system    | compile, test                      | 是       |             |
