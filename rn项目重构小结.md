---
title: "react-native项目重构小结"
description: ""
date: 2017-11-30T17:21:29+08:00
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

# 路由选择

以 web 的思想来看，我们选择可以是 SPA 中的 hash 路由或者 html5 的 history 路由，这样也不是不行，页面切换效果就需要我们自己实现，对 view 管控全靠数据来了。

<!--more-->

以 app 的思想来看，页面的管理是通过 view 的堆栈，页面切换可以使用原生的页面切换效果，流畅度好，内存管控也方便。

## 启动页以及持久化登陆

首先 iOS 是有一个启动页的，原生估计可以利用这个过程来处理异步读取缓存的用户信息（android 应该也可以）。不过要消除差异性，还是我们来统一设定启动页比较好。自定义启动页，异步读取数据后，利用 componentDidMount 二次触发，dispatch 数据给导航器，选择跳转的页面。

## 全局变量

使用 es6 包引入方式，会找不到上级页面设置的 global 的变量。需要共享的数据可以通过 redux, asyncStorage, 路由传参的方式（一个黑科技，用 require，运行时候引入，包含了当前执行的环境了，不推荐）

## 一些 tips

1. 路由可以混合使用，eg: tab 与 stock
1. 页面跳转与 redux，先 redux 在跳转
1. `StatusBar`来消除 android 的状态栏默认样式
1. 页面公共组件的状态可以放到 redux 里共享
