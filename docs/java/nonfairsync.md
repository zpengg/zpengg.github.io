# NonfairSync
## 加锁
### 非公平同步器 （CAS 插队）
```Java
 static final class NonfairSync extends Sync {
        private static final long serialVersionUID = 7316153563782823691L;

        /**
         * Performs lock.  Try immediate barge, backing up to normal
         * acquire on failure.
         */
        final void lock() {
            if (compareAndSetState(0, 1))
                setExclusiveOwnerThread(Thread.currentThread()); //直接CAS 成功 则不用处理排队逻辑了
            else
                acquire(1); //公平排队
        }

        protected final boolean tryAcquire(int acquires) {
            return nonfairTryAcquire(acquires);
        }
    }
```

CASState(0,1) 成功 则 直接指定当前线程为Owner

否则调 acquire(1) 

## trylock 方法: 无占用才lock
```Java
public final void acquire(int arg) {
    if (!tryAcquire(arg) &&
        acquireQueued(addWaiter(Node.EXCLUSIVE), arg))
        selfInterrupt(); 
}
```
tryAcquire 由子类实现 最终调用的是
```java
        /**
         * Performs non-fair tryLock.  tryAcquire is implemented in
         * subclasses, but both need nonfair try for trylock method.
         */
        final boolean nonfairTryAcquire(int acquires) {
            final Thread current = Thread.currentThread();
            int c = getState();
            if (c == 0) { 
                if (compareAndSetState(0, acquires)) {
                    setExclusiveOwnerThread(current);
                    return true;
                }
            }
            else if (current == getExclusiveOwnerThread()) {
                int nextc = c + acquires;
                if (nextc < 0) // overflow
                    throw new Error("Maximum lock count exceeded");
                setState(nextc);
                return true;
            }
            return false;
        }
```

3种情况
 - 首入 CASState(0,1) 指定拥有者 setExclusiveOwnerThread
 - 重入 state + 1
 - 竞争失败 return false 

tryAquire 的返回值的作用要 看 AQS 是如何处理的
tryAcquire return true 的话就不必继续进行 aquireQueued 了
return false 需要**排队**

## aquire 获取锁
[[AQS]]
