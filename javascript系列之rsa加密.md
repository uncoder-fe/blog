---
title: "javascript的rsa加密"
date: "2016-03-05T15:23:03+08:00"
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

没错，拷贝就可以用了，注意下\r

<!--more-->

## 使用的库

[JSEncrypt](http://travistidwell.com/jsencrypt/);

## 代码

```
getRsa:function(str) {
    var jse = new JSEncrypt();
    var pubKey ="-----BEGIN PUBLIC KEY-----\r-----END PUBLIC KEY-----";
    jse.setPublicKey(pubKey);
    var encrypted = jse.encrypt(str);
    return encrypted;
}
```

备注：`/r`换行
