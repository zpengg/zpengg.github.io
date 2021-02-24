# SocketServer

## Acceptor
只有一个实例 负责创建连接
Acceptor 线程使用 Java NIO 的 Selector + SocketChannel 的方式循环地轮询准备就绪的 I/O 事件。

 - 开启 socket 服务
 - 注册 Accept 事件
 - 监听 channel 分发 （Round-robin） 转交给 Processor 多线程处理

```scala
private[kafka] class Acceptor(val endPoint: EndPoint,
                              val sendBufferSize: Int,
                              val recvBufferSize: Int,
                              nodeId: Int,
                              connectionQuotas: ConnectionQuotas,
                              metricPrefix: String,
                              time: Time,
                              logPrefix: String = "") extends AbstractServerThread(connectionQuotas) with KafkaMetricsGroup {

  this.logIdent = logPrefix
  // 创建Selector
  private val nioSelector = NSelector.open()
  // 在selector 中 注册 channel
  val serverChannel = openServerSocket(endPoint.host, endPoint.port)
  private val processors = new ArrayBuffer[Processor]()
  private val processorsStarted = new AtomicBoolean
  private val blockedPercentMeter = newMeter(s"${metricPrefix}AcceptorBlockedPercent",
    "blocked time", TimeUnit.NANOSECONDS, Map(ListenerMetricTag -> endPoint.listenerName.value))
  private var currentProcessorIndex = 0
  private[network] val throttledSockets = new mutable.PriorityQueue[DelayedCloseSocket]()

  // ...

  // reactor 分发逻辑
  def run(): Unit = {
    // 注册 SelectionKey.OP_ACCEPT
    serverChannel.register(nioSelector, SelectionKey.OP_ACCEPT)
    startupComplete()
    try {
      // 监听 Accept
      while (isRunning) {
        try {
          acceptNewConnections()
          closeThrottledConnections()
        }
        catch {
          // We catch all the throwables to prevent the acceptor thread from exiting on exceptions due
          // to a select operation on a specific channel or a bad request. We don't want
          // the broker to stop responding to requests from other clients in these scenarios.
          case e: ControlThrowable => throw e
          case e: Throwable => error("Error occurred", e)
        }
      }
    } finally {
      debug("Closing server socket, selector, and any throttled sockets.")
      CoreUtils.swallow(serverChannel.close(), this, Level.ERROR)
      CoreUtils.swallow(nioSelector.close(), this, Level.ERROR)
      throttledSockets.foreach(throttledSocket => closeSocket(throttledSocket.socket))
      throttledSockets.clear()
      shutdownComplete()
    }
  }


  /**
   * Listen for new connections and assign accepted connections to processors using round-robin.
   */
  private def acceptNewConnections(): Unit = {
    val ready = nioSelector.select(500)
    if (ready > 0) {
      //
      val keys = nioSelector.selectedKeys()
      val iter = keys.iterator()
      // 轮询
      while (iter.hasNext && isRunning) {
        try {
          val key = iter.next
          iter.remove()

          if (key.isAcceptable) {
            accept(key).foreach { socketChannel =>
              // Assign the channel to the next processor (using round-robin) to which the
              // channel can be added without blocking. If newConnections queue is full on
              // all processors, block until the last one is able to accept a connection.
              var retriesLeft = synchronized(processors.length)
              var processor: Processor = null
              do {
                retriesLeft -= 1
                processor = synchronized {
                  // adjust the index (if necessary) and retrieve the processor atomically for
                  // correct behaviour in case the number of processors is reduced dynamically
                  currentProcessorIndex = currentProcessorIndex % processors.length
                  processors(currentProcessorIndex)
                }
                currentProcessorIndex += 1
              } while (!assignNewConnection(socketChannel, processor, retriesLeft == 0))
            }
          } else
            throw new IllegalStateException("Unrecognized key state for acceptor thread.")
        } catch {
          case e: Throwable => error("Error while accepting connection", e)
        }
      }
    }
  }
}
```

## Processor
SocketChannel 分发到 Processor 线程上
 - 注册OP_READ 事件以便接受客户端请求
 - REQUESTCHANNEL 获取客户端请求的响应 产生OP_WRITE 事件
 - 监听 selector 上的事件。
  - 读事件 request 来了 转交RequestChannel
  - 写事件 request处理完毕，从requestChannel 取出返回
  - 关闭事件 释放资源 


proccessor 封装成对象 放入 requestChannel 
IO线程池 KafkaRequsetHandlerPool 取出 KafkaRequestHandler 处理
返回放回每个processor的在阻塞队列 responseQueue 

```scala
    private[kafka] class Processor(val id: Int,
                                   time: Time,
                                   maxRequestSize: Int,
                                   requestChannel: RequestChannel,
                                   connectionQuotas: ConnectionQuotas,
                                   connectionsMaxIdleMs: Long,
                                   failedAuthenticationDelayMs: Int,
                                   listenerName: ListenerName,
                                   securityProtocol: SecurityProtocol,
                                   config: KafkaConfig,
                                   metrics: Metrics,
                                   credentialProvider: CredentialProvider,
                                   memoryPool: MemoryPool,
                                   logContext: LogContext,
                                   connectionQueueSize: Int = ConnectionQueueSize) extends AbstractServerThread(connectionQuotas) with KafkaMetricsGroup {
      // 新分配给Processor的连接都会先放在这里
      private val newConnections = new ArrayBlockingQueue[SocketChannel](connectionQueueSize)
      // 严格来说，这是一个临时 Response 队列。当 Processor 线程将 Response 返还给 Request 发送方之后，还要将 Response 放入这个临时队列
      // 为什么需要这个临时队列呢？这是因为，有些 Response 回调逻辑要在 Response 被发送回发送方之后，才能执行，
      // 因此需要暂存在一个临时队列里面。这就是 inflightResponses 存在的意义
      private val inflightResponses = mutable.Map[String, RequestChannel.Response]()
      // 每个 Processor 线程都会维护自己的 Response 队列
      private val responseQueue = new LinkedBlockingDeque[RequestChannel.Response]()
```
### inflightResponses


### LRU

## RequestChannel
RequestChannel 也属于 SocketServer 一部分。

Request 1 个， Response 默认 3 个阻塞队列

Processor 线程 与 responseQueue 一一对应