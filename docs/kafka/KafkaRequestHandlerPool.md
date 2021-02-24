# KafkaRequestHandlerPool
[[broker]]
默认 num.io.threads 8
将 RequestChannel ， kafkaAPI 传给 RequstHandler
## 流程
调用 receiveRequest 直到从 RequestChannel 阻塞队列 获取请求
判断请求类型，选择合适API逻辑
根据Request.processor =i 
放回RequestChannel 中的 responseQueue,一一对应processor， 放回合适的 Processor 返回队列