# cardtable
使用了卡标记（Card Marking）技术来解决老年代到新生代的引用问题。具体是，使用卡表（Card Table）和写屏障（Write Barrier）来进行标记并加快对GC Roots的扫描。
## 堆 --2^n--> cardPage 512B
堆空间划分为一系列2次幂大小的卡页（Card Page）。
HotSpot JVM的卡页（Card Page）大小为512字节数组

## cardTable -->  cardPage-flag ，卡页范围,不精确到对象
卡表（Card Table），用于标记卡页的状态，每个卡表项 1 byte 对应一个卡页

## Dirty Card 判断为之内对象修改
CARD_TABLE [this address >> 9] = 0; // 4k个位置/bit
当对一个对象引用进行写操作时（对象引用改变），写屏障逻辑将会标记对象所在的卡页为dirty。
01 标记
dirty 才需要 GC


