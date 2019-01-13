---
title: "Localhost设置https"
description: ""
date: 2017-09-14T19:46:57+08:00
author: "uncoder"
tags: ["nginx","http2"]
categories: ["服务器相关"]
slug: ""
---

# 证书生成
<!--more-->

``` bash
# 生成一个RSA密钥
openssl genrsa -des3 -out server.key 1024

# 拷贝一个不需要输入密码的密钥文件
openssl rsa -in server.key -out server_nopass.key

# 生成一个证书请求
openssl req -new -key server.key -out server.csr

# 自己签发证书
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

# nginx配置

``` bash
listen       443 ssl http2;
server_name  localhost;
ssl_certificate      目录/server.crt;
ssl_certificate_key  目录/server_nopass.key;
```