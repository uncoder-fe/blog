---
title: "WebAssembly之rust代码编译使用"
description: ""
date: 2018-04-03T20:10:25+08:00
author: "uncoder"
tags: ["rust"]
categories: ["javascript"]
slug: ""
---

基本操作、
<!--more-->

# 安装环境

```bash
// 安装rust
curl https://sh.rustup.rs -sSf | sh
// 更新版本
rustup update
// 安装开发版
rustup toolchain install nightly
// 安装打包依赖
rustup target add wasm32-unknown-unknown --toolchain nightly
<!-- 分割线 -->
// 安装压缩工具
cargo install --git https://github.com/alexcrichton/wasm-gc
// 压缩文件
wasm-gc hello.wasm small-hello.wasm
```

# 测试

```shell
// 新建文件hello.rs
extern {
    fn alert(ptr: *const u8, number: u32);
}

#[no_mangle]
pub extern fn run() {
    unsafe {
        let x = b"Hello World!\0";
        alert(x as *const u8, 42);
    }
}

// shell编译
rustc +nightly --target=wasm32-unknown-unknown -O --crate-type=cdylib hello.rs -o hello.wasm
// 命令备注
# +nightly 指明使用nightly版本
# --target 指定编译器后
# -O == -C opt-level=2
# -C opt-level=2 指定优化级别为2，范围是 0-3
# --create-type=cdylib 添加一个由编译器接受的crate类型，称为cdylib，它对应于从Rust动态库中导出的C接口。
# -o 指定输出文件名
```



