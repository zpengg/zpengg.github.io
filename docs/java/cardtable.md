# cardtable

使用了卡标记（Card Marking）技术来解决老年代到新生代的引用问题。具体是，使用卡表（Card Table）和写屏障（Write Barrier）来进行标记并加快对GC Roots的扫描。
## 堆 --2^n--> cardPage 512B
堆空间划分为一系列2次幂大小的卡页（Card Page）。
HotSpot JVM的卡页（Card Page）大小为512字节数组

## cardTable -->  cardPage-flag
卡表（Card Table），用于标记卡页的状态，每个卡表项 1 byte 对应一个卡页


## Dirty Card
CARD_TABLE [this address >> 9] = 0;

当对一个对象引用进行写操作时（对象引用改变），写屏障逻辑将会标记对象所在的卡页为dirty。


## 虚共享（false sharing）
假设[[/CPU]]缓存行大小为64字节，64个卡表项将共享同一个缓存行。
一个缓存行将对应64个卡页一共64*512=32KB

更新卡表的同一个缓存行，从而造成缓存行的写回、无效化或者同步操作，间接影响程序性能。


### 怎么处理
不采用无条件的写屏障，写前判断dirty

###  CMS 标记 