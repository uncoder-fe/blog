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

宿主数据目录: `~/minio/data`
用户名: `minio`
密码: `minio@123`


```

sudo docker pull minio/minio

sudo docker run \
  -itd \
  -p 9000:9000 \
  -p 9001:9001 \
  --name minio1 \
  -v ~/minio/data:/data \
  -e "MINIO_ROOT_USER=minio" \
  -e "MINIO_ROOT_PASSWORD=minio@123" \
  minio/minio server /data --console-address ":9001"
```
