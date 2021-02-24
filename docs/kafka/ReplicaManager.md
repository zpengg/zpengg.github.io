# ReplicaManager
ReplicaManager 负责副本数据的同步 和leader切换 等管理操作
 - ReplicaFetcherThread 获取
 - becomeLeaderOrFollower  assign 分配给broker
 - stopReplicas 删除副本，节点离线
 - maybeshrinkISR 剔除出ISR

## 副本状态
```scala
class Replica(val brokerId: Int, val topicPartition: TopicPartition) extends Logging {

}

```
Topic [[主题]]元数据 可以看到[[多副本]]的状态

例子：
 - 分区: 0
 - Leader 1
 - replicas 1,4
 - Isr 1,4

## ReplicaFetcherThread
单个线程负责 向某一个 borker 上，部分 topicPartiion 的replica 的同步
processPartionData
 - 拉取消息写入log
 - 更新follower 的 HW
 - 計算配額

## becomeLeaderOrFollower
partition.makeLeader  AR信息， logoffset元数据
partition.makeFollower

清理一些旧fetch请求
### Leader

### follower
截断至 HW 保持一致性
增加新的fetch请求

## maybeShrinkISR
在 isr-expiration 线程
通过配置
 - replica.lag.time.max.msg
 - replica.lag.max.messages
更新ISR
更新HW