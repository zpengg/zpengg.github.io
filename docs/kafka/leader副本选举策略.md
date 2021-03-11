# Leader 副本选举策略
## type
NoOpLeaderSelector 
ReassignedPartiionLeaderSelector  AR重新分配时的策略
PreferredReplicaPartitionLeaderSelector 优先副本选举[[分区平衡]]
OfflinePartitionLeaderSelector 分区状态变为上线时使用的策略
ControlledShutdownLeaderSelector 处理其他下线

## ReassignPartitionLeaderElectionStrategy
时间：重新分配分区
1. **按配置指定AR**，与 ISR 交集第一个

## PreferredReplicaPartitionLeaderElectionStrategy
时间：优先副本选举 [[分区平衡]]， 选出新的Leader，新的ISR
原始AR里的第一个

## OfflinePartitionLeaderElectionStrategy.
时间： 创建分区， 分区上线
1. AR集合第一个存活的副本，并且这个副本在ISR集合

## ControlledShutdownPartitionLeaderElectionStrategy
时间：当controller收到shutdown命令后，触发新的分区主副本选举 (优雅关闭)
1. AR列表第一个存活的副本，并且这个副本在ISR列表， Offline 的一样
2. 还要确保不处于正在被关闭的节点上。