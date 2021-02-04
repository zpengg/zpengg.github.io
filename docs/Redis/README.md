# Redis
## 数据类型
[[数据类型]]
## 对象系统
* type, *ptr [[对象系统]][[类型检查]]
* encodiong [[编码方式]]
* refCount [[引用计数]]
* [[lru]]

## 服务器
* [[redisServer]]
* [[redisServer]]


* 实现细节
    * [redis 数据淘汰原理](/Redis/expire.md)
    * [redis TTL 实现原理]()
    * [redis 过期数据删除策略]()
    * [redis server 事件模型]()
    * [redis 命令执行过程]()
* 集群 
    * [redis 集群搭建常用配置]()
    * [redis 客户端]()
    * [redis 三种集群模式-主从、哨兵、集群]()
    * [redis 主从同步-slave 端]()
    * [redis 主从同步-master 端]()
    * [redis 主从超时检测实现机制]()
    * [redis 哨兵模式]()
    * [redis cluster 集群建立]()
    * [redis cluster 集群选主]()
* 持久化
    * [redis aof 持久化]()
    * [redis rdb 持久化]()
    * [redis 数据恢复过程]()