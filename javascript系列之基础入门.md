---
title: "Javascript系列之基础入门"
description: ""
date: 2018-05-16T17:11:52+08:00
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

你没看错，基础知识入门。

<!--more-->

# 语句

在JavaScript中，指令被称为语句，并用分号(;)分隔。代码文本是从左到右扫描，并将其转换成由tokens（不可分割的词法单位）、控制字符、行终止符、注释或空白符组成的输入元素序列。

# 6种原始数据类型

`Boolean, null(小写), undefined(小写), Number, String, Symbol`

不是对象且没有方法。
```js
var a = new Number(123)
var b = 123;
console.log(a === b); // false
console.log(typeof a, typeof b); // object, number
console.log('toString' in a); // true
// console.log('toString' in b); 报错，因为原始类型（Primitive types）没有方法。
console.log(b.toString()); //运行却不报错，自动装箱(Auto-Boxing)的过程。当您尝试调用某些基本类型的属性或方法时，JavaScript将首先将其转换为临时包装对象，并访问其上的属性/方法，而不会影响原始属性。
```

```js
// 通过apply/call包装原始类型为对象
function boxing() { return this; }
var test = 123;
boxing.apply(test) === 123; // will return false
// 通过new创建对象
var num = new Number(123);
```

# 字面量

由语法表达式定义。

```
typeof []
// "object"
[] instanceof Object
// true
[] instanceof Array
// true
123 instanceof Number
// false，6种原始数据定义的不是对象，通过new进行包裹的为对象
```

# 表达式

一个表达式是代码的任何有效单元，其解析为一个值。

# 本地值和继承值
[来源:MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Details_of_the_Object_Model)
- 检查本地值是否存在。如果存在，返回该值。
- 如果本地值不存在，检查原型链（通过 __proto__ 属性）。
- 如果原型链中的某个对象具有指定属性的值，则返回该值。
- 如果这样的属性不存在，则对象没有该属性。

```js
function Employee () {
  this.name = "";
  this.dept = "general";
}
function WorkerBee () {
  this.projects = [];
}
WorkerBee.prototype = new Employee;
var amy = new WorkerBee;
// 本地值，projects
// 继承值，name，dept
```
# JavaScript一切皆对象

除了字面量直接赋值的6种原始数据类型，但是如果使用原型方法时，会自动装箱（见上）

```
typeof Function
// "function"
typeof Object
// "function"
Function instanceof Object
// true
Object instanceof Object
// true
var a = new Function()
var b = function(){}
typeof a
// "function" 此为函数对象（见下）
Object.prototype.toString.call(a)
// "[object Function]"
Object.prototype.toString.call(Function)
// "[object Function]"
a instanceof Function
// true
a instanceof Object
// true
b instanceof Function
// true
```

# typeof 操作符

[MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof)

返回对象 或者 6种原始类型。

```
Number instanceof Object
//true
var a = 123;
var b = new Number(123);
typeof a
// "number"
typeof b
// "object"
Object.prototype.toString.call(a)
// "[object Number]"
Object.prototype.toString.call(b)
// "[object Number]"
a instanceof Number
// false
b instanceof Number
// true
```
