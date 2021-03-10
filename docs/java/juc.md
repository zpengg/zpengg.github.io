# JUC
# 基本概念
- [[Unsafe]] 不安全的底层操作
- [[Stirp64]]
- [[原子类]]
- [[同步]]

## 基于互斥锁
- [[ReentrantLock]]
    - [[CopyOnWriteArrayList]]

### 基于条件锁（有条件阻塞）
- [[DelayQueue]]
- [[CyclicBarrier]] 环形栅栏，轮流运行

## 基于共享锁 （唤醒多个）
- [[ReentrantReadWriteLock]] 读写锁
- [[CountDownLatch]]  倒计数器
- [[Semaphore]] 限流
- [[Phaser]] 多阶段并发

## 分段锁
- [[ConcurrentHashMap]]