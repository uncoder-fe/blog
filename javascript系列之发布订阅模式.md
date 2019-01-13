---
title: "Javascript系列之发布订阅模式"
description: ""
date: 2018-04-03T11:35:48+08:00
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

发布订阅并不是观察者模式、它是在后者基础上的软件架构。

<!--more-->

# 我们需要一个数据源

相当于 EventEmitter，并且是将值或事件多路推送给多个 Observer 的唯一方式

```js
class Subject {
	notify = (message, cb) => {
		cb(message);
	};
}
```

# 我们需要一个调度中心

表示一个概念，这个概念是一个可调用的未来值或事件的集合。

```js
class Observable {
	constructor() {
		this.listeners = new Set([]);
	}
	register = ob => {
		if (!this.scanListeners.has(ob)) {
			this.listeners.add(ob);
		}
	};
	deregister = ob => {
		if (this.scanListeners(ob)) {
			this.scanListeners.delete(ob);
		}
	};
	publish = message => {
		const { listeners } = this;
		listeners.forEach(listener => {
			listener.notify(message);
		});
	};
}
```

# 我们需要一些订阅者

一个回调函数的集合，它知道如何去监听由 Observable 提供的值。

```js
class Observer {
	constructor(message, fn) {
		this.message = message;
		this.fn = fn;
	}
	notify = m => {
		const { message, fn } = this;
		// 这个消息我订阅了
		if (m == message) {
			console.log(`我订阅的消息是${message},我要触发的函数是${fn}`);
			fn();
		}
	};
}
```

# 然后就差不多了

```js
var sb = new Subject();
var sbc = new Observable();
var oba = new Observer('hi', () => { console.log("hi,i am oba") });
var obb = new Observer('hi', () => { console.log("hi,i am obb") });

sbc.register(oba);
sbc.register(oba);
sbc.deregister(oba);
sbc.register(obb);

sb.notify('hi', () => {
	const message = arguments[0];
	sbc.publish(message);
});
```

# 总结一哈

发布者和订阅者不是直接沟通的，通过调度中心来连接，在调度中心里我们可以做一些事情。

来源wiki-[观察者模式](https://zh.wikipedia.org/wiki/%E8%A7%82%E5%AF%9F%E8%80%85%E6%A8%A1%E5%BC%8F)

来源wiki-[发布订阅](https://zh.wikipedia.org/wiki/%E5%8F%91%E5%B8%83/%E8%AE%A2%E9%98%85)

来源[rxjs](http://cn.rx.js.org/manual/overview.html)
