---
title: "centos之开机自启动服务"
description: ""
date: 2018-03-15T16:33:39+08:00
author: "uncoder"
tags: ["centos 7","debian 9","frp"]
categories: ["服务器"]
slug: ""
---

用frp内网穿透做个例子

<!--more-->
# centos 7.x

## 新增/编辑`/lib/systemd/system/my-frp.service`

```bash
[Unit]
Description=frp proxy Server Service
Wants=network-online.target
After=network.target network-online.target

[Service]
Type=simple
EnvironmentFile=/usr/lib/frp_0.16.0_linux_amd64/frps_full.ini
ExecStart=/usr/lib/frp_0.16.0_linux_amd64/frps -c /usr/lib/frp_0.16.0_linux_amd64/frps.ini
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
KillMode=process

[Install]
WantedBy=multi-user.target

```
# 跑起来

```
systemctl start my-frp.service
systemctl enable my-frp.service
```

_---_---_---_---_---_---_分割线_---_---_---_---_

# debian 9.x

## 新增/编辑 /lib/systemd/system/frp2.service

ExecStartPre这个很重要，frp启动需要睡觉才行

```
[Unit]
Description=frp proxy Server Service
After=network.target

[Service]
Type=simple
ExecStartPre=/bin/sleep 30
ExecStart=/usr/lib/frp_0.21.0_linux_arm/frpc -c /usr/lib/frp_0.21.0_linux_arm/frpc.ini
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
KillMode=process

[Install]
WantedBy=multi-user.target
```
