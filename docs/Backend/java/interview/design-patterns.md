# 设计模式

在Java的面试中，设计模式是一个经常被问到的话题。下面是一些常见的设计模式面试题及其解答：

## 1. **什么是设计模式？设计模式的分类有哪些？**

**回答**：设计模式是针对特定问题的最佳实践解决方案，提供了一种简化开发过程的通用方法。设计模式主要分为三类：

- **创建型模式**：关注对象的创建，常见模式有单例模式、工厂模式、建造者模式、原型模式等。
- **结构型模式**：关注类和对象的组合，常见模式有适配器模式、装饰器模式、代理模式、外观模式、组合模式等。
- **行为型模式**：关注对象之间的交互，常见模式有观察者模式、策略模式、命令模式、状态模式、访问者模式等。

## 2. **单例模式的实现方式？懒汉式与饿汉式的区别？**

**回答**：单例模式确保一个类只有一个实例，并提供全局访问点。

- 饿汉式：在类加载时就实例化对象，线程安全，但不够灵活。
- 懒汉式：在需要时才实例化对象，延迟加载，但需处理线程安全问题。

## 3. **如何实现线程安全的单例模式？双重检查锁定与静态内部类实现？**

**回答**：双重检查锁定可以在获取实例时减少锁的开销。

- 示例（双重检查锁定）：

```java
public class Singleton {
    private static volatile Singleton instance;
    private Singleton() {}
    public static Singleton getInstance() {
        if (instance == null) {
            synchronized (Singleton.class) {
                if (instance == null) {
                    instance = new Singleton();
                }
            }
        }
        return instance;
    }
}
```
- 示例（静态内部类）：

```java
public class Singleton {
    private Singleton() {}
    private static class Holder {
        private static final Singleton INSTANCE = new Singleton();
    }
    public static Singleton getInstance() {
        return Holder.INSTANCE;
    }
}
```

## 4. **工厂方法模式和抽象工厂模式的区别？**

**回答**：

- 工厂方法模式允许子类决定实例化哪个类，提供一个创建对象的接口，但不暴露具体类的实现。
- 抽象工厂模式提供一个接口，用于创建相关或依赖对象的家族，而无需指定具体类。

## 5. **在什么场景下适合使用工厂模式？**

**回答**：当系统需要独立于创建、组合和表示的类，或需要提供一个接口来创建对象时，适合使用工厂模式。例如，框架中需要创建不同的实现类。


## 6. **工厂模式和建造者模式的区别？**

**回答**：

- 工厂模式主要用于创建单一对象，通常返回相同类型的对象。
- 建造者模式用于创建复杂对象，允许分步骤构建。

## 7. **什么是原型模式？如何实现原型模式？**

**回答**：原型模式通过复制已有对象来创建新对象，避免创建对象的开销。实现方法是通过实现 `Cloneable` 接口，重写 `clone()` 方法。

- 示例：

```java
class Prototype implements Cloneable {
    public Prototype clone() throws CloneNotSupportedException {
        return (Prototype) super.clone();
    }
}
```

## 8. **什么是深拷贝和浅拷贝？如何在原型模式中实现深拷贝？**

**回答**：浅拷贝复制对象及其基本数据类型，但引用类型仍指向同一内存地址。深拷贝则复制对象及其引用类型，两个对象完全独立。

- 深拷贝实现通常需手动复制引用对象。
- 示例：

```java
class DeepPrototype implements Cloneable {
    private List<String> list;
    public DeepPrototype() { list = new ArrayList<>(); }
    public DeepPrototype clone() throws CloneNotSupportedException {
        DeepPrototype copy = (DeepPrototype) super.clone();
        copy.list = new ArrayList<>(this.list);
        return copy;
    }
}
```

## 9. **适配器模式的应用场景是什么？如何实现适配器模式？**

**回答**：适配器模式用于将一个接口转换为另一个接口，使得不兼容的接口可以一起工作。常见于需要与现有代码库集成时。

- 示例：

```java
interface Target {
    void request();
}
class Adaptee {
    void specificRequest() {}
}
class Adapter implements Target {
    private Adaptee adaptee;
    public Adapter(Adaptee adaptee) { this.adaptee = adaptee; }
    public void request() { adaptee.specificRequest(); }
}
```

## 10. **适配器模式和外观模式的区别？**

