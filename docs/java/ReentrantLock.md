# ReentrantLock
## 同步器
前面提到 ReentrantLock 也是使用AQS 去实现的。
[[AQS]]

### 公平、非公平
非公平锁 [[NonFairSync]]
公平锁 [[FairSync]]

## 条件锁
[[Condition]]

## 互斥锁，加锁过程
[[aqs 互斥锁]]
[[park]]
获取成功则更新为队列头节点
失败则看是否需要挂起 并等待唤醒
唤醒后看是否线程中断，更新标志位


## 释放锁，
[[aqs 出队]]
lock 对应 unlock
acquire 对应的是 release 方法


