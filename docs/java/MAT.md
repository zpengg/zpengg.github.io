# MAT Memory Analyzer Tool
内存分析工具

dump Hprof键则可以立即dump Hprof文件(Java Heap 分配信息存储在Hprof文件中)。 Cause GC键主要就是强制引发一次ＧＣ（垃圾回收）。

Shallow heap 是其自身在内存中的大小
Retained heap 指的就是在垃圾回收特定对象时将释放的内存量

- Dump diff
- leak suspect
- top component， ShallowHeap,RetainedHeap
- 分析 unReachable
