---
title: "Centos之上网配置"
description: ""
date: 2018-01-08T17:07:52+08:00
author: "uncoder"
tags: ["centos"]
categories: ["服务器"]
slug: ""
---

企业生产用这个系统比较多，打算个人以后用 centos

<!--more-->

# 安装依赖(如果自己build)

```
yum install epel-release -y
yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y
```

[address](https://github.com/shadowsocks/shadowsocks-libev)

# 设置 yum 源

地址（ https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/ ）

# 创建文件

```
touch /etc/yum.repos.d/shadowsocks-libev.repo
```

# 加入

```
[librehat-shadowsocks]
name=Copr repo for shadowsocks owned by librehat
baseurl=https://copr-be.cloud.fedoraproject.org/results/librehat/shadowsocks/epel-7-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/librehat/shadowsocks/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
```

# 安装 shadowsocks-libev

```
yum update
yum install shadowsocks-libev
```

# 修改 ss 配置

```
/etc/shadowsocks-libev/config.json
{
    "server":"0.0.0.0",
    "server_port":33333,
    "local_port":1080,
    "password":"your password",
    "timeout":60,
    "method":"chacha20-ietf-poly1305"
}
```

# 设置服务

```
在/usr/lib/systemd/system/shadowsocks-libev.service，添加以下shell命令
ExecStart=/usr/bin/ss-server -c /etc/shadowsocks-libev/config.json
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
KillMode=process
```

# 启动服务

```
systemctl status shadowsocks-libev.service
systemctl start shadowsocks-libev.service
systemctl stop shadowsocks-libev.service
systemctl enable shadowsocks-libev.service //开机自启动
systemctl disable shadowsocks-libev.service
```

# 开放防火墙端口

```
firewall-cmd --zone=public --add-port=8388/tcp --permanent
firewall-cmd --zone=public --add-port=8388/udp --permanent
firewall-cmd --reload
```

# 开启 bbr

0. 查看当前内核`uname -r`
1. 下载更换内核(4.9 以上才能使用)
   最新[内核](http://elrepo.org/linux/kernel/el7/x86_64/RPMS/)

```bash
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
yum --enablerepo=elrepo-kernel install kernel-ml -y
```

2. 查看当前内核`rpm -qa | grep kernel`
3. 查看内核列表`awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg`
3. 设置最新内核启动`grub2-set-default 0`
4. 重启`reboot`
5. 检查`uname -r`是否大于 4.9
5. 查看系统`cat /proc/version`/`cat /etc/os-release`
6. 更新配置`/etc/sysctl.conf`

```bash
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
```

7. 生效`sysctl -p`
8. 检查`lsmod | grep bbr`，若已经运行，则安装成功来源

备注：

执行程序时，若报错
```
ss-server: error while loading shared libraries: libmbedcrypto.so.0: cannot open shared object file: No such file or directory

解决方案：
cd /usr/lib64
// 查找
ll | grep libmbedcrypto
// 比如，这里是把so指向so.0
ln -s libmbedcrypto.so libmbedcrypto.so.0
```



[参考1](https://github.com/iMeiji/shadowsocks_install/wiki/%E5%BC%80%E5%90%AFTCP-BBR%E6%8B%A5%E5%A1%9E%E6%8E%A7%E5%88%B6%E7%AE%97%E6%B3%95)

[参考2](https://www.isthnew.com/archives/centos7-bbr.html)

搞定收工
