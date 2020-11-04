---
title: "使用GitHub的workflow发布hugo博客"
date: 2020-11-04T16:01:25+08:00
description: ""
author: "uncoder-fe"
tags: ["git","workflow"]
categories: ["其他"]
slug: ""
---

以前是使用Travis CI提供的服务进行构建的，现迁移到GitHub自带的actions来构建部署。

<!--more-->

# 新建一个token

在待访问仓库设置（路径如下）里，新建一个token用来clone/push

```bash
settings/secrets
```


# 新建pipeline配置

```bash
.github/workflows/blank.yml
```

## 指定action名称

```
name: deploy gh-pages
```

## 指定触发事件以及分支

```
on:
  push:
    branches:
      - master
```

## 设置运行环境，以及环境变量

`secrets.COMMIT_TOKEN`为第一步创建的token

```
jobs:
  build:
    runs-on: macOS-latest
    env:
      TOKEN: ${{ secrets.COMMIT_TOKEN }}
      USER_NAME: uncoder-fe
      USER_EMAIL: uncoder-fe@fake.com
```

## 获取markdown文件

注意`submodules`（获取Hugo主题时使用），以及`token`参数（访问仓库）

```
steps:
      - name: "Checkout"
        uses: actions/checkout@v2
        with:
          submodules: true
          token: ${{ secrets.COMMIT_TOKEN }}
          repository: uncoder-fe/blog-backup
```

## 安装Hugo

注意`cd ..`，保持`myblog`目录和`$GITHUB_WORKSPACE`是同级的。

```
 - name: "hugo install"
        run: |
          echo "准备环境" 
          brew install hugo
          cd ..
          hugo new site myblog
          mkdir myblog/content/posts
          cd myblog
          git init
          git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
```

## 博客构建

注意`$GITHUB_WORKSPACE`变量(The GitHub workspace directory path)，此为内置的环境变量，更多其他变量[参考](https://docs.github.com/en/free-pro-team@latest/actions/reference/environment-variables)，此外，`$GITHUB_WORKSPACE`是每一个步骤命令致性的当前目录

```
- name: "hugo build"
        run: |  
          echo "开始构建"
          cd ..
          mv $GITHUB_WORKSPACE/config.toml myblog
          mv $GITHUB_WORKSPACE/*.md myblog/content/posts
          cd myblog
          hugo --minify
```

## 博客部署

```
- name: "hugo deploy"
        run: |
          echo "开始部署"
          cd ..
          cd myblog/public
          git init
          git config --local user.name $USER_NAME
          git config --local user.email $USER_EMAIL
          git status
          git remote add origin https://$TOKEN@github.com/$USER_NAME/$USER_NAME.github.io.git
          git add .
          git commit -m "Update by github actions"
          git push origin master -f
          echo "部署完成".
```