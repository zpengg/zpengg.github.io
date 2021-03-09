# LongAdder 分段加法器

## Cell
@sun.misc.Contended static final class Cell 
说明里面的值消除伪共享[[falsesharing]]

## LongAdder
```java
// 这三个属性都在Striped64中
// cells数组，存储各个段的值
transient volatile Cell[] cells;
// 最初无竞争时使用的，也算一个特殊的段
transient volatile long base;
// 标记当前是否有线程在创建或扩容cells，或者在创建Cell
// 通过CAS更新该值，相当于是一个锁
transient volatile int cellsBusy;
```

## dynamic striping 思想
[[dynamicStriping]]
## probe 线程的hash值
[[probe]] 值决定线程落桶位置

## 低并发 直接使用base，相当于为 AtomicLong
## 高并发 cell[] 再扩容 加锁
当多个线程竞争同一个Cell比较激烈时，可能要扩容

## 取值时求和
```java
    public long longValue() {
        return sum();
    }
```