# Java高级

## JDBC如何实现对事务的控制及事务边界

JDBC对事务的操作是基于Connection来进行控制的，具体代码如下：

```java

try {
   //开启事务
   connection.setAutoCommit(false);
   //做业务操作
   //doSomething();
   //提交事务
   connection.commit();

}catch(Exception e){
   //回滚事务
   try {
      connection.rollback();
   } catch (SQLException e1) {
      e1.printStackTrace();
   }

}
```

但，注意，事务的边界我们是放在业务层进行控制，因为业务层通常包含多个dao层的操作。
