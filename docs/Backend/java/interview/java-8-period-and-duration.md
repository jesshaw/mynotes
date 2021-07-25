---
title: Java 8中求两日期时间差值的方法
tags: date,duration,period,ChronoUnit,java.time,java8
categories: 
  - java

thumbnail: /gallery/green-water1.jpg
---
Java 7中对日期的差值的计算和本地日期时间不像C#方便，往往需要自己封闭实现一个或引用第三方jar包，至Java 8引进了
<!-- more -->

以下几个例子向您展示了如何使用Java 8 Duration ， Period 和 ChronoUnit 对象来找出时间之间的差值。

1. Duration - 以秒和纳秒为单位计算两时间的差值。
2. Period - 以年，月，日为单位计算两时间的差值。
3. ChronoUnit - 以指定的单位计算两时间的差值。

## 1.Duration示例

java.time.Duration用于查找两个LocalDateTime之间的秒数差值

DurationExample.java
```java
package sanfor.time;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.temporal.ChronoUnit;

public class DurationExample {

    public static void main(String[] args) {

        // Creating Durations
        System.out.println("--- Examples --- ");

        Duration oneHours = Duration.ofHours(1);
        System.out.println(oneHours.getSeconds() + " 秒");

        Duration oneHours2 = Duration.of(1, ChronoUnit.HOURS);
        System.out.println(oneHours2.getSeconds() + " 秒");

        // Test Duration.between
        System.out.println("\n--- Duration.between --- ");

        LocalDateTime oldDate = LocalDateTime.of(2016, Month.AUGUST, 31, 10, 20, 55);
        LocalDateTime newDate = LocalDateTime.of(2016, Month.NOVEMBER, 9, 10, 21, 56);

        System.out.println(oldDate);
        System.out.println(newDate);

        //count seconds between dates
        Duration duration = Duration.between(oldDate, newDate);

        System.out.println(duration.getSeconds() + " 秒");

    }
}
```
输出
```java
--- Examples ---
3600 秒    
3600 秒

--- Duration.between ---
2016-08-31T10:20:55
2016-11-09T10:21:56
6048061 秒
```

## 2.Period示例

java.time.Period用于找出两LocalDate之间年，月或日差值

PeriodExample.java
```java 
package sanfor.time;

import java.time.LocalDate;
import java.time.Month;
import java.time.Period;

public class PeriodExample {

    public static void main(String[] args) {

        System.out.println("--- Examples --- ");

        Period tenDays = Period.ofDays(10);
        System.out.println(tenDays.getDays()); //10

        Period oneYearTwoMonthsThreeDays = Period.of(1, 2, 3);
        System.out.println(oneYearTwoMonthsThreeDays.getYears());   //1
        System.out.println(oneYearTwoMonthsThreeDays.getMonths());  //2
        System.out.println(oneYearTwoMonthsThreeDays.getDays());    //3

        System.out.println("\n--- Period.between --- ");
        LocalDate oldDate = LocalDate.of(1982, Month.AUGUST, 31);
        LocalDate newDate = LocalDate.of(2016, Month.NOVEMBER, 9);

        System.out.println(oldDate);
        System.out.println(newDate);

        // check period between dates
        Period period = Period.between(oldDate, newDate);

        System.out.print(period.getYears() + " 年,");
        System.out.print(period.getMonths() + " 月,");
        System.out.print(period.getDays() + " 日");

    }
}
```
输出
```java
--- Examples ---
10
1
2
3

--- Period.between ---
1982-08-31
2016-11-09
34 年,2 月,9 日
```

 
3. ChronoUnit示例

或者，您可以使用java.time.temporal.ChronoUnit.{unit}.between查找时间或日期之间的任何单位的差值，请查看以下示例：

ChronoUnitExample.java
```java
package sanfor.time;

import java.time.LocalDateTime;
import java.time.Month;
import java.time.temporal.ChronoUnit;

public class ChronoUnitExample {

    public static void main(String[] args) {

        LocalDateTime oldDate = LocalDateTime.of(1982, Month.AUGUST, 31, 10, 20, 55);
        LocalDateTime newDate = LocalDateTime.of(2016, Month.NOVEMBER, 9, 10, 21, 56);

        System.out.println(oldDate);
        System.out.println(newDate);

        // count between dates
        long years = ChronoUnit.YEARS.between(oldDate, newDate);
        long months = ChronoUnit.MONTHS.between(oldDate, newDate);
        long weeks = ChronoUnit.WEEKS.between(oldDate, newDate);
        long days = ChronoUnit.DAYS.between(oldDate, newDate);
        long hours = ChronoUnit.HOURS.between(oldDate, newDate);
        long minutes = ChronoUnit.MINUTES.between(oldDate, newDate);
        long seconds = ChronoUnit.SECONDS.between(oldDate, newDate);
        long milis = ChronoUnit.MILLIS.between(oldDate, newDate);
        long nano = ChronoUnit.NANOS.between(oldDate, newDate);

        System.out.println("\n--- 总计 --- ");
        System.out.println(years + " 年");
        System.out.println(months + " 月");
        System.out.println(weeks + " 周");
        System.out.println(days + " 日");
        System.out.println(hours + " 时");
        System.out.println(minutes + " 分");
        System.out.println(seconds + " 秒");
        System.out.println(milis + " 毫秒");
        System.out.println(nano + " 纳秒");

    }
}
```
输出
```java
1982-08-31T10:20:55
2016-11-09T10:21:56

--- 总计 ---
34 年
410 月
1784 周
12489 日
299736 时
17984161 分
1079049661 秒
1079049661000 毫秒
1079049661000000000 纳秒
```

## 引用
1. [Oracle教程 - Period和Duration](https://docs.oracle.com/javase/tutorial/datetime/iso/period.html)
2. [Duration Java文档](https://docs.oracle.com/javase/8/docs/api/java/time/Duration.html)
3. [Period Java文档](https://docs.oracle.com/javase/8/docs/api/java/time/Period.html)
4. [ChronoUnit Java文档](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/ChronoUnit.html)