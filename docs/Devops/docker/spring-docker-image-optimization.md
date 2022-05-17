# spring boot 项目Docker镜像优化

## 思路1

把lib类库作为docker镜像的分层来处理

maven

```xml
<build>
    <plugins>
        <!--设置应用 Main 参数启动依赖查找的地址指向外部 lib 文件夹-->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <configuration>
                <archive>
                    <manifest>
                        <addClasspath>true</addClasspath>
                        <classpathPrefix>lib/</classpathPrefix>
                    </manifest>
                </archive>
            </configuration>
        </plugin>
        <!--设置 SpringBoot 打包插件不包含任何 Jar 依赖包-->
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                 <includes>
                     <include>
                         <groupId>nothing</groupId>
                         <artifactId>nothing</artifactId>
                     </include>
                 </includes>
            </configuration>
        </plugin>
        <!--设置将 lib 拷贝到应用 Jar 外面-->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-dependency-plugin</artifactId>
            <executions>
                <execution>
                    <id>copy-dependencies</id>
                    <phase>prepare-package</phase>
                    <goals>
                        <goal>copy-dependencies</goal>
                    </goals>
                    <configuration>
                        <outputDirectory>${project.build.directory}/lib</outputDirectory>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

Dockerfile

```dockerfile
FROM openjdk:8u212-b04-jre-slim
VOLUME /tmp
COPY target/lib/ ./lib/
ADD target/*.jar app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS="-Duser.timezone=Asia/Shanghai"
ENV APP_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar $APP_OPTS" ]
```

## 思路2

SpringBoot 分层打包

```dockerfile

FROM openjdk:8-jre as builder

WORKDIR application

ADD ./target/*.jar ./app.jar

RUN java -Djarmode=layertools -jar app.jar extract

FROM openjdk:8-jre

MAINTAINER ttzommed@foxmail.com

WORKDIR application

COPY --from=builder application/dependencies/ ./

COPY --from=builder application/spring-boot-loader/ ./

COPY --from=builder application/snapshot-dependencies/ ./

COPY --from=builder application/application/ ./

EXPOSE 36665

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]`
```

## 参考

[Java SpringBoot 项目构建 Docker 镜像调优实践](https://www.cnblogs.com/sanduzxcvbnm/p/13807767.html)
[SpringBoot 分层打包](https://blog.csdn.net/ttzommed/article/details/106759670)
