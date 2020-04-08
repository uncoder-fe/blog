---
title: "Nginx之反向代理"
description: ""
date: 2018-05-24T15:03:54+08:00
author: "uncoder"
tags: []
categories: ["服务器相关"]
slug: ""
---

所以我们就可以悄悄咪咪上一些不良网站了，整站代理。

<!--more-->
# nginx

我们通过配置,可以访问`www.a.com`时候，获取`www.b.com`的网页内容，或者拦截某一个路径内容而映射到本地(静态文件/接口)。

# hosts

此文件可以映射 `IP <---> 域名`，这样如果我们的`www.a.com`可以随意起名字了，个人感觉不必强制性的使用（nginx可以拦截）。

# 接口
```
location /api/ {
    proxy_pass https://xxxxxxxxxxxx.cloudfunctions.net/;
}
```
