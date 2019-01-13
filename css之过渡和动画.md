---
title: "css过渡和动画"
date: "2016-01-05T15:23:03+08:00"
author: "uncoder"
tags: []
categories: ["css"]
slug: ""
---

## 过渡

顾名思义，就是由一个初始状态到另一个结束状态，利用`transition`可以实现。
<!--more-->

``` css
a{
    color: black;
    transition: all 1000ms ease;
}
a:hover{
    color: red;
}
```

备注：
1，对于`display:none`或者`append()`的元素，由于默认没有初始状态，可以使用延迟函数后在过渡。
2，过渡结束后，可以监听`transitionend`方法检测是否过渡完成。
## 动画

由于过渡是一次性的，所以如果想循环重复，需要使用`animation`。

``` css
a{
    animation: move 4s linear 0s infinite alternate;
}
@keyframes move { 
    from { margin-left:-20%; } 
    to { margin-left:100%; }  
}
```

当然，我们也可以调用类增加动画，这里还有一个动画事件监听

``` javascript
var el = document.getElementById("watchme");
el.addEventListener("animationstart", function(e){console.log(e.type)}, false);
el.addEventListener("animationend", function(e){console.log(e.type)}, false);
el.addEventListener("animationiteration", function(e){console.log(e.type)}, false);
el.className = "move";
```

备注：
1，事件必须要先监听，然后赋值动画类
2，简单地通过event.type来判断发生的是何种事件
3，如果动画不结束会循环animationiteration事件，直到animationend后停止
## 60FPS

对于逐帧动画可以使用`requestAnimationFrame`函数，这就要求你的动画函数执行会先于浏览器重绘动作。
通常来说，被调用的频率是每秒60次，但是一般会遵循W3C标准规定的频率。

``` javascript
requestID = window.requestAnimationFrame(callback); 
```

备注：
1，通过callback再次调用和重绘
2，requestID 是一个长整型非零值,作为一个唯一的标识符.你可以将该值作为参数传给`window.cancelAnimationFrame()`来取消这个回调函数
