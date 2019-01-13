---
title: "Nginx取消304缓存"
description: ""
date: 2016-11-14T20:07:30+08:00
author: "uncoder"
tags: ["nginx"]
categories: ["服务器相关"]
slug: ""
---

加上这个这个配置

<!--more-->

```bash
location ~ .*\.(gif|jpg|jpeg|bmp|png|ico|txt|js|css|html)$
    {
        # 该资源已经过期，如果设置了 "max-age"，此头就会被忽略
        expires      -1;
        # 设置修改时间为当前时间
        add_header Last-Modified $date_gmt;
        # 定义如何比较请求头中的“If-Modified-Since”时间，不比较
        if_modified_since off;
        # 关闭etag
        etag off;
    }
```

```shell
location ~ .*\.(css|js|swf|php|htm|html )$ {
    add_header Cache-Control no-store;
    add_header Pragma no-cache;
}
```