**回答**：适配器模式用于将不兼容的接口适配在一起，而外观模式提供一个简单的接口，简化与复杂子系统的交互。**适配器关注接口的适配，外观关注简化。**


## 11. **外观模式的应用场景是什么？如何实现外观模式？**

**回答**：外观模式用于提供一个简化的接口来访问复杂的子系统，常用于减少系统复杂度。

- 示例：

```java
class SubsystemA {
    void operationA() {}
}
class SubsystemB {
    void operationB() {}
}
class Facade {
    private SubsystemA a;
    private SubsystemB b;
    public Facade() { a = new SubsystemA(); b = new SubsystemB(); }
    public void operation() {
        a.operationA();
        b.operationB();
    }
}
```

## 12. **桥接模式的优点是什么？与适配器模式的区别？**

**回答**：桥接模式将抽象与实现分离，允许独立扩展。**适配器模式用于将不兼容的接口连接在一起，桥接模式关注于功能的灵活扩展**。

## 13. **什么是组合模式？组合模式的优点是什么？**

**回答**：组合模式允许将对象组合成树形结构以表示部分-整体层次。优点是客户端可以以统一的方式处理单个对象和组合对象，简化了客户端代码。

## 14. **组合模式和装饰器模式的区别？**

**回答**：**组合模式**用于处理部分与整体的关系，**强调树形结构**；**装饰器模式**用于动态地扩展对象的功能，**强调功能的增强**。


## 15. **装饰器模式的应用场景是什么？如何实现装饰器模式？**

**回答**：装饰器模式用于动态添加功能到对象，常见于需要扩展对象行为而不改变其接口的场景。

- 示例：

```java
interface Component {
    void operation();
}
class ConcreteComponent implements Component {
    public void operation() {}
}
class Decorator implements Component {
    private Component component;
    public Decorator(Component component) { this.component = component; }
    public void operation() {
        component.operation();
        // 添加额外功能
    }
}
```

## 16. **代理模式的作用是什么？常见的代理模式应用？**

**回答**：代理模式提供了一个代表另一个对象的接口，控制对该对象的访问。常见应用有虚拟代理（延迟加载）、保护代理（访问控制）和远程代理（网络访
问）。

## 17. **静态代理和动态代理的区别？如何实现动态代理？**

**回答**：

- 静态代理在编译时决定代理类，代码固定。
- 动态代理在运行时生成代理类，灵活性高。
- 动态代理示例（使用Java反射）：

```java
interface Subject {
    void request();
}
class RealSubject implements Subject {
    public void request() {}
}
class ProxyHandler implements InvocationHandler {
    private Object target;
    public ProxyHandler(Object target) { this.target = target; }
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        return method.invoke(target, args);
    }
}
```

## 18. **在Java中如何使用反射实现动态代理？**

**回答**：使用 `Proxy` 类和 `InvocationHandler` 接口，通过反射机制在运行时生成代理对象。

- 示例：

```java
Subject proxy = (Subject) Proxy.newProxyInstance(
    Subject.class.getClassLoader(),
    new Class[]{Subject.class},
    new ProxyHandler(new RealSubject())
);
```

## 19. **Spring AOP使用了哪种代理模式？为什么选择该模式？**

**回答**：Spring AOP主要使用动态代理模式（JDK动态代理或CGLIB代理），选择动态代理是因为它能够在运行时创建代理对象，提供更高的灵活性和可扩展性。

## 20. **什么是责任链模式？如何实现责任链模式？**

**回答**：责任链模式通过将请求沿链传递，直到某个处理者处理该请求。实现时每个处理者持有对下一个处理者的引用。

- 示例：

```java
abstract class Handler {
    protected Handler next;
    public void setNext(Handler next) { this.next = next; }
    public abstract void handleRequest(int request);
}
```

## 21. **责任链模式的优缺点是什么？**

**回答**：

- 优点：降低耦合，简化请求发送者与处理者之间的关系；灵活性高，可以动态调整处理链。
- 缺点：可能导致请求未被处理，难以追踪链中的处理者。

## 22. **观察者模式的应用场景是什么？如何实现观察者模式？**

**回答**：观察者模式用于一对多的依赖关系，常见于事件监听机制。实现时主题持有观察者列表，状态变化时通知所有观察者。

