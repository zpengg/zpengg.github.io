# tree sharking

## 作用

> 参考例子 https://zhuanlan.zhihu.com/p/59301703

正是由于 ES6 模块的静态特点， 才能在打包的过程的去分析标记依赖了哪些 function, 然后把**没用到的 fuction 给剔除掉**，类似

```js
// util.js

function ajax() {
    console.log(13);
}
function test() {
    console.log(56);
}
export { ajax, test };

// index.js  import {ajax} from './util'
ajax();
```

经过 tree sharking 后 如下 //dist/index.esm.js

```js
function ajax() {
    console.log(13);
}

ajax();
```
