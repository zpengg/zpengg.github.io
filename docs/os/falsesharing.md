# FalseSharing
## CPU 多核竞争 位于缓存行数据
多个数据位于CPU缓存行，会出现伪共享, 

多核轮番夺取缓存行,轮番夺取拥有权不但带来大量的 RFO 消息，
而且如果某个线程需要读此行数据时，L1 和 L2 缓存上都是失效数据，只有 L3 缓存上是同步好的数据


## 例子
```java
  public final static class VolatileLong {
        public volatile long value = 0L;
        public long p1, p2, p3, p4, p5, p6;     //屏蔽此行 会出现
    }
```

## 如何避免
1. 让不同线程操作的对象处于不同的缓存行即可，冗余代码填充，但要注意被编译器优化掉。
2.  编译器 填充缓存行， 加padding
3. java8 @sun.misc.Contended 注解