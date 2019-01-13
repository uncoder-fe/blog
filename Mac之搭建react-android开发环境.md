---
title: "Mac之搭建react-android开发环境"
date: "2016-04-05T15:23:03+08:00"
author: "uncoder"
tags: []
categories: ["其他"]
slug: ""
---

跟着官方的文档走，android环境配置以及模拟器的安装
<!--more-->

### 安装jdk，sdk
#### 1,jdk下载一个包一路下一步就可以了;
#### 2,安装sdk,我这里是离线下载的`android-sdk-mac_x86.zip`;

(1)解压到`./common/android-sdk`;
(2)由于我使用的是`ohmyzsh`,需手动加入path，修改`.zshrc`文件而不是用户的`.bash_profile`,导入

```
export ANDROID_HOME=/common/android-sdk;
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

,然后使用`. .zshrc`生效;
#### (3)然后执行`android`启动Android SDK Manger;
#### (4)安装包

```
 Android SDK Build-tools version 23.0.1;
 Android 6.0 (API 23);Android Support Repository;
 Intel x86 Atom System Image (for Android 5.1.1 - API 22);
 Intel x86 Emulator Accelerator (HAXM installer)
```
#### (5)终端进入

```
/common/android-sdk/extras/intel/Hardware_Accelerated_Execution_Manager/
```

,手工安装`IntelHAXM_1.1.4.dmg`;
#### (6)新建一个虚拟机，跑起来`android avd`;
#### (7)虚拟机配置勾选一个选项
### 安装react依赖包

 1,全局安装`npm install -g react-native-cli` 
 2,初始化一个项目`react-native init xxxxxx`
 3,进入项目执行`react-native run-android`

备注：
1，确保虚拟机已经运行
2，进去虚拟机的应用管理找xxxxxx应用
3，如果报错，重启试试
