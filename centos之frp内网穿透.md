---
title: "Centos之frp内网穿透"
description: ""
date: 2018-12-23T17:07:52+08:00
author: "uncoder"
tags: ["centos"]
categories: ["服务器"]
slug: ""
---

通过frp来用外部的服务器，接入内网访问(ssh,web)。
<!--more-->

# 安装

github下载[地址](https://github.com/fatedier/frp/releases)

```bash
wget https://github.com/fatedier/frp/releases/download/v0.22.0/frp_0.22.0_linux_arm.tar.gz
tar -xzf frp_0.22.0_linux_arm.tar.gz
```

# 服务器端设置

./frps.ini

```bash
[common]
bind_addr = 0.0.0.0
bind_port = 7000
kcp_bind_port = 7000
token = 12345678

vhost_http_port = 80
vhost_https_port = 443
```

# 客户端设置

./frpc.ini

```bash
[common]
server_addr = 服务端IP
server_port = 7000
protocol = kcp
token = 12345678

[ssh]
type = tcp
local_port = 22
remote_port = 6000
use_encryption = true
use_compression = true

[web01]
type = http
local_port = 80
local_ip = 127.0.0.1
remote_port = 80
#若是想通过ip访问，不设置域名
custom_domains = www.xxx.com

[web02]
type = https
local_port = 443
local_ip = 127.0.0.1
remote_port = 443
custom_domains = www.ooo.com

[rtmp]
type = tcp
local_ip = 127.0.0.1
local_port = 1935
remote_port = 1935
```
