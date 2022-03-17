---
title: "esxi硬盘RDM直通"
date: 2022-03-17T16:01:25+08:00
description: ""
author: "uncoder-fe"
tags: ["esxi"]
categories: ["虚拟机"]
slug: ""
---


RDM直通和挂载

<!-- more -->
# RDM直通
1. 找到磁盘号（存储-设备）选项卡

```
// 小括号里的内容
Local ATA Disk (t10.ATA_____HITACHI_HTS545032B9A300_________________091209PBNC041YG058GR
```

2. 找到目标vmfs的号

```
/vmfs/volumes/622c8bd0-22b5b4d4-de08-b47af13393f0
```
3. ssh登陆ESXI

```
vmkfstools -z /vmfs/devices/disks/t10.ATA_____WDC_WD3200BEVT2D22ZCT0________________________WD2DWX30AC9J7619 /vmfs/volumes/622c8bd0-22b5b4d4-de08-b47af13393f0/320G-wd.vmdk
```
4. 使用时添加硬盘即可


# 硬盘挂载

参考：[传送门](https://zhuanlan.zhihu.com/p/35774442)

0. 查看当前磁盘
Disk 磁盘
Device 分区
```
sudo fdisk -l

Disk /dev/sdb: 298.9 GiB, 320072933376 bytes, 625142448 sectors
Disk model: WDC WD3200BEVT-2
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x021fbde2
// 备注：当没有挂载时，下面的/dev/sdb1不存在
Device     Boot Start       End   Sectors   Size Id Type
/dev/sdb1        2048 625142447 625140400 298.1G 83 Linux


Disk /dev/sda: 30 GiB, 32212254720 bytes, 62914560 sectors
Disk model: Virtual disk    
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 57D5FF8C-10A3-45E7-B2F2-04F2424520EA

Device       Start      End  Sectors  Size Type
/dev/sda1     2048     4095     2048    1M BIOS boot
/dev/sda2     4096  3149823  3145728  1.5G Linux filesystem
/dev/sda3  3149824 62912511 59762688 28.5G Linux filesystem
```

1. 格式化挂载的磁盘为ext4格式

```
sudo mkfs -t ext4 /dev/sdb
```

2. 新硬盘分区
```
sudo fdisk /dev/sdb
- n 命令创建新分区
- p 命令创建一个主分区
- 选择默认创建第一个分区
- 设置分区的开始位置
- 设置分区的结束位置，因为只设置一个分区，因此都选择默认选项
- w 命令保存分区设置
```

3. 重新格式化

```
sudo mkfs -t ext4 /dev/sdb1
```

4. 挂载分区

```
这里直接挂载到 ~ 目录
sudo mount /dev/sdb1 ~
```

5. 查看是否成功

df命令

```
Filesystem                        1K-blocks    Used Available Use% Mounted on
udev                                 970472       0    970472   0% /dev
tmpfs                                203092    1200    201892   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv  14638072 4502912   9371872  33% /
tmpfs                               1015452       0   1015452   0% /dev/shm
tmpfs                                  5120       0      5120   0% /run/lock
tmpfs                               1015452       0   1015452   0% /sys/fs/cgroup
/dev/loop0                            63488   63488         0 100% /snap/core20/1328
/dev/loop2                            44672   44672         0 100% /snap/snapd/14978
/dev/loop1                            68864   68864         0 100% /snap/lxd/21835
/dev/sda2                           1515376  112476   1307876   8% /boot
/dev/sdb1                         306615568   65564 290905112   1% /home/uuu
tmpfs                                203088       0    203088   0% /run/user/1000
```

6. 开启自动挂载

重启后发现挂载消失了，所以开启自动挂载

6.1 查看
```
ls -l /dev/disk/by-uuid

lrwxrwxrwx 1 root root 10 Mar 17 15:06 48231779-5869-4922-a4c1-618179053280 -> ../../sdb1
```
6.2 备份原有的 /etc/fstab 文件
```
sudo cp /etc/fstab /etc/fstab.bak
```
6.3 编辑/etc/fstab,粘贴
```
# /home/uuu
UUID=48231779-5869-4922-a4c1-618179053280 /home/uuu       ext4    defaults        0       2
```
