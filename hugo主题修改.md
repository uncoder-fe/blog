---
categories: ["其他"]
tags: ["hugo","theme"]
author: "uncoder-fe"
date: "2017-01-05T15:30:53+08:00"
title: "hugo主题修改"
slug: ""
---

说是修改，完整改下来，也就学会如何重新制作新的了。
<!--more-->
# 开动前准备
1. 安装go环境，了解一下简单的go的html模版语法
2. 官方文档`https://gohugo.io/templates/go-templates/`
3. 随便安装一个主题

```bash
目录结构，大概如下
└── themes
    └── xxoo
        ├── LICENSE.md
        ├── README.md
        ├── archetypes
        │   └── default.md
        ├── layouts
        │   ├── 404.html
        │   ├── _default
        │   │   ├── list.html
        │   │   └── single.html
        │   ├── index.html
        │   ├── page
        │   │   └── single.html
        │   ├── partials
        │   │   ├── article-content.html
        │   │   ├── article-footer.html
        │   │   ├── article-header.html
        │   │   ├── article-sub.html
        │   │   ├── footer.html
        │   │   ├── header.html
        │   │   └── pagination.html
        │   └── post
        │       └── single.html
        ├── static
        │   ├── css
        │   │   ├── highlight.css
        │   │   └── style.css
        │   ├── img
        │   │   └── header.png
        │   └── js
        │       ├── jquery-3.1.1.min.js
        │       └── scripts.js
        └── theme.toml
```

# 文件修改
1. 我们需要调整的是`_default`目录下的`single.html,list.html`文件，如果没有自定义，就会使用此目录的模版
2. 若自定义文章的类型，类似上面的`post、page`文件夹，文章的头部要指定`type`，目录下的`single.html`会覆盖掉`_default`的样式

```markdown
    +++
    ...
    type = "page"
    ...
    +++
```

3. 找数据(重要的哦)，然后用这个网站格式化一下数据`http://jsbeautifier.org/`,要啥取啥

```
{{ printf "%#v" . }}
``` 

4. 每种页面上的`.`内的数据都不一样的
# 结束
0. 语法问题，这里帮不了你
1. 参考我的[仓库](git@github.com:uncoder-/hugo-theme-pokemon.git)
2. 上面都看不懂，选一个好的主题，修改`themes/主题名/static/css`目录下的样式`.css`文件即可
