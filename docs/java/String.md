# String
## 常量
final class 不可继承
final char[] 不可修改

```java
public final class String
    implements java.io.Serializable, Comparable<String>, CharSequence {
    /** The value is used for character storage. */
    private final char value[];
```
### 意义
threadSafe
配合容器 如set
hashcode 不变 

## String Pool
String x = "a";
"a" 放在 [[方法区]] [[运行时常量池]]中；
### 编译优化

符号引用常量：String x = "a";
符号引用运算： a+b 分别放入string a ， b
字面量运算："a"+"b" 编译成 "ab"
符号引用 new： 不放入常量池，放入堆中
intern(): 常量池没有，则放回常量池; 常量池已有则返回常量引用

### 历史
java7 之前 运行时常量池中，它属于永久代
7，字符串常量池被移到 Native memeory,
8，堆中

## + 法创建对象
+/split 会创建 对象
大量时会引起GC

## StringBuff & StringBuilder
StringBuilder 不是线程安全的
StringBuffer 是线程安全的，内部使用 synchronized 进行同步
都可以用来拼接新字符串
