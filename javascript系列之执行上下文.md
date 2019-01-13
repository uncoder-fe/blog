---
tags: []
author: "uncoder"
date: "2016-05-18T19:22:09+08:00"
description: ""
title: "javascript系列之执行上下文"
slug: ""
categories: ["javascript"]
---

Execution Contexts

<!--more-->

# 函数预解析

-代码执行前 -首先发生在 window 环境中，函数执行的时候才会对函数中的变量和函数进行预解析
-var 声明的变量的值被赋值为 undefined，函数被声明并且并定义，函数比变量优先级高。 -先声明，后定义。

```
    var a = 'dog';
    等同于
    var a;
    a = 'dog';
```

# Global context 全局上下文

脚本加载完毕后，由 window 和执行代码第一行组成。

# execution context 执行上下文

# eval context
