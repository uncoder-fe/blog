---
title: "Vscode调试nodejs的几种方法"
description: ""
date: 2018-01-23T20:50:50+08:00
author: "uncoder"
tags: []
categories: ["其他"]
slug: ""
---

这里说明通过 vscode 调试 nodejs 程序的几种方式，本身使用的还是 调用nodejs 自带的调试工具。

<!--more-->

[文档入口](https://nodejs.org/en/docs/inspector/)。这里说的是主线程调试，通过 spawn 开启的子进程暂时没找到方法。而 fork 可以的。

# 第一种配置

最原始的，配置程序路径，启动条件，启动参数，端口号

nodejs: 启动程序

```json
//launch.json
{
  "type": "node",
  "request": "launch",
  "name": "Launch Program",
  "program": "${workspaceFolder}/build/bin/test-scripts.js",
  "runtimeArgs": ["--inspect-brk=9229"],
  "args": ["init"],
  "port": 9229
}
```

# 第二种配置

nodejs: npm 启动

```json
//package.json
"scripts": {
    "start": "taskr",
    "build": "taskr build",
    "debug": "node --inspect-brk=9229 ./build/scripts/ax-rn-scripts.js init"
},
//launch.json
{
    "type": "node",
    "request": "launch",
    "name": "Launch via NPM",
    "runtimeExecutable": "npm",
    "runtimeArgs": [
        "run",
        "debug"
    ],
    "port": 9229
},
```

# 第三种配置

这个方法和第二种类似，只是程序是从 shell 启动，然后在 vscode 中通过进程 attach 进去。

nodejs: 附加到进程

方法：

1. 命令行启动 nodejs 程序
2. 从 vscode 的 debugg 中选择`Attach by Process ID`
3. 选择已启动程序的进程即可(可以通过路径和端口号比对)

```json
//launch.json
{
  "type": "node",
  "request": "attach",
  "name": "Attach by Process ID",
  "processId": "${command:PickProcess}"
}
```
# 备注

使用`babel-node`调试，新增

```json
"runtimeExecutable": "${workspaceRoot}/node_modules/babel-cli/bin/babel-node.js"
```
