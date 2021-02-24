# kafka
## 概念
- [[客户端]]
- [[生产者]]
- [[消费者]]

- [[服务端]]
- [[broker]], 其中一个是 [[控制器]] 主导管理集群
- [[分区]]
- [[主题]]
- [[日志管理]]

- [[监控]]
- [[应用]]

## why FAST ！
### 系统设计
多[[分区]] 水平扩展
Reactor 网络模型 IO多路复用
## broker IO特性
### 网络数据持久化到磁盘 (Producer 到 Broker)
磁盘 顺序追加 IO 快 
MMAP文件 利用[[pagecache]] 优化读写性能, 使用操作系统自身内存 而不是JVM空间内存然后 flush 落盘

### 磁盘文件通过网络发送（Broker 到 Consumer）
sendfile 内核空间buff 通过DMA传输到网卡nic buffer，用户空间[[零拷贝]] 

### 消息打包 减量
batch send
批量 数据压缩
