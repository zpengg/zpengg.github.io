## 组件
broker 传递celery任务**消息的中间件**。
最新的celery5中支持四种broker：RabbitMQ、Redis、Amazon SQS、Zookeeper（实验性质）。一般最常用的就是redis和rabbitMQ。

backend 是用来**存储任务结果和中间状态**的实体，backend的选择就很多了，redis/mongoDB/elsticsearch/rabbitMQ，甚至还可以自己声明。如果生产者或者其他服务需要关心异步任务的结果则一定要配置backend。

worker，顾名思义，其作用就是执行任务，需要注意的是启动worker时一般需要设置其监听的队列和最大并发数。