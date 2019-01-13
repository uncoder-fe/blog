---
description: ""
title: "javascript系列之原型链"
slug: ""
categories: ["javascript"]
tags: []
author: "uncoder"
date: "2016-02-06T16:03:47+08:00"
---

不懂系列，哈哈哈、

<!--more-->

* javascript 中，万物皆对象（Object），除由6种原始字面量初始化的。
* 数字，字符串，日期，函数，对象等等都可以`new`出来...
* 只有构造函数才有原型`prototype`
* `prototype`会构成循环，`__proto__`能找到`null`
* 实例的`__proto__`指向构造函数的`prototype`，构建函数`contructor`来`new`孩子
* `isPrototypeOf`判定一个对象是否在另一个对象的原型链上
* `instanceof`测试一个实例在其原型链中是否存在一个构造函数的`prototype`属性


# 所以呢

```js
var a = 1;
a.constructor === Number.prototype.constructor// 讲道理这个东西没啥卵用
a.__proto__ === Number.prototype; //内存地址一样
而
console.dir(Number); //包含的属性/方法，比a继承的多的多咯，a只继承了原型值，而没有获取Number的本地值.
```
```
//为啥 Person 第一个字母大写
function Person(name, age) {
  this.name = name;
  this.age = age;
  this.sayName = function() {
    console.log(this.name);
  };
}
Person.prototype.testStr = "我可以这样玩吗，比如我是一个字符串？";
Person.prototype.sayAge = function() {
  console.log(this.age);
};
const tom = new Person("tom", 12);
const jack = new Person("jack");
tom.sayName(); // 为啥可以调用这个方法
tom.sayAge(); // 为啥可以调用这个方法，和上面的有啥区别
console.log(tom.age); // 为啥age有这个属性
console.log(tom.testStr); // 为啥testStr有这个属性，这个和age有啥区别
console.log(tom.__proto__ === Person.prototype); //这个为啥能全等
console.log(tom.__proto__ === jack.__proto__); //为啥全等
console.log(tom.prototype) // 为啥tom没有原型

// 为啥是基于原型链继承，原型链的原型链的原型链可以连起来成一个链子
console.log(tom.__proto__.__proto__.__proto__);
console.log(Person.__proto__.__proto__.__proto__);
//  构造函数继承大写的构造函数Function
console.log(Person.__proto__ === Function.prototype);
//  函数继承继承大写的构造函数Object
console.log(Function.__proto__.__proto__ === Object.prototype)
//  对象也继承继承大写的构造函数Object，绕不晕你？
console.log(Object.__proto__.__proto__ === Object.prototype)
//  坐实构造函数Function是对象的实例   
console.log(Function instanceof Object);
//  为啥 Function的原型链不是对象的原型呢？？？？？？？？？？？？？？？？？？？？？？？？？？
console.log(Function.__proto__ === Object.prototype)
//  最终它们都源自null
console.log(Object.__proto__.__proto__.__proto__ === null)

// 如何模拟一个new
改写__proto__指向值/方法/原型/对象实例
```
