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
"a" 放在 [[方法区]] 常量池中；
### 编译优化
"a"+"b" 编译成 "ab"

### 历史
java7 之前 运行时常量池中，它属于永久代
7之后，字符串常量池被移到 Native Method

## StringBuff & StringBuilder
StringBuilder 不是线程安全的
StringBuffer 是线程安全的，内部使用 synchronized 进行同步

都可以用来拼接新字符串
