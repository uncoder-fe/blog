---
author: "uncoder"
date: "2016-02-06T15:31:46+08:00"
description: ""
title: "javascript系列之函数闭包"
slug: ""
categories: ["javascript"]
tags: []
---

一句话概括下，外部函数可以访问内部函数的自由变量。

<!--more-->

* 由函数执行时候的环境以及内部自由变量组成
* 看起来像是一个半 lambda 的函数结构
* 可以隔离内部作用域，通过返回的方法来修改内部的数据
* 通常会使用一个变量被赋值来持久保存闭包
* 闭包让我们能够从一个函数内部访问其外部函数的作用域
* 外部函数访问内部函数的自由变量

```javascript
function foo() {
	// 使用匿名函数构成闭包
	let bb = (function() {
		this.cacheStr = '我是闭包内部的自由变量';
		return {
			getStr: () => this.cacheStr,
			setStr: newStr => {
				this.cacheStr = newStr;
			}
		};
	})();
	// 当前执行作用域代指外部函数
	// 访问闭包
	console.log(bb.getStr()); // 打印  我是闭包内部的自由变量
	// 修改闭包的数据
	bb.setStr('我是闭包内部的自由变量，新的值');
	console.log(bb.getStr()); // 打印  我是闭包内部的自由变量，新的值
	// 释放闭包
	bb = null;
}

foo();
```