---
author: "小傻师哥"
date: "2017-01-11T16:43:37+08:00"
description: "canvas的粒子效果实现"
title: "canvas粒子效果"
slug: ""
categories: ["canvas"]
tags: []
---

历时一年，终出一篇。
耗尽心血，卒。
<!--more-->

# 什么是像素?
像素，为视频显示的基本单位，译自英文“pixel”，pix是英语单词picture的常用简写，
加上英语单词“元素”element，就得到pixel，故“像素”表示“画像元素”之意，有时亦被称为pel（picture element）。
每个这样的消息元素不是一个点或者一个方块，而是一个抽象的取样。
每个像素可有各自的颜色值，可采三原色显示，因而又分成红、绿、蓝三种子像素（RGB色域）。

# 分辨率
Image resolution，台湾译为“解析度”，香港译为“解像度”，中国大陆译为“分辨率”，泛指量测或显示系统对细节的分辨能力。
此概念可以用时间、空间等领域的量测。日常用语中之分辨率多用于视频的清晰度。
分辨率越高代表视频质量越好，越能表现出更多的细节；但相对的，因为纪录的信息越多，文件也就会越大。

## 分辨率单位
描述分辨率的单位有：dpi（点每英寸）、lpi（线每英寸）和ppi（每英寸像素）。
从技术角度说，“像素”只存在于电脑显示领域，而“点”只出现于打印或印刷领域。

## 显示分辨率（横向／纵向的像素个数）
对电脑显示器等，分辨率是用像素数目衡量；对数字文件印刷，分辨率是通常用每英寸所含点或像素〔dpi〕来衡量。

# 设备像素
设备像素就是物理像素，通常可以用`window.screen.height/width`读出。

# 移动端
移动端浏览器（如Fennec）在一个通常比屏幕更宽的虚拟`窗口/视口`（设备）中渲染页面。
用户可以通过平移和缩放来浏览页面的不同区域。

## CSS视窗(视口)
window窗口像素，通常可以用`window.innerHeight/innerWidth`读出。
Mobile Safari 引入了`viewport元标签`来让web开发者控制视口的尺寸及比例。
`<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">`

## 布局（css像素）
viewport决定文档对象`window.document.documentElement`的大小，从而影响布局。

# 入题
动画，设置粒度的最小控制单位。

## 采集像素点位置
canvas是二维坐标
像素数组是一维
所以需要把二维转换成一维才能读取到正确的色彩
[进来](https://codepen.io/uncoder-/pen/MJKqMW)

## 运动轨迹
下落的主要用到了正弦定理，计算偏移位置
[进来](http://codepen.io/uncoder-/pen/qRZjrJ)

## 雪花
[进来](http://codepen.io/uncoder-/pen/LxNLWX)

## 文字粒子
[进来](http://codepen.io/uncoder-/pen/NdNjBK)

## 效果展示
<iframe height='550' scrolling='no' title='canvas粒子效果教程-5' src='//codepen.io/uncoder-/embed/pRbOxO/?height=550&theme-id=0&default-tab=result&embed-version=2' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'>See the Pen <a href='http://codepen.io/uncoder-/pen/pRbOxO/'>canvas粒子效果教程-5</a> by uncoder- (<a href='http://codepen.io/uncoder-'>@uncoder-</a>) on <a href='http://codepen.io'>CodePen</a>.
</iframe>
