# dynamicStriping 并发写入
[[Strip64]]
动态striping,就是能够再不同设备上分配 block,
不同设备上当然是并发的写入, 能够觉得是一种strip操作
```java
strip: [1|2|3|4|5|7]
```

