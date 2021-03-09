# waitStatus
[[AQS]] 中线程的状态
## 节点等待状态 wait status
不同功能实现
 - 新建节点初始等待状态是CONDITION（-2）；
 - 移入AQS的队列中， 等待状态会更改为0
 - AQS阻塞，会把它上一个节点的等待状态设置为SIGNAL（-1）；
 - 已取消的节点设置为CANCELLED（1）；
 - 共享锁PROPAGATE（-3）。

