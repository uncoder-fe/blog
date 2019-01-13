---
title: "区块链之智能合约Dapp开发入门"
description: ""
date: 2018-06-20T16:58:06+08:00
author: "uncoder"
tags: ["dapp","星云链"]
categories: ["区块链"]
slug: ""
---

基于星云链的Dapp开发、

<!--more-->

# 环境

1. 注册一个[账号](https://incentive.nebulas.io/cn/signup.html?invite=spgBa)
2. 下载[钱包](https://github.com/nebulasio/web-wallet)
3. 生成钱包
    - 浏览器打开文件`/web-wallet/index.html`
    - 右上角选择语言(中文)/环境(测试)
    - 选择tab（创建钱包），输入9位密码，新建即可，钱包地址和密码一定不能忘记，后面要用
    - 下载钱包`json`格式文件

# 智能合约编码

直接拷贝代码了，注释里很清楚

```js
'use strict';

// 定义一个数据结构，来存取数据
function Word(text) {
    if (text) {
        var o = JSON.parse(text);
        this.id = o.id;
        this.content = o.content;
    } else {
        this.id = 'id--salt';
        this.content = 'content--hello world';
    }
};
// 转换字符串
Word.prototype = {
    toString: function () {
        return JSON.stringify(this);
    }
};

// 定一个Dapp的名字吧
var MyDapp = function () {
    // 定义一个store的Map（仓库，个人理解）
    LocalContractStorage.defineMapProperty(this, "store", {
        parse: function (text) {
            return new Word(text);
        },
        stringify: function (o) {
            return o.toString();
        }
    });
};

MyDapp.prototype = {
    init: function () {
        //TODO:这个必须要有的，初始化
    },
    save: function (id, content) {
        var exist = this.store.get(id);
        if (exist) {
            throw new Error("已经存在了.");
        }
        var word = new Word();
        word.id = id;
        word.content = content;
        // 存储
        this.store.put(id, word);
    },
    takeout: function (id) {
        // 查询
        var result = this.store.get(id);
        if (!result) {
            throw new Error("取出失败了.");
        }
        return result;
    }
};
module.exports = MyDapp;
```

# 部署以及测试

1. 打开`web-wallet/contract.html`
2. 选择tab（部署）
    - 拷贝代码
    - 选择`json`钱包，输入密码
    - 点击测试代码是否异常
    - 提交后生成`合约`，这个地址不能忘记
3. 选择tab（执行）
    - 输入`save`,参数设置为`['1','hello world']`，注意是字符串
    - 选择`json`钱包，输入密码
    - 点击测试，返回正常则成功
    - 提交发起交易，等待数据写入
    - 查询输入`takeout`，参数设置`['1']`
    - 点击测试，显示`result`则查询正常
    