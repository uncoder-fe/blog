---
title: "vps折腾记录"
description: ""
date: 2017-10-27T10:02:00+08:00
author: "uncoder"
tags: ["服务器", "debian"]
categories: ["服务器相关"]
slug: ""
---

# OS 选择以及使用

```shell
debian 9
/var/log  通用日志
/etc      通用配置文件

修改ssh端口
/etc/ssh/sshd_config
/etc/ssh/ssh_config
service ssh restart

查看占用
netstat -lnp | grep ss-server

查看进程
ps -ax | grep ss-server

结束PID对应的进程
kill -9 [PID]

查找文件
find . -name "*.json"

查看所有端口使用
netstat –apn
netstat -anp|grep 80

查看80端口使用
lsof -i:80

结束nginx
pkill -9 -f nginx

后台挂起运行
nohup xxxxxx &

下载文件
scp -r root@0.0.0.0: /folder /localfolder
```

<!--more-->

## 安装 docker

[传送门](http://www.jishux.com/plus/view-605986-1.html)

1.编辑/etc/apt/sources.list 文件，加入:
`deb http://http.debian.net/debian jessie-backports main` 

2.更新源`apt-get update`

3.安装`apt-get install docker.io`

# 安装 nodejs

[传送门](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)

```bash
curl -sL https://deb.nodesource.com/setup_8.x | bash - apt-get install -y nodejs
```

# 安装 nginx

[传送门](http://nginx.org/en/linux_packages.html)

```bash
apt-get install nginx
//配置文件
/etc/nginx/sites-available/default
```

## 友好上网

```bash
// 下载
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive
// 编译环境
## Debian / Ubuntu
sudo apt-get install --no-install-recommends gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev
# 安装加密
export LIBSODIUM_VER=1.0.15
wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz
tar xvf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr && make
sudo make install
popd
sudo ldconfig
# 安装加密
export MBEDTLS_VER=2.6.0
wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz
tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz
pushd mbedtls-$MBEDTLS_VER
make SHARED=1 CFLAGS=-fPIC
sudo make DESTDIR=/usr install
popd
sudo ldconfig
# 编译安装
./autogen.sh && ./configure && make
sudo make install
# 新建配置文件,目录随意
/etc/shadowsocks-libev/config.json
内容如下
{
    "server": "0.0.0.0",
    "server_port": 8888,
    "local_port": 1080,
    "password": "xxxxxx",
    "timeout": 500,
    "method": "chacha20-ietf-poly1305"
}
# 后台运行
nohup ss-server -c /etc/shadowsocks-libev/config.json -u &
```

[传送门](https://github.com/shadowsocks/shadowsocks)、[传送门](https://github.com/shadowsocks/shadowsocks-libev)
