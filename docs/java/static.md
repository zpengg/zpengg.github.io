# static
## 分类
## staiic field
no this/ super
## static method
not abstract
只能访问静态成员
## static {block}
类初始化时运行一次
## static innerClass
静态内部类 
使用上也是要正常实例化
不需要依赖 外部类实例

## import static xxx.ClassName.*
import static java.lang.Integer.*;
...
System.out.prinln(MAX_VALUE);


## 初始化时机
静态初始化 优先于 普通初始化

## 静态方法可以继承　不能覆盖和多态
编译时确定了，不能运行时绑定