# aqs 互斥锁
## aqs.aquire
```java
    public final void acquire(int arg) {
        if (!tryAcquire(arg) &&
            acquireQueued(addWaiter(Node.EXCLUSIVE), arg))
            selfInterrupt();// 没获取到就中断
    }
```

## aquireQueued 获取下一个排队中的线程 互斥
**互斥锁**
[[waitStatus]]
排队线程阻塞、唤醒和中断处理 acquireQueued(addWaiter(Node.EXCLUSIVE), arg))

刚才分析了 addWaiter 入队过程 返回的是入队后的节点。
acquireQueued 里面又是一个循环， 里边不断尝试 tryAquire  

```java
public final void acquire(int arg) {
    if (!tryAcquire(arg) &&
        acquireQueued(addWaiter(Node.EXCLUSIVE), arg))
        selfInterrupt();
}

final boolean acquireQueued(final Node node, int arg) {
    boolean failed = true;
    try {
        boolean interrupted = false;
        for (;;) {
            final Node p = node.predecessor();
            if (p == head && tryAcquire(arg)) {
                setHead(node);
                p.next = null; // help GC
                failed = false;
                return interrupted;
            }
            // 中断处理 跟据等待状态wait status判断是否需要park
            if (shouldParkAfterFailedAcquire(p, node) &&
                parkAndCheckInterrupt())  
                interrupted = true;
        }
    } finally {
        if (failed)
            cancelAcquire(node);
    }
}
```

### shouldParkAfterFailedAcquire
acquireQueued 如果再次失败，
再调用shouldParkAfterFailedAcquire()将节点的前置节点等待状态置为**需要信号唤醒（SIGNAL）**；

```java
private static boolean shouldParkAfterFailedAcquire(Node pred, Node node) {
    int ws = pred.waitStatus;
    if (ws == Node.SIGNAL)
        /*
         * This node has already set status asking a release
         * to signal it, so it can safely park.
         */
        return true;
    if (ws > 0) {
        /*
         * Predecessor was cancelled. Skip over predecessors and
         * indicate retry.
         */
        do {
            node.prev = pred = pred.prev;
        } while (pred.waitStatus > 0);
        pred.next = node;
    } else {
        /*
         * waitStatus must be 0 or PROPAGATE.  Indicate that we
         * need a signal, but don't park yet.  Caller will need to
         * retry to make sure it cannot acquire before parking.
         */
        compareAndSetWaitStatus(pred, ws, Node.SIGNAL);
    }
    return false;
}
```

### 为什么要将前驱节点设置成SIGNAL（检测到0后）
0 是AQS末尾节点，提醒前驱节点 执行完毕 要继续唤醒AQS队列
Signal
## parkAndCheckInterrupt 响应中断
```java
private final boolean parkAndCheckInterrupt() {
    LockSupport.park(this); // 挂起了 直到unpark
    return Thread.interrupted(); // 后面唤醒了 判断是否已经被中断 
}
```

中断的话设置flag
回头再走一遍 aquireQueued 里的 循环

[[park]]



参考资料
https://zhuanlan.zhihu.com/p/52280869
https://blog.csdn.net/sinat_32873711/article/details/106619953