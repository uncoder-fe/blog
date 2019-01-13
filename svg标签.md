---
title: "svg标签"
date: "2016-07-05T15:23:03+08:00"
author: "uncoder"
tags: []
categories: ["svg"]
slug: ""
---

## svg 介绍

不会翻译，照抄过来的。
SVG is short for Scalable Vector Graphics. It is a graphic format in which the shapes are specified in XML. The XML is then rendered by an SVG viewer. Today most web browser can display SVG just like they can display PNG, GIF, and JPG.

<!--more-->

备注：

## 坐标系统

知道就行了，左上角是原点

## g 标签

svg 标签对旋转，移动（还有其他）不能用，g 标签可以

## 画个矩形

```html
<rect x="10" y="10" height="100" width="100" style="stroke:#006600; fill: #00cc00"/>
```

## 画个圆(circle)

```html
<circle cx="40" cy="40" r="24" style="stroke:#006600; fill:#00cc00"/>
```

## 画个椭圆(ellipse)

```html
<ellipse cx="40" cy="40" rx="30" ry="15" style="stroke:#006600; fill:#00cc00"/>
```

## 画根线(line)

```html
<line x1="10" y1="10" x2="100" y2="100" style="stroke:#006600;"/>
```

## 画条折线(polyline)

```html
<polyline points="0,0  30,0  15,30  0,0" style="stroke:#006600;fill:none"/>
```

## 画个多边形(polygon)

```html
<polygon points="10,0  60,0  35,50" style="stroke:#660000; fill:#cc3333;"/>
```

## 画条路径线(path)

```html
<path d="
     M10,10
     A30,30 0 0,1 35,20
     H50,50
     V60,100
     L130,150
     M140,150
     L180,190"
     style="stroke:#660000; fill:none;"/>
```

备注：
M 参数：x y
功能：将画笔移动到点(x,y)
L 参数：x y
功能：画笔从当前的点绘制线段到点(x,y)
H 参数：x
功能：画笔从当前的点绘制水平线段到点(x,y0)
V 参数：y
功能：画笔从当前的点绘制竖直线段到点(x0,y)
A 参数：rx ry x-axis-rotation large-arc-flag sweep-flag x y
rx,ry 指椭圆的两个半轴大小
x-axis-rotation 指椭圆的 x 轴与水平方向顺时针方向夹角，可以想像成一个水平的椭圆绕中心点顺时针旋转的角度
large-arc-flag 表示是否选择弧长较长的那段弧线，1 表示大角度弧线，0 为小角度弧线
sweep-flag 确定起点至终点的方向，1 为顺时针，0 为逆时针
x,y 弧的终点坐标
功能：画笔从当前的点绘制一段圆弧到点(x,y)
C 参数：x1 y1, x2 y2, x y
功能：画笔从当前的点绘制一段三次贝塞尔曲线到点(x,y)
S 参数：x2 y2, x y
功能：光滑版本的三次贝塞尔曲线(省略第一个控制点)
注释：1.如果上一个曲线也是贝塞尔曲线，那么在与上一个曲线的交界处，省略的第一个控制点与上一个曲线的第二个控制点关于交界点是镜像关系；2.如果上一个曲线不是贝塞尔曲线，那么会把上一个图形的终点位置作为贝塞尔曲线的第一个控制点
Q 参数：x1 y1, x y
功能：绘制二次贝塞尔曲线到点(x,y)
T 参数：x y
功能：光滑版本的二次贝塞尔曲线(省略控制点)
注释：同 S 的注释
Z 无参数功能：绘制闭合图形，如果 d 属性不指定 Z 命令，则绘制线段，而不是封闭图形。注意：命令区分大小写，大写表示坐标参数为绝对位置，小写为相对位置（相对于当前画笔的相对位置）；最后的参数表示最后要到达的位置；上个命令结束的位置就是下一个命令开始的位置；命令可以重复参数表示重复执行同一条命令。

