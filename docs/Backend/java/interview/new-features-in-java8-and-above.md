# Java 8及以上新特性

以下是 Java 8 及以上新特性的常用面试题及答案，涵盖了 Java 8、Java 9、Java 10、Java 11、Java 12 及更高版本中的一些重要更新，帮助深入理解新特性。

## 1. **什么是 Lambda 表达式？为什么需要它？**

**答案**：  

- **Lambda 表达式** 是一种新的匿名函数写法，能简化代码，增强可读性，尤其在集合的流式操作和函数式编程中使用。
- 它的格式为 `(参数) -> { 表达式 }`，例如：`(x, y) -> x + y`。
- **使用 Lambda 表达式的优势**：主要是减少样板代码，使代码简洁并提高效率，尤其适合单方法接口（即函数式接口）。

## 2. **如何使用 Stream API 操作集合？**

**答案**：

- `Stream API` 提供了一种函数式编程方式来操作数据集合，可以进行筛选、映射、排序、聚合等。
- 示例代码：

```java
List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "David");
List<String> filteredNames = names.stream()
                                    .filter(name -> name.startsWith("A"))
                                    .sorted()
                                    .collect(Collectors.toList());
```

- **解释**：`filter()` 用于筛选元素，`sorted()` 用于排序，`collect()` 用于收集结果。

## 3. **Stream 中的 `map` 和 `flatMap` 有什么区别？**

**答案**：

- `map()` 用于一对一的映射关系，将流中每个元素应用一个函数返回一个元素。
- `flatMap()` 用于一对多的映射关系，将每个元素转换为一个流，并将多个流合并为一个流。
- 示例代码：

```java
List<List<Integer>> numbers = Arrays.asList(Arrays.asList(1, 2), Arrays.asList(3, 4));
List<Integer> flatMapResult = numbers.stream()
                                    .flatMap(List::stream)
                                    .collect(Collectors.toList());
```

## 4. **Optional 类的作用是什么？如何使用？**

**答案**：

- `Optional` 是一个容器类，旨在避免 `NullPointerException`。
- 示例代码：

```java
Optional<String> name = Optional.of("Alice");
name.ifPresent(System.out::println); // 若有值则打印
System.out.println(name.orElse("Default")); // 若无值则返回默认值
```

- `Optional` 常用方法包括 `of()`、`ofNullable()`、`get()`、`isPresent()`、`orElse()`。

## 5. **Java 8 的默认方法是什么？为什么引入？**

**答案**：

- **默认方法**（`default` methods）是接口中的带实现的方法，通过在方法前加 `default` 关键字实现。
- 引入原因是为了接口的向后兼容，允许在接口中添加新方法而不影响已有实现。
- 示例代码：

```java
interface Vehicle {
    default void start() {
        System.out.println("Starting...");
    }
}
```

## 6. **Java 9 引入的模块系统有什么用？**

**答案**：

- Java 9 的模块化系统（Project Jigsaw）将 JDK 库分为多个模块，提升了代码结构和可维护性，支持更高的可扩展性和性能优化。
- 使用 `module-info.java` 定义模块并声明依赖关系。
- 示例代码：

```java
module com.example {
    requires java.base;
    exports com.example.service;
}
```

## 7. **什么是 `var` 关键字？在哪些情况下可以使用？**

**答案**：

- `var` 是 Java 10 引入的局部变量类型推断关键字，可以简化代码，变量类型由编译器自动推断。
- 只能用于局部变量（方法内），不适用于成员变量、方法参数等。
- 示例代码：

```java
var list = new ArrayList<String>(); // 编译器推断为 ArrayList<String>
```

## 8. **Java 11 中 `String` 类新增了哪些常用方法？**

**答案**：

- Java 11 新增了如下 `String` 方法：
- `isBlank()`：判断字符串是否为空或仅包含空白字符。
- `strip()`：去除前后空白字符。
- `lines()`：将字符串按行分割为流。
- `repeat(int n)`：重复字符串 n 次。
- 示例代码：

```java
String text = " Hello ";
System.out.println(text.isBlank());  // false
System.out.println(text.strip());    // "Hello"
System.out.println("Hello\nWorld".lines().count()); // 2
```

## 9. **Java 14 中的 `record` 关键字的用途是什么？**

**答案**：

- `record` 是 Java 14 引入的一种简化数据类的关键字，用于定义不可变的数据载体，自动生成构造方法、`equals()`、`hashCode()` 和 `toString()`。
- 示例代码：

```java
public record Point(int x, int y) {}
Point p = new Point(3, 4);
```

## 10. **什么是 `Text Blocks`？**

**答案**：

- **Text Blocks** 是 Java 13 引入并在 Java 15 正式发布的一种多行字符串表示方式，用于简化多行字符串编写。
- 使用 `"""` 包围多行文本内容，无需手动处理换行符。
- 示例代码：

```java
String json = """
        {
            "name": "Alice",
            "age": 30
        }
        """;
```

## 11. **Java 8 中的 `CompletableFuture` 有什么用？**

**答案**：

- `CompletableFuture` 提供了一种更简单的异步编程方式，支持链式调用和回调，避免了传统 `Future` 的阻塞。
- 常用方法包括 `supplyAsync()`、`thenApply()`、`thenAccept()` 等。
- 示例代码：

```java
CompletableFuture.supplyAsync(() -> "Hello")
        .thenApply(result -> result + " World")
        .thenAccept(System.out::println);  // 输出 "Hello World"
```

## 12. **Java 9 中的 `Flow API` 是什么？**

**答案**：

- `Flow API` 实现了 Reactive Streams 规范，支持响应式编程。
- 包含四个主要接口：`Publisher`、`Subscriber`、`Subscription` 和 `Processor`，用于处理异步数据流。
- 示例代码：

```java
SubmissionPublisher<String> publisher = new SubmissionPublisher<>();
publisher.subscribe(new Flow.Subscriber<>() {
    @Override
    public void onSubscribe(Flow.Subscription subscription) {
        subscription.request(1);
    }
    @Override
    public void onNext(String item) {
        System.out.println("Received: " + item);
    }
    @Override
    public void onError(Throwable throwable) {
        throwable.printStackTrace();
    }
    @Override
    public void onComplete() {
        System.out.println("Completed");
    }
});
publisher.submit("Hello");
publisher.close();
```

这些问题和答案能够涵盖 Java 8 及更高版本中的关键新特性，展示了各特性如何提升代码简洁性、可读性和性能。