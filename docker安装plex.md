---
title: "docker安装plex"
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
docker pull plexinc/pms-docker
```

1. 若要索取您的Plex Media Server，请复制以下索取码，并将其粘贴到请求应用中。（可以使用谷歌邮箱登录）
https://www.plex.tv/zh/claim
此索取码将在4分钟后过期。

2. 

配置文件目录
```
docker run \
-d \
-e PUID=0 \
-e PGID=0 \
--device /dev/dri:/dev/dri \
--name plex \
--network=host \
-e TZ="Aisa/Shanghai" \
-e PLEX_CLAIM="替换索取码" \
-v ~/plex/media/plex/config:/config \
-v ~/plex/media/plex/transcode:/transcode \
-v ~/minio:/data \
plexinc/pms-docker
```

3. 访问web

```
https://ip:32400/web
```

4.登陆,设置语言中文，视频目录（可以从portainer调整）
5. 禁用视频流转码，直连传输（硬解需要开会员，hpe由于开启了ilo，所以硬解又被屏蔽了，需要插独显）
