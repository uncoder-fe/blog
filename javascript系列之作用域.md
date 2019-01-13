---
title: "Javascript系列之作用域"
description: ""
date: 2016-10-13T16:04:27+08:00
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

# JavaScript Interpreter 解释器

<!--more-->

# Lexical Scope 词法作用域

* 函数 => 一等公民，先解析
* 变量 => undefined，后解析
* var => hosting 提升
* 函数内部不做解析，执行时候解析

* 全局作用域
* 函数作用域(上下文，Block Scope)
* try...catch 中的 error(上下文+块级，Block Scope)
* eval(上下文)
* 闭包(内存作用域)
* IIFE(上下文)
* let、const(块级)
* TDZ(时间死区)

# 运行机制

* 执行环境
* 作用域链
* 执行时依次压入执行栈
* 寻找对象，从内部到外部挨个找