[贝塞尔曲线](http://www.jasondavies.com/animated-bezier/)

## 画个标记(marker)

定义了用于在特定的`<path>, <line>, <polyline> or <polygon>`元素上绘制箭头或者多点标记图形

```html
<defs>
    <marker id="markerCircle" markerWidth="8" markerHeight="8" refX="5" refY="5">
        <circle cx="5" cy="5" r="3" style="stroke: none; fill:#000000;"/>
    </marker>
    <marker id="markerArrow" markerWidth="13" markerHeight="13" refX="2" refY="6"
           orient="auto">
        <path d="M2,2 L2,11 L10,6 L2,2" style="fill: #000000;" />
    </marker>
</defs>
<path d="M100,10 L150,10 L150,60"
      style="stroke: #6666ff;
             stroke-width: 1px; fill: none;
             marker-start: url(#markerCircle);
             marker-end: url(#markerArrow);"/>
```

## 画文字(text)

```html
<text x="20" y="40">你是一条多毛虫</text>
```

## 画 tspan

文本和字体属性以及当前文本的位置通过包含 tspan 元素的绝对或相对坐标可以调整

```html
<text x="20" y="10">
    <tspan>tspan line 1</tspan>
    <tspan>tspan line 2</tspan>
</text>
```

## 画个 tref

通过 tref 元素来指定的包含字符的元素的引用。

```html
<defs>
    <text id="theText">经测试，没什么卵用</text>
</defs>
<text x="20" y="10">
    <tref xlink:href="#theText" />
</text>
```

## 画个 textPath

SVG 也可以根据`<path>`元素的形状来绘制文字

```html
<defs>
    <path id="myTextPath"
          d="M75,20
             a1,1 0 0,0 100,0"/>
</defs>
<text x="10" y="100" style="stroke: #000000;">
  <textPath xlink:href="#myTextPath" >
        Text along a curved path...
  </textPath>
</text>
```

## 画个 iamge

```html
<image x="20" y="20" width="300" height="80" xlink:href="http://sfault-avatar.b0.upaiyun.com/205/668/2056686630-1030000000479842_huge256" />
```

## 画个 a

```html
<a xlink:href="http://uncoder-.github.io/" target="_blank">
    <text x="10" y="80">http://uncoder-.github.io/
     (target="_blank")</text>
</a>
```

## 标签 defs

SVG 允许我们定义以后需要重用的图形元素。 而且我们总是推荐把所有需要复用的元素定义在`<defs>`元素里面。这样做可以增加 SVG 内容的易读性和可访问性。 在`<defs>`中定义的图形元素不会直接地渲染。你可以通过使用 `<use>` 元素来在你的视窗中任意地方需然这些元素。

```html
<defs>
    <g id="shape">
        <rect x="50" y="50" width="50" height="50" />
        <circle cx="50" cy="50" r="50" />
    </g>
</defs>
<use xlink:href="#shape" x="50" y="50" />
```

## 标签 symbol

symbol 元素用于定义一个可通过`<use>`元素来实例化的图形模板对象。

```html
<symbol id="shape2">
    <circle cx="25" cy="25" r="25" />
</symbol>
<use xlink:href="#shape2" x="50" y="25" />
```

## 标签 use

```html
<svg width="500" height="110">
    <g id="shape2">
        <rect x="0" y="0" width="50" height="50" />
    </g>
    <use xlink:href="#shape2" x="200" y="50" />
</svg>
```

## 设置 stroke

```html
<circle cx="50" cy="50" r="25"
        style="stroke: #000066;
        stroke-width: 1px;
        stroke-linecap: round;
        stroke-linejoin: round;
        stroke-miterlimit: 4.0;
        stroke-dasharray: 10 5;
        stroke-opacity: 0.5;
        fill: #3333ff;" />
```

## 设置 fill

## Viewport and View Box

viewBox 属性允许指定一个给定的一组图形伸展以适应特定的容器元素。

```html
<svg width="500" height="300"></svg>
<svg width="500" height="200" viewBox="0 0 50 20" >
    <rect x="20" y="10" width="10" height="5" style="stroke: #000000; fill:none;"/>
</svg>
```

## 动画

```html
<rect x="10" y="10" height="110" width="110"
     style="stroke:#ff0000; fill: #0000ff">
    <animateTransform
        attributeName="transform"
        begin="0s"
        dur="20s"
        type="rotate"
        from="0 60 60"
        to="360 60 60"
        repeatCount="indefinite"
    />
</rect>
```

## 标签 pattern

pattern 用于对一个对象使用预定义的可以用固定间隔在 x 和 y 轴重复（或平铺）的图形进行填充或者描边。使用 pattern 元素进行样式的定义，然后给指定要填充或者描边的元素引用定义的描边和填充属性。

```html
<defs>
  <pattern id="pattern1" x="10" y="10" width="20" height="20" patternUnits="userSpaceOnUse" >
      <circle cx="10" cy="10" r="10" style="stroke: none; fill: #0000ff" />
  </pattern>
</defs>
<rect x="10" y="10" width="100" height="100" style="stroke: #000000; fill: url(#pattern1);" />
```

## 标签 mask

在 SVG 中，你可以定义任意其他图形对象 或者`<g>` 元素作为一个透明的遮罩层和当前元素合成. mask 元素用于定义这样的遮罩层. 一个遮罩层引用 mask 元素属性.

```html
<defs>
    <linearGradient id="gradient1"
                    x1="0%"   y1="0%"
                    x2="100%" y2="0%"
                    spreadMethod="pad">
        <stop offset="0%"   stop-color="#ffffff" stop-opacity="1"/>
        <stop offset="100%" stop-color="#000000" stop-opacity="1"/>
    </linearGradient>

    <mask id="mask4" x="0" y="0" width="200" height="100" >
        <rect x="0" y="0"  width="200" height="100"
            style="stroke:none; fill: url(#gradient1)"/>
    </mask>
</defs>

<text x="10" y="55" style="stroke: none; fill: #000000;">
    This text is under the rectangle
</text>
<rect x="1" y="1" width="200" height="100"
    style="stroke: none; fill: #0000ff; mask: url(#mask4)"/>
```

## 渐变

```html
<defs>
    <linearGradient id="MyGradient">
        <stop offset="5%"  stop-color="green"/>
        <stop offset="95%" stop-color="gold"/>
    </linearGradient>
</defs>

<rect fill="url(#MyGradient)" x="10" y="10" width="100" height="100"/>
```

## 滤镜

```html
<defs>
    <filter id="blurFilter4" x="-20" y="-20" width="200" height="200">
        <feGaussianBlur in="SourceGraphic" stdDeviation="10" />
    </filter>
</defs>
<rect x="20" y="20" width="90" height="90" style="stroke: none; fill: #00ff00; filter: url(#blurFilter4);" />
```

## 使用 CSS3 让 path 动起来

```css
#path {
  stroke-dasharray: 1000;
  stroke-dashoffset: 1000;
  animation: dash 2s linear infinite;
}

@keyframes dash {
  to {
    stroke-dashoffset: 0;
  }
}
```
