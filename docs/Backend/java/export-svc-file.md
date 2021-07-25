---
title: 导出csv文件注意事项
tags: csv,excel
categories: 
  - others

thumbnail: /gallery/blue-water12.jpg
---

web应用系统开发或多或少的会涉及到导出csv文件，用于excel打开，本文件总结了一些注意事项和解决方法。

<!-- more -->

## 1. 列与列这间逗号分隔

逗号必须为半角逗号的形式

## 2. 第一行标题列

## 3. 列值放在双引号内

避免因列值存在逗号而出现错行

## 4. 设置ContentType为"application/csv; charset=UTF-8"

非英文环境必须设置为UTF-8

## 5. 设置Header的"Content-Disposition"为"attachment; filename=ctripCancelOrders.csv"

## 6. 不同应用环境中需要考虑写入编码

例如在java中需要加入以下特殊输入，才能让excel打开时没有乱码

```java
outputStream.write(new String(new byte[] { (byte) 0xEF, (byte) 0xBB,(byte) 0xBF }));
```




