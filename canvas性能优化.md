---
title: "Canvas性能优化"
description: ""
date: 2018-02-08T18:40:28+08:00
author: "uncoder"
tags: []
categories: ["canvas"]
slug: ""
---

canvas 动画性能实践、

<!--more-->

# 方式 1

动画结束后，使用新的 canvasCache 缓存整个 canvas，减少 canvas API 的消耗，离屏canvas。

```javascript
let canvasCache = null;
for(let i=0; i<data.length; i++){
    // 清空画布
    ctx.clearRect(0, 0, 5000, 5000);
    // 静态的
    if (canvasCache) {
        ctx.drawImage(canvasCache, 0, 0, 5000, 5000);
    }
    // 动态的，耗时
    await new Promise((resolve, reject) => {
        _animate(ctx, data[i].list, resolve);
    });
}
```

# 方式 2

减少 canvas 状态机状态改变。

```javascript
ctx.fillStyle = "red";
for (var i = 0; i < 20; i++) {
  ctx.fillRect(i * 2, 0, 480);
}
ctx.fillStyle = "yellow";
for (var i = 0; i < 20; i++) {
  ctx.fillRect(i * 2 + 1, 0, 480);
}
```

# 方式 3

避免浮点数的坐标点，用整数取而代之

```javascript
ctx.drawImage(myImage, 0.3, 0.5);
```

# 方式 4

使用多层画布去画一个复杂的场景，重叠