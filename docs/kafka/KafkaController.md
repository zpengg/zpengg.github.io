# KafkaController
[[Broker]] 上的 [[控制器]]

## 新版优化
把多线程的方案改成了单线程加事件队列的方案
1. 增加了一个 Event Executor Thread，事件执行线程
2. ZooKeeper 全部改为异步操作
3. 优先队列 如 stopReplica

## module
- controllerContext

- [[TopicsStateMachine]]
  - topicChangeListener
  - deleteTopicsListener
- [[ReplicaStateMachine]] 
 - brokerChangeListener

- zookeeperLeaderElector
 - leaderChangeListener

- partitionLeaderElector
- contrllerBrokerRequestBatch 缓存状态机处理结果

- partitionReassignedListener 监听[[分区重分配]]
- PrefferdReplicaElectionListener 监听分区状态变化，触发优先[[副本选举]]
- IsrChangeNotificationListener 监听isr元数据修改请求


