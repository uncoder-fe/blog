---
title: "树莓派之安装nextcloud"
date: 2019-01-16T00:09:14+08:00
author: "uncoder-fe"
tags: ["raspberry", "docker", "nextcloud"]
categories: ["服务器相关"]
slug: ""
---

容器运行后，需要使用域名访问，然后进入 web 的安装界面，配置账户/数据库等。

<!--more-->

# 运行 nextcloud 容器

配置`docker-compose.yml`

```yml
version: "2"
services:
  app:
    image: arm32v7/nextcloud
    ports:
      - 8080:80
    links:
      - db
    volumes:
      - /home/pi/myfolder/nextcloud/nextcloud:/var/www/html
    restart: always
```

```bash
docker-compose up -d
```

# 获取容器的 IP

通过容器的 IP(比如：172.18.0.2)，可以获取同一网段宿主机的映射 IP(172.18.0.1)

```bash
apt-get update
# 安装ifconfig
apt install net-tools
# 安装ping
apt install iputils-ping
# 安装mysql客户端
apt install  mysql-client
# 查看容器ip
ifconfig
# 测试与宿主机连通性
ping 172.18.0.1
# 测试容器是否可以连接宿主机mysql
mysql -h 172.18.0.1 -u root -p
```

# 使用宿主机的 mysql

宿主机进入 mysql，调整账号`root`权限配置

```sql
mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
mysql>flush privileges;
```

命令注释：

```bash
# 其中各字符的含义：
# *.* 对任意数据库任意表有效
# "root" "123456" 是数据库用户名和密码
# '%' 允许访问数据库的IP地址，%意思是任意IP，也可以指定IP
# flush privileges 刷新权限信息
```

# 若 nextcloud 安装界面配置数据库依然连接失败

有可能宿主机 mysql 程序，只允许本地 socket 连接。
修改 mysql 配置，查找`/etc/my.cnf`或`/etc/mysql/conf.d/mysql.cnf`或`/etc/mysql/mariadb.conf.d/50-server.cnf`

```bash
vim /etc/mysql/mariadb.conf.d/50-server.cnf
# 注释 skip_networking 或者 bind_address
# bind_address=127.0.0.1
```

# 更改 nextcloud 的文件目录

```bash
# 停止服务后
vim /var/www/nextcloud/config/config.php
```

寻找`datadirectory`，修改你想要保存的目录`/var/data`，并把`datadirectory`目录里的所有文件拷贝到指定的目录。并修改一致的用户/组权限。

```bash
# 查看当前用户
who
# 查看pi组里的成员
groups pi

chown -R pi:pi /var/data
chmod 755 data
```

注意：容器使用宿主的数据库是不推荐的，生产不要这样使用。

# 一键安装 nextCloud

这里我们使用 docker 进行[安装](https://hub.docker.com/r/arm32v7/nextcloud)

```yml
# 创建docker-compose.yml, 填入
version: "2"
volumes:
  nextcloud:
  db:
services:
  db:
    image: hypriot/rpi-mysql
    restart: always
    volumes:
      - /home/pi/myfolder/nextcloud/db:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=
      - MYSQL_PASSWORD=
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
  app:
    image: arm32v7/nextcloud
    ports:
      - 8080:80
    links:
      - db
    volumes:
      - /home/pi/myfolder/nextcloud/nextcloud:/var/www/html
    restart: always
```

登陆时，数据库地址填`db`即可
