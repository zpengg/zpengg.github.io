# XSS

## What
浏览器的同源策略
FE 需关注

在js 代码（DOM API）中 通过页面操作等注入恶意js 

恶意js 执行时可获取到 cookie 等敏感信息

## Where
1. DOM API
2. html属性
3. 一些前端框架或库时，谨慎使用一些不安全的函数：
比如jQuery的.html(), .append(), .prepend(), .wrap(), .replaceWith(), .wrapAll(), .wrapInner(), .after(), .before( ), v-html for Vue.j  v-bind, 等。

## How
- 在使用这些函数时，需要根据情况对用户输入对内容进行编码、转义或者 白名单
- html属性操作时，做白名单或者正则限制。
- 将cookie设置为httponly，
- 启用Content Security Policy (CSP)策略