- 示例：

```java
interface Observer {
    void update();
}
class Subject {
    private List<Observer> observers = new ArrayList<>();
    public void addObserver(Observer observer) { observers.add(observer); }
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update();
        }
    }
}
```

## 23. **在Java中如何实现异步观察者模式？**

**回答**：可以使用线程池来异步通知观察者。

- 示例：

```java
public void notifyObservers() {
    for (Observer observer : observers) {
        new Thread(() -> observer.update()).start();
    }
}
```

## 24. **什么是发布-订阅模式？与观察者模式的区别？**

**回答**：发布-订阅模式是一种消息传递模式，发布者与订阅者之间不直接交互，通过中间的消息代理进行通信。观察者模式是具体实现，适用于一对多的关系。

## 25. **什么是命令模式？如何实现命令模式？**

**回答**：命令模式将请求封装为对象，以便参数化客户、请求队列或日志请求。可以通过执行命令的对象来实现。

- 示例：

```java
interface Command {
    void execute();
}
class ConcreteCommand implements Command {
    private Receiver receiver;
    public ConcreteCommand(Receiver receiver) { this.receiver = receiver; }
    public void execute() { receiver.action(); }
}
```

## 26. **命令模式的优缺点是什么？应用场景有哪些？**

**回答**：

- 优点：解耦请求的发送者和接收者，支持撤销和恢复操作。
- 缺点：增加了系统的复杂性。
- 应用场景：操作记录、事务管理等。

## 27. **策略模式的应用场景是什么？如何实现策略模式？**

**回答**：策略模式用于动态选择算法，通常在需要多个可替换算法时使用。

- 示例：

```java
interface Strategy {
    void execute();
}
class Context {
    private Strategy strategy;
    public Context(Strategy strategy) { this.strategy = strategy; }
    public void executeStrategy() { strategy.execute(); }
}
```

## 28. **策略模式与状态模式的区别？**

**回答**：**策略模式**用于定义一系列算法，**并在运行时选择**(算法)；**状态模式**用于对象的状态变化，并在**状态改变时改变其行为**。


## 29. **什么是状态模式？如何实现状态模式？**

**回答**：状态模式允许对象在其内部状态改变时改变其行为，通常通过状态类来实现。

- 示例：

```java
interface State {
    void handle();
}
class Context {
    private State state;
    public void setState(State state) { this.state = state; }
    public void request() { state.handle(); }
}
```

## 30. **状态模式的优缺点是什么？在什么情况下使用？**

**回答**：

- **优点**：简化复杂状态转换的代码，提高代码的可读性和可维护性。
- **缺点**：增加了类的数量，可能导致系统复杂性增加。
- **使用场景**：状态变化频繁的对象。

## 31. **解释模板方法模式的作用及实现？**

**回答**：模板方法模式定义了算法的骨架，并允许子类实现具体的步骤。通过继承来扩展行为。

- 示例：

```java
abstract class AbstractClass {
    public final void templateMethod() {
        step1();
        step2();
    }
    protected abstract void step1();
    protected abstract void step2();
}
```

## 32. **模板方法模式与策略模式的区别？**

**回答**：模板方法模式关注算法的结构与步骤，而策略模式则侧重于实现多个算法并在运行时选择。


## 33. **访问者模式的作用是什么？如何实现访问者模式？**

**回答**：访问者模式用于将操作封装到一个独立的对象中，便于添加新的操作。

- 示例：

```java
interface Visitor {
    void visit(Element element);
}
interface Element {
    void accept(Visitor visitor);
}
```

## 34. **访问者模式与迭代器模式的区别？**

**回答**：**访问者模式**关注**操作与对象结构的解耦**，允许在**不改变对象结构的情况下添加新操作**；迭代器模式用于遍历对象集合。


## 35. **在Java中如何实现迭代器模式？常见应用场景？**

**回答**：迭代器模式提供一种访问聚合对象元素的方法，而无需暴露其内部表示。

- 示例：

```java
interface Iterator {
    boolean hasNext();
    Object next();
}
interface Aggregate {
    Iterator createIterator();
}
```

## 36. **什么是中介者模式？如何实现中介者模式？**

**回答**：中介者模式通过一个中介者对象来控制各个对象之间的交互，降低对象之间的耦合。

- 示例：

