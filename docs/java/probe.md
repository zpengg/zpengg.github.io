# probe: 线性探针hash
简单的说，一个线程的probe探针值，是一个非零hash值，它不会和其他线程重复（一定情况下）。

```java
// 线程中的threadLocalRandomProbe字段
// 它是通过随机数生成的一个值，对于一个确定的线程这个值是固定的
// 除非刻意修改它
// 存储线程的probe值
    static final int advanceProbe(int probe) {
        probe ^= probe << 13;   // xorshift
        probe ^= probe >>> 17;
        probe ^= probe << 5;
        UNSAFE.putInt(Thread.currentThread(), PROBE, probe);
        return probe;
    }
```
