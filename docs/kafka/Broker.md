# Broker
producer 将消息推送到 broker，consumer 从broker 拉取消息。

## 模块 
 - 1.集群
  - [[KafkaHealthCheck]] 集群状态监测
  - [[KafkaController]] 监控zookeeper 的 集群元数据变更

 - 2.通信 （内部的 生产者消费者模型）
  - [[SocketServer]] 通信模块，监听Socket请求 缓存在RequestChannel
  - [[KafkaRequestHandlerPool]] IO线程池，多线程处理请求

 - 3.业务逻辑 kafkaAPI 11条通信协议
    - [[OffsetManager]] 偏移量管理: 写日志位置 行级别
    - [[LogManager]] 日志管理: log文件，删除数据，checkpoint 合并等 段（文件）级别
    - [[ReplicaManager]] 副本管理:ISR，同步 副本级别
    - [[TopicsConfigManager]] 在线修改主题

 - 4.任务调度
    - kafkaScheduler 后台任务调度

## why consumer PULL
当 broker 推送的速率远大于 consumer 消费的速率时，consumer 恐怕就要崩溃了 

## producer.type
Producer叫同步(sync)；写入mmap之后立即返回Producer不调用flush叫异步(async)。