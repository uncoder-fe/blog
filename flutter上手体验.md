---
title: "flutter上手体验"
description: ""
date: 2018-03-19T15:28:20+08:00
author: "uncoder"
tags: ["flutter"]
categories: ["前端相关"]
slug: ""
---

对原生了解和开发过rn项目的话上手还是蛮快的，熟悉一下数据结构，语法类似java和js的混写。

<!--more-->

# SDK下载安装

官方直接下载[zip](https://flutter.io/sdk-archive/#macos)包。

# 配置环境变量

```bash
export PATH=$HOME/your_folder/flutter/bin/:$PATH
```

# 检查环境

```bash
flutter doctor（大陆不支持，需要shell挂代理）
```

# 安装 vscode 插件

插件安装 `dart code`

# 初始化一个项目

```bash
flutter create myapp
```

# MaterialApp

使用材料设计的应用程序。

# material library材料库

1. Scaffold class, 基础布局类。
2. Material class, 一块材料。

# widgets library 小部件库

Flutter小部件

1. Navigator class, 一个小部件，用于管理一组具有堆栈规则的子小部件。
1. Flex class, 以一维数组显示其子项的小部件。
1. Row class, 一个以水平数组显示其子项的小部件。
1. Column class, 以垂直阵列显示其子项的小部件。
1. Expanded class, 展开Row，Column或Flex的子项的小部件。
1. Flexible class, 控制Row，Column或Flex的孩子如何弯曲的小部件。
1. Container class,一个方便的小部件，结合了常见的绘画，定位和尺寸小部件。
1. Align class, 一个小部件，它自己在自己的孩子中排列，并根据小孩的大小自行选择大小。

# services library

平台服务暴露给Flutter应用程序。