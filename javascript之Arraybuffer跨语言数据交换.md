---
title: "javascript之Arraybuffer跨语言数据交换"
date: 2020-8-13T16:01:25+08:00
description: ""
author: "uncoder-fe"
tags: ["Arraybuffer"]
categories: ["javascript"]
slug: ""
---


> If you can't explain it simply, you don't understand it well enough.
> Albert Einstein

# 概念
前端领域来看，ArrayBuffer 对象用来表示通用的、固定长度的原始二进制数据缓冲区。
其他语言中称为byte array，它是一个字节数组。

举个栗子：常见的文件下载/图像下载，这里使用左上角的icon当作资源地址（后缀webp的，挺先进的）
```
fetch('https://s3.pstatp.com/ee/feishu_website/static/img/logo-zh.648d6d020e.webp', { method: 'get' })
.then(response=>response.arrayBuffer())// 可选blob()，这里只做对buffer类型的设定，也有其他类型
.then(arrybuffer=>{ console.log(arrybuffer) });
```
浏览器控制台直接拷贝以上代码，并回车执行，结果如下。


聪明的你已经发现了奇怪的事，Int8Array / Int16Array / Uint8Array这些东西，其实是一样的(也是不一样的)，同一份buffer的不同编码格式的类数组(TypedArray)，可以看到每种类型后面的长度（字节个数），3462 = 1731*2。还可以看到arraybuffer的长度和Int8Array的长度一样，都是3462，这个点可以注意一下。
## typedArray

一个类型化数组（TypedArray）对象描述了一个底层的二进制数据缓冲区（binary data buffer）的一个类数组视图（view）。

## 16进制数据
16进制数据(简写为hex，在数学中是一种逢16进1的进位制)。举个例子, 红色的阴影是十进制 238,9,63 ，或者rgb(238, 9, 63)，可以编成 #ee093f。

做过加密比如(AES)的同学应该知道base64与hex是常用的格式，思考，为啥用这种方式呢？

# 生成arraybuffer
你不能直接操作 ArrayBuffer 的内容，而是要通过类型数组对象（TypedArray）或 DataView 对象来操作，它们会将缓冲区中的数据表示为特定的格式，并通过这些格式来读写缓冲区的内容。
利用构造函数创建一个ArrayBuffer对象

```js
const arrybuffer = new ArrayBuffer(length);
length: 要创建的 ArrayBuffer 的大小，单位为字节（Byte）。
arrybuffer: 一个指定大小的 ArrayBuffer 对象，其内容被初始化为0。
```

## 字节
没有跳动，这个计算机术语是个旧词汇，下面掰扯一下。

### 字节（英语：Byte），通常用作计算机信息计量单位，不分数据类型。从历史的观点上，“字节”表示用于编码单个字符所需要的比特数量。今日事实标准以8比特作为一字节，因8为二进制整数（每个数字称为一个比特（二进制位）或比特（Bit，Binary digit 的缩写））。缩写为B

可以看到，进制越大越短，传输数据越少。一个字节最大值（8位）的十进制表示为255，是不是很熟悉的一个数字。
### 比特
（英语：Bit，亦称二进制位）指二进制中的一位，是信息的最小单位。缩写为b
## Unicode
（中文：万国码、国际码、统一码、单一码）是计算机科学领域里的一项业界标准。它对世界上大部分的文字系统进行了整理、编码，使得电脑可以用更为简单的方式来呈现和处理文字。当前最新的版本为2019年5月公布的12.1.0，已经收录超过13万个字符。Unicode涵盖的数据除了视觉上的字形、编码方法、标准的字符编码外，还包含了字符特性，如大小写字母。

在文字处理方面，统一码为每一个字符而非字形定义唯一的代码（即一个整数，十进制）。

在表示一个 Unicode 的字符时，通常会用“U+”然后紧接着一组十六进制的数字来表示这一个字符。

比如栗子：

```js
const str = '中';
const i = str.charCodeAt(); 
// 二进制表示，100111000101101
// 十进制表示，20013
// UTF-16 code units，4e2d
String.fromCharCode(i);  // "中"
```
Unicode 的实现方式称为 Unicode转换格式（Unicode Transformation Format，简称为 UTF）

### UTF-8
UTF-8（8-bit Unicode Transformation Format）是一种针对Unicode的可变长度字符编码，也是一种前缀码。它可以用一至四个字节对Unicode字符集中的所有有效编码点进行编码，属于Unicode标准的一部分，最初由肯·汤普逊和罗布·派克提出。

