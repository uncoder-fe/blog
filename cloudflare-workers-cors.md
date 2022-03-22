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