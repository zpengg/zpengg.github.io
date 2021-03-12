[[消息投递模式]]


## 常见 MQ
 - ActiveMQ 是基于 [[JMS]] 实现的Provider（可以理解为队列）
 - RabbitMq 不支持动态扩展, 一个节点包含所有原数据
 - RocketMq 分布式 阿里云 文档缺乏 
 - KafKa 分布式 成熟日志领域
 - plursa

![对比图](https://img-blog.csdn.net/20170629183901936?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvc29uZ2ZlaWh1MDgxMDIzMg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
 
## 常见 协议
[[MQTT]]
OpenWire
Stomp
[[AMQP]]

## 特性
kafka 砍掉的复杂的特性，如
 - 事务
 - 分发策略
 - 多种消息模型

### RabbitMq 解决重复: 唯一id
 在消息生产时，MQ 内部针对每条生产者发送的消息生成一个 inner-msg-id，作为去重的依据（消息投递失败并重传），避免重复的消息进入队列；
 在消息消费时，要求消息体中必须要有一个 bizId（对于同一业务全局唯一，如支付 ID、订单 ID、帖子 ID 等）作为去重的依据，避免同一条消息被重复消费。


由于 TCP 连接的创建和销毁开销较大，且并发数受系统资源限制，会造成性能瓶颈。RabbitMQ 使用信道的方式来传输数据。信道是建立在真实的 TCP 连接内的虚拟连接，且每条 TCP 连接上的信道数量没有限制。