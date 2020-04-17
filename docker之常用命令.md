---
title: "Docker之常用命令"
description: ""
date: 2017-10-17T22:17:38+08:00
author: "uncoder"
tags: ["docker", "容器"]
categories: ["服务器相关"]
slug: ""
---

常用命令

<!--more-->

```bash
// 查看所有容器
docker ps -a
// 查看镜像
docker images
// 删除镜像
docker rmi imageID
// 下载镜像
docker pull debian
// 跑起一个镜像
docker run -itd -p hostPort:containerPort -v hostFolder:containerFolder --name mynginx debian /bin/bash
// 关闭容器
docker stop containerID
docker kill containerID
// 启动容器
docker start containerID
// 进入一个容器
docker attach containerID
或docker exec -i -t containerID bash
// 退出一个容器
先ctrl + P，再ctrl + Q
或ctrl + D
// 删除容器
docker rm containerID
// 查看日志
docker logs -f containerName
// 查看端口映射
docker port containerName 端口号
// 从容器拷贝文件到host
docker cp <containerId>:/filepath /host/path

// 清理系统
docker system info
docker system prune -a --volumes
docker image prune
docker container prune
docker volume prune
docker network prune
```
