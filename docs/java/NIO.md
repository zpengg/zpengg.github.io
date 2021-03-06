# NIO
java 1.7

## 核心组件
 - channels
 - buffers
 - selectors

## buffer

分配缓冲区（Allocating a Buffer）:
```java
java ByteBuffer buf = ByteBuffer.allocate(28);//以ByteBuffer为例子
```
写入数据到缓冲区（Writing Data to a Buffer）

## channel
### Scatter
从一个Channel读取的信息分散到N个缓冲区中(Buufer).

### Gather
 将N个Buffer里面内容按照顺序发送到一个Channel.


### fileChannel 
FileChannel transferFrom() // other -> filechannel
xxx transferTo(FileChannel ch) // fileChannel -> other

#### map()  mmap
readChannel.map(FileChannel.MapMode.READ_ONLY, 0, 1024 * 1024 * 40);

## selector 多路复用器

### IO 多路复用
所有连接 可以只需要一个 线程 负责
轮询找到就绪的连接
### reactor
Selector selector = Selector.open();

### 在channel中注册selector
SelectionKey key = channel.register(selector, SelectionKey.OP_XXX);

#### SelectionKey 
可以获得 selector 、channel等对象 进行管理
#### 注册事件
SelectionKey.OP_CONNECT
SelectionKey.OP_ACCEPT
SelectionKey.OP_READ
SelectionKey.OP_WRITE
一个channel成功连接到另一个服务器称为”连接就绪“。
一个server socket channel准备号接收新进入的连接称为”接收就绪“。
一个有数据可读的通道可以说是”读就绪“。
一个等待写数据的通道可以说是”写就绪“。
#### 属性
Interest Set兴趣集合
Ready Set就绪集合
Channel通道
Selector选择器
Attach附加对象



