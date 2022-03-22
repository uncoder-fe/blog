---
title: "cloudflare-workers-cors"
date: 2022-03-22T16:01:25+08:00
description: ""
author: "uncoder-fe"
tags: ["cors"]
categories: ["cloudflare"]
slug: ""
---

看清楚报错原因，在处理headers

<!--more-->

```js
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET,HEAD,POST,OPTIONS',
  'Access-Control-Max-Age': '86400',
};
addEventListener('fetch', event => {
  const data = {
    hello: 'world',
  };

  const json = JSON.stringify(data, null, 2);
  const respHeaders = {
      ...corsHeaders,
      'Access-Control-Allow-Headers': event.request.headers.get('Access-Control-Request-Headers'),
  };
  const response =  new Response(json, {status: 200, headers: respHeaders});
  return event.respondWith(response);
});
```


构造跨域请求，mode:cors，进行Preflight_request

```js
fetch(url, {
    method: "GET",
    mode: "cors",
    cache: "no-cache",
    // credentials: "same-origin",
    headers: {
      'Content-Type': 'application/json'
      // 'Content-Type': 'application/x-www-form-urlencoded',
    },
    redirect: "follow",
    referrer: "no-referrer", // no-referrer, *client
  })
```