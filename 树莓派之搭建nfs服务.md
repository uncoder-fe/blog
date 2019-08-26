---
title: "树莓派之搭建nfs服务"
date: 2019-01-17T00:09:14+08:00
author: "uncoder-fe"
tags: ["raspberry", "nfs"]
categories: ["服务器相关"]
slug: ""
---

使用一些媒体播放软件，可以直接播放树莓派推送的视频

<!--more-->

# [安装](https://packages.debian.org/stretch/rpcbind)

`nfs-utils`，这个树莓派不需要，是一个包，里面包含两个[软件](https://packages.debian.org/search?arch=armhf&searchon=sourcenames&keywords=nfs-utils)

```bash
# 正常安装
sudo apt install nfs-kernel-server
sudo apt install rpcbind
```

# 配置共享目录

```bash
vim /etc/exports
# insecure确保端口号大于1024也可以连接此服务
/tmp *(rw,insecure)
```

# 开启服务

```bash
sudo systemctl start rpcbind
sudo systemctl start nfs-kernel-server
```

nfs 会开启 3 个服务:

1. portmapper:做端口映射的(默认使用 111 端口)
2. mountd:管理 NFS 的文件系统(默认使用 20048 端口，可自己指定)

```bash
vim /etc/services
mountd 20048/udp
mountd 20048/tcp
```

3. nfs:管理客户端登录(默认使用 2049 端口)

# 配置 frp 端口转发

```bash
vim frpc.ini
# 加入
[range:tcp_port]
type = tcp
local_ip = 127.0.0.1
local_port = 111,2049,20048
remote_port = 111,2049,20048

[range:udp_port]
type = udp
local_ip = 127.0.0.1
local_port = 111,2049,20048
remote_port = 111,2049,20048
```
