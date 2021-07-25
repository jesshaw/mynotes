---
title: liquibase实现自动升级数据的步骤
tags: liquibase,db upgrade,数据库升级
categories: 
  - db

thumbnail: /gallery/green-water1.jpg

---

数据库变化常常发生，怎样协调自动完成增量升级是个不少的挑战，以下方案可行

<!-- more -->

## 1 配置好mvn对比数据库

```xml
<plugin>
	<groupId>org.liquibase</groupId>
	<artifactId>liquibase-maven-plugin</artifactId>
	<version>${liquibase.version}</version>
	<configuration>
	    <changeLogFile>src/main/resources/config/liquibase/master.xml</changeLogFile>
	    <diffChangeLogFile>src/main/resources/config/liquibase/changelog/${maven.build.timestamp}_changelog.xml</diffChangeLogFile>
	    <driver>com.mysql.jdbc.Driver</driver>
	    <url>jdbc:mysql://localhost:3306/lexiangmiaoSite</url>
	    <defaultSchemaName>lexiangmiaoSite</defaultSchemaName>
	    <username>root</username>
	    <password>xxxxx</password>
	    <referenceUrl>hibernate:spring:com.lexiangmiao.site.domain?dialect=org.hibernate.dialect.MySQL5InnoDBDialect&amp;hibernate.physical_naming_strategy=org.springframework.boot.orm.jpa.hibernate.SpringPhysicalNamingStrategy&amp;hibernate.implicit_naming_strategy=org.springframework.boot.orm.jpa.hibernate.SpringImplicitNamingStrategy</referenceUrl>
	    <verbose>true</verbose>
	    <logging>debug</logging>
	</configuration>
</plugin>
```

创建支持emoji表情的MySQL数据库 utf8mb4

```bash
CREATE DATABASE `lexiangmiao` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
```

## 2 使用liquibase比较于当前文件与目标对象的差异


``` bash
mvn liquibase:diff
```

生成的差异文档与实际需求存在差异，删除不需要的升级，并把升级文档用作升级即可

## 3 嵌入升级文档并运行升级

运行应用即可升级

[liquibase diff](http://www.liquibase.org/documentation/diff.html)

[jhipster db upgrade](http://www.jhipster.tech/development/)


