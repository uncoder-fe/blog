---
title: "Javascript系列之文件描述"
description: ""
date: 2017-03-09T14:57:23+08:00
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

不知道用什么词来描述的更贴切、

<!--more-->

# Blob 对象

1.  Blob 对象表示一个不可变、原始数据的类文件对象。
2.  Blob 表示的不一定是 JavaScript 原生格式的数据。

# File 对象

1.  继承于 Blob 对象
2.  来自用户在一个`<input>`元素上选择文件后返回的 FileList 对象
3.  来自自由拖放操作生成的 DataTransfer 对象，
4.  来自 HTMLCanvasElement 上的 toBlob() API。

# Data URLs

1.  前缀为 data：scheme 的 URL，其允许内容创建者向文档中嵌入小文件
2.  比如图片 base64 数据
3.  来自 HTMLCanvasElement 上的 toDataURL() API。
4.  通过 URL.createObjectURL(blob)创建一个 url
5.  FileReader.readAsDataURL()

# ArrayBuffer

1.  对象用来表示通用的、固定长度的原始二进制数据缓冲区。
2.  通过类型数组对象或 DataView 对象来操作，它们会将缓冲区中的数据表示为特定的格式，并通过这些格式来读写缓冲区的内容
3.  FileReader.readAsArrayBuffer()
4.  DataView 视图是一个可以从 ArrayBuffer 对象中读写多种数值类型的底层接口，在读写时不用考虑平台字节序问题

# AudioBuffer

1.  利用 AudioContext.decodeAudioData()方法从音频文件构建，
2.  利用 AudioContext.createBuffer()构建于原数据。

# SourceBuffer

1.  表示媒体块被传递到 HTMLMediaElement 通过并播放，MediaSource 对象