```js
00000000 00000000 00000000 00000000  // 此行没有意义，方便观看对比
// 4e2d，在第三个范围，需要用三个字节（3 * 8）24位表示
100 1110 0010 1101  // 二进制
1110xxxx 10xxxxxx 10xxxxxx // 替换上面的x，位说不够x变为0
11100100 10111000 10101101 //转换为UTF-8分组
e4       b8       ad  //转换为UTF-8分组，16进制表示  
```
 起点/终点，16进制表示
 
### UTF-16
计算太复杂了，不说了

## 从base64创建一个ArryBuffer对象
首先我们获取一个base64的字符串，常规操作，见证奇迹。

```js
const str = '中';
const barse64Str = window.btoa(str); //啊哦，浏览器报错了 The string to be encoded contains characters outside of the Latin1 range.
报错了，很尴尬，有人知道为什么嘛？
```
### base64
Base64 是一组相似的二进制到文本（binary-to-text）的编码规则，使得二进制数据在解释成 radix-64 的表现形式后能够用 ASCII 字符串的格式表示出来。

### ASCII 
American Standard Code for Information Interchange是基于拉丁字母的一套电脑编码系统。局限在于只能显示26个基本拉丁字母、阿拉伯数字和英式标点符号，因此只能用于显示现代美国英语。
问题原因，这样处理。
由于 DOMString 或者 String 是16位编码的字符串，所以如果有字符超出了8位ASCII编码的字符范围时，在大多数的浏览器中对Unicode字符串调用 window.btoa 将会造成一个 Character Out Of Range 的异常。

有很多种方法可以解决这个问题：高位转低位
这里我们使用第三个方法，原因是代码短 / 小 / 便携，你懂的😈

```js
// 编码
function btoaUTF16(sString) {
    // 先声明一个无符号16位的类数组，可理解为承载容器
    const aUTF16CodeUnits = new Uint16Array(sString.length);
    // 容器装填每个字符对应的索引值
    Array.prototype.forEach.call(aUTF16CodeUnits, function(el, idx, arr) {
       arr[idx] = sString.charCodeAt(idx);
    });
    // 无符号16位类数组 转为 无符号8位类数组
    const array = new Uint8Array(aUTF16CodeUnits.buffer); // Uint8Array(6) [45, 78, 253, 86, 166, 104]
    const str = String.fromCharCode.apply(null, array); // 错误的字符串，-NýV¦h
    // 返回base64字符串
    return window.btoa(str);
}
const resultBase64 = btoaUTF16('中国梦'); // 'LU79VqZo'

// 解码
function atobUTF16(sBase64) {
    // 解码base64
    const sBinaryString = window.atob(sBase64);  //-NýV¦h
    // 创建8位类数组，可理解为承载容器
    const aBinaryView = new Uint8Array(sBinaryString.length); 
    // 容器装填每个字符对应的索引值
    Array.prototype.forEach.call(aBinaryView, function(el, idx, arr) {
        arr[idx] = sBinaryString.charCodeAt(idx);
    });
    // Uint8Array(6) [45, 78, 253, 86, 166, 104]
    // 正确的字符串
    return String.fromCharCode.apply(null, new Uint16Array(aBinaryView.buffer));
}
const result = atobUTF16('LU79VqZo'); // '中国梦'
```

到此base64创建arraybuffer已经结束了，啥，你没看明白？看来你没注意听讲啊.

## 从字符串创建一个ArrayBuffer

```js
const enc = new TextEncoder(); // always utf-8
const arry = enc.encode('中国梦');
console.log(arry);
const dnc = new TextDecoder();
console.log(dnc.decode(arry))
```

## 从blob创建一个ArrayBuffer
使用开头我们的栗子，直接发起请求

```js
fetch('https://s3.pstatp.com/ee/feishu_website/static/img/logo-zh.648d6d020e.webp', { method: 'get' })
.then(response => response.blob())
.then(blob => { console.log(blob) });
```
控制台执行，输入如下

不错不错，已经有blob对象了，下一步就非常简单了

```js
const buffer = await blob.arrayBuffer();
```

## 思考，既然blob创建buffer这么简单，那或许可以利用一下
创建一个blob对象，然后塞入一个字符串

```js
const blob = new Blob(['中国梦'], {type : 'plain/text'});
const buffer = await blob.arrayBuffer();
```
似乎，好像，可以

# 反转arraybuffer为数据
## 转 string

```js
function ab2str(buf) {
  return String.fromCharCode.apply(null, new Uint16Array(buf));
}
```

## 转  blob  转 object

```js
const blob = new Blob([arraybuffer||typedArray]);
const reader = new FileReader();
reader.readAsText(blob, 'utf-16');
reader.onload = function(e) {
    console.info(reader.result);
};
```

## 转  string

```js
new TextDecoder('utf-16').decode(typedArray)
```

# 备注
表单上传的时候，推荐使用typedArray。

