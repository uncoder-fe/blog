---
title: "javascript系列之jsbridge的原理"
description: ""
date: 2018-05-16T15:27:33+08:00
author: "uncoder-fe"
tags: []
categories: ["其他"]
slug: ""
---

一个很老的技术了，记得第一次用这个时候，是在网页上唤醒 app 用的。

<!--more-->

# URL Scheme

现象是原生可以拦截请求`window.location.href / iframe`,通过规则，来相互调用，为被动方式。

# 原生注入

我们原生向`window`中注入声明可以使用的方法`window.xxxxxx`，主动。
