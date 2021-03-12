## 组件
Broker：rabbitMQ服务就是Broker，是一个比较大的概念，描述的是整个应用服务。
交换机（exchange）：用于接收来自生产者的消息，并把消息转发到消息队列中。AMQP中存在四种交换机，Direct exchange、Fanout exchange、Topic exchange、Headers exchange，区别
消息队列（message queuq）：上文说了。
binding：描述消息队列和交换机的绑定关系，使用routing key描述。


broker
- 1 exchange 
- n queue

n * queue --binding--> exchange(VHOST)

exchange --msg.routing key--> queue
