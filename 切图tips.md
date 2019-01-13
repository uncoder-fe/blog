---
title: "切图tips"
description: ""
date: 2016-12-13T16:15:50+08:00
author: "uncoder"
tags: []
categories: ["javascript"]
slug: ""
---

updateTime:2017 年 5 月 27 号安卓和苹果的前端问题，不定时更新噢。

# js 篇

* `console.log`和 debugger 的结果时效性是不一致的，使用 highcharts 定制轴坐标导致问题。
* 不要使用`innerHTML`获取数据
* fastclick 库会导致 fixed 的元素中的 input 光标位置偏移
* canvas 的锯齿有可能是没有清空画布导致的
* canvas 中使用特殊字体，文字一定要现在页面里渲染后方可使用，否则无效
* canvas 某些机型存在清空画布失败，绘制半截的情况，用下面代码解决

```
overflow:visible;
-webkit-transform: translateZ(0);
          transform: translateZ(0);
```

* canvas 透明像素生成 jpeg 格式的 base64 图片之后，会变黑，用 png 替换
* canvas 如果使用 scale ，translate，先 save 保存下状态
* rem 布局相当于一个比例尺的缩放，尺子有多大自定
* 键盘遮挡提示语问题（监听 focus 和 resize 事件，一两个 input 还行，多了蛋碎）
* zepto.js 的 tap 事件没发阻止默认
* zepto.js 的 tap 事件会影响子元素的 focus 事件手动触发
* 用阻止冒泡来控制外部元素(滚动，触发 xxx 函数等事件)
* 禁用滚动可以用 overflow 或者以下 hack

```
document.addEventListener('touchmove', function(event) {
     //判断条件,条件成立才阻止背景页面滚动,其他情况不会再影响到页面滚动
    if(!$(".mask").is(":hidden")){
         event.preventDefault();
    }
});
```

* touch 常用事件都没反应时候，记得加上 touchcancel 这个处理异常的试试
* 移动端 scroll 监听不精确，可以使用`touchstart touchmove touchend touchcancel`，在加上定时器配合监听
* scrollTop 属性可以使用 jquery 的 animate 来过渡

```
  $('html, body').animate({ scrollTop: 300 }, 600);
```

* 时间戳，安卓和 ios 有区别，详情忘了
* `requestAnimateFrame`在低端机需要兼容性处理
* `window.requestAnimationFrame`的 ID，如果想 cancel，一定是要在最后一帧，否则需要 return 来关闭；
* `window.location.replace`，IOS 有可能会触发上个页面的 ajax
* 安卓某些手机不支持 css3 动画的自定义贝塞尔动画曲线
* IOS 微信 webview 可能不能直接修改 title

```
//以下代码可以解决以上问题
setTimeout(function(){
	//利用iframe的onload事件刷新页面
	document.title = '多少人暗恋我';
	var iframe = document.createElement('iframe');
	iframe.style.visibility = 'hidden';
	iframe.style.width = '1px';
	iframe.style.height = '1px';
	iframe.onload = function () {
		setTimeout(function () {
			document.body.removeChild(iframe);
		}, 0);
	};
	document.body.appendChild(iframe);
},0);
```

* touchend 替代 click 不友好，触发太灵敏，有种莫名其妙的错觉
* 使用`animationend`监听 css3 动画结束，安卓某些机型需要加 webkit 前缀
* 使用延迟避免键盘消失后，弹出层为 fixed 的高度计算错误问题

```
$('.mask').show();
setTimeout(function(){
	window.scrollTo(0,75);
},300);
```

* 微信不能使用`window.location.reload`进行刷新，不知道那个二货开发的，URL 不变就缓存
* textarea 的空格回车符保留，1，用 textarea 显示
* 红米手机中，scrollTop+offsetHeight 不一定等于 scrollHeight;
  -addEventListener 绑定事件可以传入一个对象而不是一个 cb 函数，事件触发的时候，就会调用该对象的 handleEvent 方法来处理事件
* 原型的方法不会声明提升，要先定义后调用
* getComputedStyle 立即刷新样式

# css 篇

* 事件绑定用 id，样式用 class
* `overflow:scroll`,可以引发重绘，并且 js 设置 scrollTop 依然可以滚动
* 页面留出`padding-bottom`这种空白比较好
* html,body 的高度，除非是一屏，不要设置 100%，会影响页面其他元素的高度计算
* html,body 的高度设为 100%，解决一些 fixed 元素定位错误的问题，不过同时有可能导致安卓手机键盘挡住输入框的现象
* 使用一个新的容器 viewport 元素替代 body，罩层类的元素和 viewport 同级，这样可使用上面的方法，罩层滚动可以阻止 viewport 滚动，修复安卓滚动闪动的情况，最优解：使用 transform 滑动替代原生滚动
* 元素居中方便的做法`text-aligin:center;display:inline-block;`
* `text-indent`可改变元素位置，影响到布局
* input 输入框，`disable`后透明度会改变
* `position:relative`定位元素多于一定量级，会造成页面卡顿，增加计算
* input 的 placeholder 可以用背景图片，空字符占位，缺点是适配需要考虑图片尺寸显示不全
* span 插入如果不加空格，原先的`display:inline-block;`样式会丢失
* 用图片当背景,高度尽量不要低于 2px，Retina 屏幕
* css3 圆角在安卓机白边，`background-clip`修复
* 安卓某些机型：overflow 会导致此元素跟随页面滚动(外层也是 overflow，即双层 overflow 滑动)
* maxlength 属性，计算不准确，比如 emoji 表情
* 在 IOS 里，使用 transform 的 translate 的值为`负值`时候，要设置 origin
* box-shadow 某些安卓手机里需要完整的参数:0 0 0 0 #995eff，色值没法继承
* 尽量使用 border-radius:100%，虽然 50％效果看起来一样
* 三星某些手机使用 relative 之后，默认行为会消失（比如 a 标签跳转），渲染问题备注：二次测试发现，内部元素的事件，必须手动触发二次渲染才能生效
* 1px 像素显示细一点的办法，把颜色调淡一些
* `font-weight`失效可能与字体有关
* video 的播放面板，视频高度超出当前屏幕的高度，Mac 的屏幕里显示会消失，而外接显示器没问题。（这又是为什么）
* font-size，line-height，font-family 都会影响自适应高度的计算
* justify-content: center;会导致 scroll 的高度遮挡。
* 某某安卓手机使用 flex 会导致 body 消失了
