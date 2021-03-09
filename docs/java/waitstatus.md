# waitStatus
[[AQS]] 中线程的状态
## 节点等待状态 wait status
不同功能实现
 - Condition队列 新建节点初始等待状态是CONDITION（-2）；
 - 移入AQS的队列中， 等待状态会更改为0， TAIL
 - 后面加入的节点，会把它**上一个节点**的等待状态设置为SIGNAL（-1）； 
 - 已取消的节点设置为CANCELLED（1），新节点入队时会剔除；
 - 共享锁PROPAGATE（-3）。

## 0： 无下一个线程
## Signal: 需要唤醒下一个等待的线程

## 记录在前一个节点