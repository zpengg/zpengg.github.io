# KafkaHealthcheck
监听 [[zookeeper]] /brokers/ids 节点
## EphemeralPath 非永久路径
brokerServer zk断开 zk删除节点，节点消失

zk客户端监听，zkstate，断线重连 重新注册
