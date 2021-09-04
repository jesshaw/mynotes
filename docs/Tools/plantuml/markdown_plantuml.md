# Markdown与PlantUML

## 需求

怎样在Markdown中快速绘制软件图，同时导出不同但基本一致的文档，图符合公司的风格

## 初识PlantUML

渲，用编码的方式绘图，生态良好。可自定风格

## 进阶

实际使用中，仅画图，然后嵌套到markdwon或是html等中，操作有些繁琐，总体认为vscode插件应当有更好的机制做到。

### [PlantUML插件](https://www.plantuml.com/)

UML绘图工具插件

**原因**： 单独用来在vscode中画Plant UML图。

### [Markdown Preview Enhanced插件](https://github.com/shd101wyy/vscode-markdown-preview-enhanced)

Markdown预览插件

**原因**： 所见即所得，关键还可以导出pdf等不同格式的标准文档

### 使用的困惑

Markdown Preview Enhanced和PlantUML或有渲染Plant UML的功能，但是他俩的**功能并不使用同一个，版本大概率不相同**。因此所见即所得还是有点差别。

Markdown Preview Enhanced仅支持本地jar包方案，且还是自带的jar包。

PlantUML支持两种渲染方式即，本地jar包方案渲染和远程服务方式。

由于上述原因必须通过**version方式确认版本，用于排除版本不一致的问题**

## 解决方案

引入全局公用Plant UML类库[C4-PlantUML](https://github.com/plantuml-stdlib/C4-PlantUML)

Plant Sever引入当前最新版的C4,通过指定文件挂载的方式加载。JAVA_OPTS中的3个参数缺一不可

```yml
version: "2"
services:
  plantuml: #服务名任意取
    networks:
    - mynet
    restart: always
    image: plantuml/plantuml-server:tomcat-v1.2021.4
    environment:
      - "JAVA_OPTS=-DALLOW_PLANTUML_INCLUDE=true -Dplantuml.include.path=/usr/local/tomcat/webapps/lib -Dplantuml.includeSearch=Relative"
    volumes:
        - ./lib:/usr/local/tomcat/webapps/lib
    ports:
    - "8075:8080"
networks:
  mynet:
    external: true
```

Markdown Preview Enhanced指定到同样的位置即可，因为该插件未明确指定怎样设置plantuml.include.path。于是得看[puml.ts源码](https://github.com/shd101wyy/mume/blob/master/src/puml.ts)最终确定对应设置为configPath。设置完成之后一定要重启vscode。

```json
{
  "markdown-preview-enhanced.configPath": "C:\\projects\\github\\javasample\\docker\\plantuml-server\\lib"
}
```


