---
title: 为Spring设置restful基础路径
tags: java,spring,restful,base path,基础路径
categories: 
  - java

thumbnail: /gallery/blue-water7.jpg
---

由于某些原因，我们会把前端和后端的放在一个站点上，但如果前后端不做分离的话，随着时间推移代码会难以维护。因此就想把静态内容放和后端的接口分开放置，来达到分离的效果。
<!-- more -->

## 问题

希望spring有如下URL结构  

/index.html – 静态页
/api/user – rest控制器的所有api放在api下

因为是针对所有的RestControllers增加api，而静态页不变，所以有以下两种思路：
* 基于RestController类增加Spring配置
* 重写RestController注解

## 解决方案

### 基于RestController类增加Spring配置

目录结构

```java
@Configuration
public class WebConfig {
 
    @Bean
    public WebMvcRegistrationsAdapter webMvcRegistrationsHandlerMapping() {
        return new WebMvcRegistrationsAdapter() {
            @Override
            public RequestMappingHandlerMapping getRequestMappingHandlerMapping() {
                return new RequestMappingHandlerMapping() {
                    private final static String API_BASE_PATH = "api";
 
                    @Override
                    protected void registerHandlerMethod(Object handler, Method method, RequestMappingInfo mapping) {
                        Class<?> beanType = method.getDeclaringClass();
                        if (AnnotationUtils.findAnnotation(beanType, RestController.class) != null) {
                            PatternsRequestCondition apiPattern = new PatternsRequestCondition(API_BASE_PATH)
                                    .combine(mapping.getPatternsCondition());
 
                            mapping = new RequestMappingInfo(mapping.getName(), apiPattern,
                                    mapping.getMethodsCondition(), mapping.getParamsCondition(),
                                    mapping.getHeadersCondition(), mapping.getConsumesCondition(),
                                    mapping.getProducesCondition(), mapping.getCustomCondition());
                        }
 
                        super.registerHandlerMethod(handler, method, mapping);
                    }
                };
            }
        };
    }
 
}
```

### 重写RestController注解

```java

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@RestController
@RequestMapping
public @interface RestApiController {
 
 @AliasFor(annotation = RequestMapping.class, attribute = "value")
 String[] value();
 
}

@RestApiController("user")
public class UserController {
 
    @RequestMapping
    public User all() {
        User user = new User();
        User.setText("User api");
        return user;
    }
}

```



