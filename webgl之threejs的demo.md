---
title: "webgl之threejs的demo"
date: "2016-08-05T15:23:03+08:00"
author: "uncoder"
tags: []
categories: ["webgl"]
slug: ""
---

# 关于 webgl

此功能是基于 canvas 模拟，而不是真正的图形 api

<!--more-->

# 一些常识

此功能是基于 canvas 模拟，而不是真正的图形 api

# 一些常识

渲染器提供渲染，摄像机提供视角，场景提供容器

# 模型

由材料和模具构成

# threejs 的样板

```
var myCanvas: document.querySelector("#my-canvas");
// 渲染器
var renderer = new THREE.WebGLRenderer({canvas:myCanvas});
renderer.setSize( window.innerWidth, window.innerHeight );
renderer.setClearColor(0xffffff, 0);
// 场景
var scene = new THREE.Scene();
// 摄像机
var camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 1000 );
camera.position.set(0,0,150);
camera.lookAt(new THREE.Vector3(0,0,0));
scene.add(camera);
/*立方体*/
var curb = new THREE.Mesh(
    new THREE.BoxGeometry( 20, 20, 20 ),
    new THREE.MeshBasicMaterial({
        color:'green',
        overdraw: 0.5
    })
);
curb.position.set(-20,0,0);
scene.add(curb);
```

渲染器提供渲染，摄像机提供视角，场景提供容器

# 模型

由材料和模具构成

# threejs 的样板

```
var myCanvas = document.querySelector("#my-canvas");
// 渲染器
var renderer = new THREE.WebGLRenderer({canvas:myCanvas});
renderer.setSize( window.innerWidth, window.innerHeight );
renderer.setClearColor(0xffffff, 0);
// 场景
var scene = new THREE.Scene();
// 摄像机
var camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 1000 );
camera.position.set(0,0,150);
camera.lookAt(new THREE.Vector3(0,0,0));
scene.add(camera);
/*立方体*/
var curb = new THREE.Mesh(
    new THREE.BoxGeometry( 20, 20, 20 ),
    new THREE.MeshBasicMaterial({
        color:'green',
        overdraw: 0.5
    })
);
curb.position.set(-20,0,0);
scene.add(curb);
```
