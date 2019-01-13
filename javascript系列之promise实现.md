---
title: "Javascript系列之promise实现"
description: ""
date: 2018-03-06T10:20:20+08:00
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

Promise 对象用于表示一个异步操作的最终状态（完成或失败），以及其返回的值。

<!--more-->

## 源码传送门：

[click it!](https://github.com/uncoder-/initPage/blob/master/src/page/example/promise.js)

## 关键点

1.  在构造函数中触发第一次回调
2.  在 resolve 中检测返回值是否还是 promise
3.  resolve 和 reject 进行状态、值的更新，以及完成后重新递归队列
4.  then 函数必须返回 promise
5.  handle 方法检测当前状态来执行回调函数，并调用 resolve 和 reject 更新状态
