# kafka
## 概念
 - [[客户端]]
    - [[生产者]]
    - [[消费者]] [[消费者协调器]]

- [[服务端]]
    - [[Broker]], 其中一个是Leader [[控制器]] 主导管理集群
    - [[分区]]
    - [[主题]]
    - [[日志管理]]

- [[监控]]

## why FAST ！

### 系统设计
多[[分区]] 水平扩展
Reactor 网络模型 IO多路复用

### broker IO特性
#### 网络数据持久化到磁盘 (Producer 到 Broker)
磁盘 顺序追加 IO 快 
MMAP文件 利用[[pagecache]] 优化读写性能, 使用操作系统自身内存 而不是JVM空间内存然后 flush 落盘

#### 磁盘文件通过网络发送（Broker 到 Consumer）
sendfile 内核空间buff 通过DMA传输到网卡nic buffer，用户空间[[零拷贝]] 

#### 消息打包压缩，减通信量
batch send
批量 数据压缩

## 参考资料
 - [Kafka 的这些原理你知道吗](https://segmentfault.com/a/1190000021370626?utm_source=tag-newest)
 - 《Kafka源码解析与实战》
 - 《<深入理解Kafka：核心设计与实践原理》