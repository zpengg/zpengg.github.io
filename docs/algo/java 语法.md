# Java 语法
## 随机数
```java
Random r = new Random();
r.nextInt(n);
// return [0,n)
```
## Integer 相等
-128到127有缓存
保守点用equals

## 千分位
int hi = 1_000_000_000;
## 指数 
Math.pow(a,b); // a^b
int i = 1e9; // 10^9

## 长度
字符串 length()
数组 length
容器 size（）

## 排序
Arrays.sort(pair, (o1, o2) ->(o1 - o2));

## 容器
### hashMap 记录计数
用 Integer.equals 或转换类型get(x).intValue

### 队列
offer: return boolean
add:  return boolean but throws unchecked exception when FULL

// 移除并获取 [计票]
poll: return null when empty
remove: throws NoSuchElementException when empty

// 仅获取 不移除 [看一眼]
peek: Retrieves, but does not remove 
element：throws NoSuchElementException when empty

### 双端队列 
除了queue还有对应的双端接口xxlast,xxfirst
element 对应 getFirst,getLast