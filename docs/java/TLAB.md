# TLAB
## LAB
每个应用线程和GC线程都会独立的使用分区，进而减少同步时间，提升GC效率，这个分区称为本地分配缓冲区(Lab)。

## TLAB
TLAB（Thread Local Allocation Buffer）
EDEN区可开启 JVM 为每个线程分配了一个**线程私有缓存区域**
目的：快速分配,减少加锁机制导致的性能损耗


## GCLAB
GC也是一个独立线程， 
GCLab 用于复制对象
每个 GC 线程先从 freelist 申请一块大空间，然后在这块大空间里线性分配（bump pointer）
GC 转移对象

## PLAB
PromotionLab 用于晋升对。PLAB 则是在 old gen 里分配的一种临时的结构。就是的promotion LAB。
