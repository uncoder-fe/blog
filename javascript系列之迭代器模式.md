---
title: "Javascript系列之迭代器模式"
description: ""
date: 2018-04-08T10:00:21+08:00
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

最简单、最常用的模式，顾名思义，迭代

<!--more-->

```js
class Iterator {
	constructor(arry) {
		this.arryList = arry;
		this.index = 0;
	}
	first = () => {
		return this.arryList[0];
	};
	next = () => {
		let ret = null;
		this.index++;
		if (this.index < this.arryList.length) {
			ret = this.arryList[this.index];
		}
		return ret;
	};
	isDone = () => {
		const { index, arryList } = this;
		return index >= arryList.length ? true : false;
	};
	CurrentItem = () => {
		return this.arryList[this.index];
	};
}

const arry = [1, 2, 3, 4, 5];

const f = new Iterator(arry);

console.log(f.first());
console.log(f.next());
console.log(f.isDone());
console.log(f.CurrentItem());
```