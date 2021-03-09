# ReentrantLock
## 同步器
前面提到 ReentrantLock 也是使用AQS 去实现的。
[[AQS]]

### 公平、非公平
[[NonfairSync]]

## 条件锁
[[Condition]]

获取成功则更新为队列头节点
失败则看是否需要挂起 并等待唤醒
唤醒后看是否线程中断，更新标志位

## shouldParkAfterFailedAcquire
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
### 为什么检测到0后，要将前驱节点设置成SIGNAL
Signal
parkAndCheckInterrupt
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

## 释放锁
lock 对应 unlock
acquire 对应的是 release 方法
```java
public final boolean release(int arg) {
    if (tryRelease(arg)) {
        Node h = head;
        if (h != null && h.waitStatus != 0)
            unparkSuccessor(h);// 唤醒继任，但我们加锁时页没有处理过 可以暂时忽略
        return true;
    }
    return false;
}
```

对应的，也要子类实现 tryRelease
```java
protected final boolean tryRelease(int releases) {
    int c = getState() - releases;
    if (Thread.currentThread() != getExclusiveOwnerThread())
        throw new IllegalMonitorStateException();
    boolean free = false;
    if (c == 0) {
        free = true;
        setExclusiveOwnerThread(null);
    }
    setState(c);
    return free;
}
```

waitstatus 默认0， 


