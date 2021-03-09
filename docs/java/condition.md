# Condition
## Condition 接口
await()
signal()

## 使用
Condition接口也提供了类似Object的监视器方法，与Lock配合可以实现等待/通知模式，但
```java
// 声明一个重入锁
ReentrantLock lock = new ReentrantLock();
// 声明一个条件锁
Condition condition = lock.newCondition();
```
```java
// 使用逻辑 伪代码
 lock()
 condition.await();//park 等待
 unlock()
```
## 实现：AQS.ConditionObject 
```java
public class ConditionObject implements Condition, java.io.Serializable {
    /** First node of condition queue. */
    private transient Node firstWaiter;
    /** Last node of condition queue. */
    private transient Node lastWaiter;
}

```

## Condition 内部也有链表队列，持有等待条件的节点
Condition的队列头节点是真实节点。

### await() 阻塞
（1）新建一个节点加入到条件队列中去；
（2）完全释放当前线程占有的锁；
（3）阻塞当前线程，并等待条件的出现；
（4）条件已出现，唤醒（此时节点已经移到AQS的队列中），尝试获取锁；

### signal() 发送信号 可以唤醒。并放回AQS
signal()方法的大致流程为：
（1）从条件队列的头节点开始寻找一个非取消状态的节点；or 唤醒自己
（2）把它从条件队列移到AQS队列；
（3）且只移动一个节点
####  唤醒时间点
> lock.unlock()方法，此时才会真正唤醒一个节点
####  唤醒完继续竞争
还在AQS中