---
title: PowerShell 常用命令
tags: PowerShell
categories: 
  - PowerShell

thumbnail: /gallery/blue-water3.jpg
---
window环境常常也需要了角的命令
<!-- more -->

## 列出所有端口，并查找点用商品的进程
```
 NETSTAT -aon|findstr "3306"

  TCP    0.0.0.0:3306           0.0.0.0:0              LISTENING       14256
  TCP    [::]:3306              [::]:0                 LISTENING       14256
```
 MYSQL_ALLOW_EMPTY_PASSWORD=yes

## 据进程号查找对应的应用名
```
tasklist | findstr "14256" 

com.docker.backend.exe       14256 Services                   0      9,680 K
```
## 杀进程
```
 taskkill /pid 14256 -f
```