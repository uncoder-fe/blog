---
title: "Mac服务器配置"
date: "2016-05-05T15:23:03+08:00"
author: "uncoder"
tags: ["nginx","apache"]
categories: ["服务器相关"]
slug: ""
---

apache,nginx的基本配置，扩展安装
<!--more-->

### apache
- 获取root权限 `sudo su -`
- 开启服务 `apachectl start`
- 默认目录 `/etc/apache2`
- 编辑 `httpd.conf`文件
- 查找 `DocumentRoot` 这一行,选择网站根目录，下面两个目录保持一致
- 保存，重启apache服务器 `apachectl -k restart`
- '127.0.0.1'或'localhost'访问

---
### nginx
- brew安装 `brew install nginx`
- nginx运行
- `nginx -t && nginx -s reload`,检查语法错误，并重启
- 开机自动执行

```
ln -sfv /usr/local/opt/nginx/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist
```
- 安装目录/usr/local/Cellar/nginx/1.8.1
- nginx默认web目录是/usr/local/var/www
- 默认配置文件是/usr/local/etc/nginx/nginx.conf，并会加载/usr/local/etc/nginx/servers/目录下的所有配置
- 默认端口是8080
- `http://localhost:8080/`访问
### [参考](http://cnt1992.xyz/2016/03/18/simple-intro-to-nginx/)

---
### nginx的PHP扩展安装
- 先搜索需要安装的扩展，这里以redis为例

```
http://pecl.php.net/package/redis
```
- 下载解压，然后`phpize`,报错则`xcode-select --install`安装Unix开发环境
- 然后`./configure`
- 然后`make`，在module目录里面会生成＊.so文件
- 成功后编辑`sudo vi /etc/php.ini`加入下面代码

```
extension=/usr/lib/php/extensions/no-debug-non-zts-20121212/redis.so
```
- 注意no-debug-non-zts-20121212版本号，如果不清楚可以前往/usr/lib/php/extensions/查看
