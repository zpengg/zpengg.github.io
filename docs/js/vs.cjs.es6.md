## 模块引入方式
ES6 是静态引入
```js
if (pastTheFold === true) {
    let parallax = require("./parallax"); // 在Common.js 规范里 是没问题,大家经常写
}
if (pastTheFold === true) {
    import parallax from "./parallax"; // 这里运行起来是会报错的,不支持这种引入，只能放在 头部
}
```

