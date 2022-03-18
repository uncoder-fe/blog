---
title: "nas-minio搭建"
date: 2022-03-15T16:01:25+08:00
description: ""
author: "uncoder-fe"
tags: ["esxi","minio"]
categories: ["虚拟机"]
slug: ""
---

使用docker安装`minio/minio`镜像

<!-- more -->

```

sudo docker pull minio/minio

sudo docker run \
  -d \
  -p 9000:9000 \
  -p 9001:9001 \
  --name minio1 \
  -v ~/minio/data:/data \
  -e "MINIO_ROOT_USER=minio" \
  -e "MINIO_ROOT_PASSWORD=minio@123" \
  minio/minio server /data --console-address ":9001"
```
宿主数据目录: `~/minio/data`
用户名: `minio`
密码: `minio@123`
# 访问
http://192.168.x.x:9001/login
# 静态文件
1. 创建一个bucket,访问策略设置为public,
2. 上传一个test.png图片，点击share按钮
3. 访问http://192.168.x.x:9000/{bucket-name}/test.png
