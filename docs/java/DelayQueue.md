# DelayQueue

[[Collection]]
## 基本元素
[[ReentrantLock]] + [[PriorityQueue]]
[[Condition]]
## Delayed 接口
```java
public interface Delayed extends Comparable<Delayed>{
    long getDelay (TimeUnit unit)
}
```
## Delayed 实现
``` java
public long getDelay(TimeUnit unit){
    // 判断是否过期
    // unit.convet(diffTime, TimeUnit.MILLSECONDS);
}
```
## available条件锁队列
 signal()只是把等待的线程放到AQS的队列里面，并不是真正的唤醒
## 内部结构
可重入锁
用于根据delay时间排序的优先级队列
用于优化阻塞通知的线程元素leader
用于实现阻塞和通知的Condition对象

## delayed和PriorityQueue
在理解delayQueue原理之前我们需要先了解两个东西,delayed和PriorityQueue.

 - delayed是一个具有过期时间的元素
 - PriorityQueue是一个根据队列里元素某些属性排列先后的顺序队列
　　
delayQueue其实就是在每次往优先级队列中添加元素，然后以元素的delay/过期值作为排序的因素，以此来达到先过期的元素会拍在队首,每次从队列里取出来都是最先要过期的元素

## offer方法: 加锁入队
执行加锁操作
把元素添加到优先级队列中
### 队首要唤醒 available上线程
查看元素是否为队首
如果是队首的话，设置leader为空，唤醒所有等待在available上的队列

释放锁
## poll： 到期才能出队


