# park
[[线程阻塞]]的一种方法
## 实现
park阻塞 unpark唤醒 的细节要到 hotspot 源码查看
```java
public static void park(Object blocker) {
    Thread t = Thread.currentThread();
    setBlocker(t, blocker);
    UNSAFE.park(false, 0L); // 阻塞
    setBlocker(t, null); // 唤醒后清空
}

public static void unpark(Thread thread) {
    if (thread != null)
        UNSAFE.unpark(thread);
}
```


## 可以响应 中断