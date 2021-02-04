# CORS
CORS 全称是 Cross-Origin Resource Sharing，跨域资源分享。
是一种网页向图像服务器请求使用图像许可的方式。

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS/cors_principle.png)

## 同源策略
“同源”的定义：
 - 域名
 - 协议
 - tcp端口号
只要以上三个值是相同的，我们就认为这两个资源是同源的。

## 安全性问题
出于安全性，浏览器限制脚本内发起的跨源HTTP请求
### 可能后果
恶意网站 请求 敏感网站 （使用缓存的身份数据）

## CORS机制放宽安全性
### 原因
同源策略对于大型应用有太多的限制，比如有多个子域名的情况

### 需要配置
这种机制通过在http头部添加字段，通常情况下，web应用A告诉浏览器，自己有权限访问应用B。这就可以用相同的描述来定义“同源”和“跨源”操作。
通过以下配置允许跨域访问的域名
`Access-Control-Allow-Origin: https://example.com`

通过以下配置，决定是否带上当前origin用户的cookie
`Access-Control-Allow-Credentials: true`

### 通配符
`Access-Control-Allow-Origin: *` 会使 `Access-Control-Allow-Credentials: true` 失效
不共用

### 被动产生 需标记 Vary: Origin
也可以想”Access-Control-Allow-Origin“是被动态产生的话，就要用”Vary: Origin“去指定。根据“Origin”这个头部字段的值来生成“AccessControl-Allow-Origin”的值

## 配置错误风险
### 动态根据orgin 生成 Acao 但不标记 Vary: Origin

发现许多网站会根据请求头中的Origin值然后设置Access-control-allow-origin，且同时设置了Access-Control-Allow-Credentials为true，导致可以被黑客利用

Access-control-allow-origin:null 是可以携带cookie的

js 同时改location orgin 会使服务器根据 Access-Control-Allow-Origin: https://attacker.domain

## 绕过基于IP身份验证 
受害者机器有权限，代理访问敏感信息

## 缓存投毒
可以把xss的exp放在 onload 里 等受害者触发
```js
var req = new XMLHttpRequest();
req.onload = reqListener;
req.open('get','http://www.target.local/login',true);
req.setRequestHeader('X-User', '<svg/onload=alert(可执行代码)>');
req.send();
function reqListener() {
location='http://www.target.local/login';
}
```
可以利用上面展示的例子，可以让受害者浏览器中的缓存中存储返回数据报文


## 预检 optioon
发送这些复杂请求之前，浏览器会发送一个”探测“请求

cors预检的目的是为了验证CORS协议是否被理解，预检的OPTION请求包含下面三个字段

“Access-Control-Request-Method”
“Access-Control-Request-Headers”
“Origin”
这些字段会被浏览器自动的发给服务器端


## 防守

1.如果不必要就不要开启CORS
2.定义白名单检查orgin, 避免通配 避免正则，
3.仅仅允许安全的协议
4.配置“VARY”头部
5.如果可能的话避免使用“CREDENTIALS”
6.限制使用的方法“Access-Control-Allow-Methods”头部
7.限制缓存的时间通过“Access-Control-Allow-Methods”和“Access-Control-Allow-Headers”头部，限制浏览器缓存信息的时间。可以通过使用“Access-Control-Max-Age”标题来完成，

8.仅配置所需要的头




## 对比

### jsonp
## 作用对象
## 相关
针对图像问题 [[WebGL 跨域图像]]

## 参考
[cors安全完全指南](https://xz.aliyun.com/t/2745)
