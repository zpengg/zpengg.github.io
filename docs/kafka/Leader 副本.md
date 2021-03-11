# Leader 副本
[[leader副本选举策略]]
[[多副本]]

## leader 副本
leader 副本负责读写
leader 副本负责 维护和跟踪 ISR 集合中 follower 副本的滞后状态

## 优先副本 preffer replica
AR 第一个Replica 
优先副本 启动时会设置成 leader