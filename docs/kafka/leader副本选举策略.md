# Leader副本选举策略
## type
NoOpLeaderSelector 默认
ReassignedPartiionLeaderSelector  AR重新分配时的策略
PreferredReplicaPartitionLeaderSelector 集群[[再均衡]]、用户手动均衡策略
OfflinePartitionLeaderSelector 分区状态变为上线时使用的策略
ControlledShutdownLeaderSelector 处理其他下线

## Reassigned
配置指定AR ISR 交集第一个

## offlen
优先ISR 第一个

退化： 按配置 可能 选AR

## Prefer
原始AR里的第一个

## offline
先下线，更新isr 选第一个