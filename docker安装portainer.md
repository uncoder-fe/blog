---
title: "docker安装portainer"
date: 2022-03-19T16:01:25+08:00
description: ""
author: "uncoder-fe"
tags: ["hpe"]
categories: ["虚拟机"]
slug: ""
---
 


<!--more-->

0. 获取镜像
```
portainer/portainer-ce
```

1. 
```
docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce
```

2. 访问

```
https://ip:9443/#!/home
```
