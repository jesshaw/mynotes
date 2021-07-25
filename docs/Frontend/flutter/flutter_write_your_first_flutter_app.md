---
title: 写我的首个flutter app
tags: flutter, config
categories: 
  - flutter

thumbnail: /gallery/blue-water2.jpg

---
flutter良好的性能和同时开发android和ios的app的功能吸引了我，说是首个这里主要把碰到问题记录下

<!-- more -->

## 1. 安装flutter
参照[官网安装教程](https://flutter.dev/docs/get-started/install)在ios和windows环境都正常顺利安装。因为升级方便，更推荐使用[仓库](https://github.com/flutter/flutter)的方式安装

## 2. 安装Android Studio

官方推荐的开发工具，安装会顺带安装最新版的Android SDK。

对于window环境，需要手动配置以下系统环境变量，推荐手动的原因是命令工具会带来诸多问题。

**一定要先备份Path路径**
```
ANDROID_HOME Path\to\Android\Sdk
Path 
%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\tools
```
## 3. 安装模拟器

**对于windows环境若安装了docker，则不能安装模拟器，因为Hyper-V功能冲突，docker需要打开，而模拟器需要关闭**，因此建议使用真机调试。

## 4. 安装flutter和Dart插件

启动Android Studio,从路径(macOS上Preferences > Plugins,Windows & Linux上 File > Settings > Plugins)安装后重启。

## 5. 引导方式创建一个flutter app
鉴于国内环境，通常来讲run时会跑不起来，有99%的可能是镜像配置的原因导致

gradle镜像配置可直接参考[阿里云maven镜像](https://help.aliyun.com/document_detail/102512.html?spm=a2c40.aliyun_maven_repo.0.0.361865e9QA5BoI)进行配置
```gradle
buildscript {
    repositories {
        maven { url 'https://maven.aliyun.com/repository/public/'}
        maven { url 'https://maven.aliyun.com/repository/google/'}
        maven { url 'https://maven.aliyun.com/repository/jcenter/'}
        google()
        jcenter()
    }
}
allprojects {
    repositories {
        maven { url 'https://maven.aliyun.com/repository/public/'}
        maven { url 'https://maven.aliyun.com/repository/google/'}
        maven { url 'https://maven.aliyun.com/repository/jcenter/'}
        google()
        jcenter()
    }
}
```
## 6. 运行run按键即创建成功了首个flutter app

## 引用
[官网写第一个flutter app](https://flutter.dev/docs/get-started/codelab)


