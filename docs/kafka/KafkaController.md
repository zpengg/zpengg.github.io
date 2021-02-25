# KafkaController
[[Broker]] 上的 [[控制器]]

## module
- controllerContext

- [[TopicsStateMachine]] [[主题]] 
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


