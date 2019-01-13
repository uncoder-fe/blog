---
title: "Redux之中间件实现原理"
description: ""
date: 2018-04-27T11:12:06+08:00
author: "uncoder"
tags: ["redux"]
categories: ["前端相关"]
slug: ""
---

源码行数不多，很精辟、

<!--more-->
# 组合函数

```js
import compose from './compose'
//compose(f, g, h)  ====》 (...args) => f(g(h(...args)))
```
文件第一行引入的这个包，把函数通过reduce的运行机制捆绑到一起，返回一个大闭包函数。
也就是洋葱式结构，类似`koa2`的中的。

# 中间件

```js
logger() {
    return next => action=> next(action);
}
```
返回一个2重curry化的高阶函数。

# applyMiddleware函数

- 前3行

```js
export default function applyMiddleware(...middlewares) {
  return createStore => (...args) => {
    const store = createStore(...args)
    //other code ...
  }
}
```

在createStore中的`enhancer函数`就是它了，返回一个2重curry化的闭包。

这里的`createStore方法`是一个语意化表示(好直白的*_*...)，它是从`createStore.js`传进来的`createStore方法`，把它替换成`callback`别名也是可以的。

通过传进来的`createStore方法`重新初始化生成`store`。

- 第4行

```js
...
let dispatch = () => {
    throw new Error(
    `Dispatching while constructing your middleware is not allowed. ` +
        `Other middleware would not be applied to this dispatch.`
    )
}
const middlewareAPI = {
    getState: store.getState,
    dispatch: (...args) => dispatch(...args)
}
...
```

使用`let`声明了一个’假‘的dispatch，这个并不能`dispatch(action)`，而是为了配合中间件，二次重新生成新的`dispatch方法`。所以常量`middlewareAPI`中的`dispatch`被赋值了一个`匿名函数`来传递中间件包裹后的`dispatch`引用。

`getState方法`就无所谓了，它只是返回当前的`state状态树`

- 第6～7行

```js
const chain = middlewares.map(middleware => middleware(middlewareAPI))
dispatch = compose(...chain)(store.dispatch)
```

定义`chain`来接收通过中间件执行后的结果（每个中间件形成各自闭包并组成一个新的数组）。
然后`compose`把这些闭包组合起来，形成一个新的闭包嵌套（洋葱式结构）。
重新赋值给`dispatch`，更新引用。

- 最后一行

```js
return {
    ...store,
    dispatch
}
```
把这些东西在踢出去。