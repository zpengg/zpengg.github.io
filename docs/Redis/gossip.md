# gossip
[[集群]]
cluster gossip协议定义在在ClusterMsg这个结构中

### 三个命令 握手
MEET 向目标节点发送邀请
PONG 带有自己已知节点信息 
PING 带有自己已知节点信息

## 广播
> 如何减少信息量 ？？

### 缩小通信范围
PING 每个节点每秒会执行 10 次 ping，
每次会选择 5 个**最久没有通信**的其它节点。

### 超时立即联系
当然如果发现某个节点**通信延时**达到了 cluster_node_timeout / 2，那么**立即**发送 ping，


### 只带部分节点信息
每次 ping，会带上自己节点的信息，还有就是带上 1/10 其它节点的信息，发送出去，进行交换。至少包含 3 个其它节点的信息，最多包含 总节点数减 2 个其它节点的信息。
