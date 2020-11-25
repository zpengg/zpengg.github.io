## 数据类型
数据类型分为**原始类型**和**对象类型**，也可分为可变和不可变。
### 原始类型 
均为不可变。
三种常用的类型
Number
String
Boolean

特殊类型
null Null空类型的唯一成员
undefined  无法classof。

### 对象类型
#### 分类
Array数组 有序集合
Function函数 具有与他关联的可执行代码的对象

其他
Date
RegExp
Error
####  原型
>每一个对象都有与之相关的原型（除了null），类和可扩展性

先看一段代码

```js
<body>
<script>
    function a() {
        /* 我就是构造函数 */
    }
 
    var b = new a(); // 通过 new 创建
 	var e = {}; //通过对象直接量创建
</script>
 
</body>
```

`a` 是一个函数
`a.prototype` 称为 `a`函数的原型对象
![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/160628888131b464.png)
`a.prototype.constructor` 指向 `a`

函数 用来 new 的话 我们称为 构造函数
构造函数定义了一类对象JS

通过`new a()` 的到的对象`b`
`b.__proto__` 同样的 也是指向 `a.prototype` 这个对象

通过对象直接量创建的 就有点不同，他们有同一个原型对象 `Object.prototype`
![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/16062914635bf651.png)