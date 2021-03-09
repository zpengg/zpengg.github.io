# aqs 出队
## 出队 唤醒继任
```java
public final boolean release(int arg) {
    if (tryRelease(arg)) {
        Node h = head;
        if (h != null && h.waitStatus != 0) // WS==0 为最后的节点，
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


