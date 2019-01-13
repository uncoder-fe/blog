---
author: "uncoder-fe"
date: "2019-01-07T16:43:37+08:00"
description: ""
title: "puppeteer之生成PDF后canvas图表变小问题"
slug: ""
categories: ["canvas"]
tags: []
---

由于默认的视窗大小是`800*600`
所以一些图表库计算宽度和高度时候会有问题。
解决方案：

```javascript
puppeteer.launch({
    defaultViewport: {
        width: 800,
        height: 1000
    }
})
```