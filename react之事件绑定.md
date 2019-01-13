---
title: "react的事件绑定一些方法"
description: ""
date: "2017-08-16T16:04:25+08:00"
author: "uncoder"
tags: ["react"]
categories: ["javascript"]
slug: ""
---

这些写法的性能有差异、

<!--more-->

## 方法声明

```
// 写法1
foo() {}
// 写法2
foo = () => {}
// 写法3
foo = (e) => {
  console.log(e)
}
// 写法4，函数柯里化
foo = (a) => (b) => {
  console.log( a + b);
}
// 写法5，函数柯里化
foo = (a) => {
  此中方式可以直接使用onClick={this.foo('test')}进行传参
  return (b) => {
    console.log(a+b);
  }
}
```

## 绑定

```
// 写法1 无法传递父级this和参数
onClick = {this.foo}
// 写法2 重复绑定
onClick = {() => this.foo()}
// 写法3 重复绑定
onClick = {(e) => this.foo(e)}
// 写法4 es7
onClick = {::this.foo}
// 写法5
onClick = {this.foo(data)}
```

## this 绑定

* 箭头函数会绑定当前组件的 this
* 父级的 foo()通过 props 传到子组件时，foo()的 this 取决于父级的绑定方式
* foo 的语法决定