```java
class Mediator {
    private Colleague colleague1;
    private Colleague colleague2;
    public void setColleague1(Colleague colleague1) { this.colleague1 = colleague1; }
    public void setColleague2(Colleague colleague2) { this.colleague2 = colleague2; }
    public void mediate() { /* 中介逻辑 */ }
}
```

## 37. **中介者模式的优缺点是什么？**

**回答**：

- 优点：降低了对象之间的耦合，便于维护和扩展。
- 缺点：中介者过于复杂时，可能导致系统难以理解。

## 38. **备忘录模式的作用是什么？如何实现备忘录模式？**

**回答**：备忘录模式用于保存对象的状态，以便在需要时恢复。

- 示例：

```java
class Originator {
    private String state;
    public Memento saveState() { return new Memento(state); }
    public void restoreState(Memento memento) { state = memento.getState(); }
}
class Memento {
    private String state;
    public Memento(String state) { this.state = state; }
    public String getState() { return state; }
}
```

## 39. **在什么情况下使用备忘录模式？**

**回答**：在需要保存和恢复对象状态的场景，如撤销操作、游戏进度保存等。


## 40. **什么是享元模式？如何实现享元模式？**

**回答**：享元模式通过共享对象来减少内存使用，适用于大量相似对象的场景。

- 示例：

```java
class Flyweight {
    private String intrinsicState;
    public Flyweight(String state) { intrinsicState = state; }
}
class FlyweightFactory {
    private Map<String, Flyweight> pool = new HashMap<>();
    public Flyweight getFlyweight(String key) {
        return pool.computeIfAbsent(key, Flyweight::new);
    }
}
```

## 41. **享元模式的优缺点？适用场景有哪些？**

**回答**：

- 优点：减少了内存使用，提升了性能。
- 缺点：增加了系统复杂性，管理共享对象的逻辑可能复杂。
- 适用场景：大量相似对象的应用，如文本处理、图形界面等。

## 42. **MVC 模式的结构和实现？**

**回答**：MVC 模式分为模型（Model）、视图（View）、控制器（Controller）三部分。模型处理数据逻辑


，视图显示数据，控制器负责处理用户输入。
- 示例：

```java
class Model {
    private String data;
    public String getData() { return data; }
    public void setData(String data) { this.data = data; }
}
class View {
    public void display(String data) { /* 显示数据 */ }
}
class Controller {
    private Model model;
    private View view;
    public Controller(Model model, View view) { this.model = model; this.view = view; }
    public void updateView() { view.display(model.getData()); }
}
```

## 43. **MVC 模式与 MVVM 模式的区别？**

**回答**：MVC 模式中控制器处理用户输入并更新模型，而 MVVM 模式中视图模型处理用户输入并绑定到视图，支持双向数据绑定。

## 44. **什么是桥接模式？如何实现桥接模式？**

**回答**：桥接模式将抽象与实现解耦，使两者可以独立变化。通过引入抽象类和实现类。

- 示例：

```java
abstract class Abstraction {
    protected Implementor implementor;
    public Abstraction(Implementor implementor) { this.implementor = implementor; }
    public abstract void operation();
}
interface Implementor {
    void implementation();
}
```

## 45. **桥接模式的优缺点及应用场景？**

**回答**：

- 优点：可以分离抽象和实现，支持多重变化。
- 缺点：系统复杂度增加，难以理解。
- 应用场景：需要将实现与抽象分离的场景，如图形绘制框架。

## 46. **组合模式的作用是什么？如何实现组合模式？**

**回答**：组合模式允许用户以树形结构组合对象，使其表现为单一对象。适用于需要处理部分-整体层次的场景。

- 示例：

```java
interface Component {
    void operation();
}
class Leaf implements Component {
    public void operation() { /* 叶子节点操作 */ }
}
class Composite implements Component {
    private List<Component> children = new ArrayList<>();
    public void operation() { /* 组合节点操作 */ }
}
```

## 47. **迭代器模式的优缺点是什么？**

**回答**：

- 优点：封装了遍历集合的算法，简化了集合的使用。
- 缺点：增加了类的数量。

## 48. **观察者模式的优缺点是什么？**

**回答**：

- 优点：降低了主题与观察者之间的耦合，支持动态添加和移除观察者。
- 缺点：如果观察者较多，通知开销较大。
