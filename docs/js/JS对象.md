## 数据类型
数据类型分为**原始类型**和**对象类型**，也可分为可变和不可变。
### 原始类型 
均为不可变。
三种常用的类型
number
string
bool

特殊类型
null 空类型的唯一成员
undefined 未定义类型的唯一成员

### 对象类型
#### 分类
Array数组 有序集合
Function函数 具有与他关联的可执行代码的对象

其他
Date
RegExp
Error
#### 原型
每一个对象都有与之相关的

先看一段代码

```js
<body>
<script>
    function a() {
        /* 我就是构造函数 */
    }
 
    var b = new a();
 
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

