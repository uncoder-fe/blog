---
title: "树莓派之docker初始化"
date: 2019-08-26T00:09:14+08:00
author: "uncoder-fe"
tags: ["raspberry", "docker"]
categories: ["树莓派"]
slug: ""
---

安装，操作

<!--more-->

# 安装

这里使用官方推荐安装方式

1. [地址](https://docs.docker.com/install/linux/docker-ce/debian/)

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

# 权限

pi 加入`docker`用户组

```bash
sudo usermod -aG docker pi
```

# 基础镜像源

dockerHub 官方维护的`arm32v7`镜像[列表](https://hub.docker.com/u/arm32v7)

```shell
docker pull resin/rpi-raspbian
```

# 安装 docker-compose

使用 pip 或者源码编译

1. `pip`安装

```bash
# Install required packages
apt update
apt install -y python python-pip

# Install Docker Compose from pip
pip install docker-compose
cd /home/pi/.local/bin
cp docker-compose /usr/local/bin/docker-compose
```

2. 源码编译[安装](https://qiita.com/katsusuke/items/beec05e1afcd67ebd3dc)，这种方式容易崩溃，勿试。

```bash
git clone https://github.com/docker/compose.git
cd compose
sudo docker build -t docker-compose:armhf -f Dockerfile.armhf .
sudo docker run --rm --entrypoint="script/build/linux-entrypoint" -v $(pwd)/dist:/code/dist -
sudo cp dist/docker-compose-Linux-armv7l /usr/local/bin/docker-compose
docker-compose --version
```

# portainer 可视化管理

```bash
docker run -d -p 9999:9000 -v "/var/run/docker.sock:/var/run/docker.sock" portainer/portainer
```

# 容器测试

挂载树莓派的/home/pi/www 到容器的/www 目录

```bash
sudo docker run -it -p 80:80 -v /home/pi/www:/www --name mynginx -d resin/rpi-raspbian /bin/bash
```
