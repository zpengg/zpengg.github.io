# ConcurrentHashMap
## 历史
它的原理是引用了内部的 Segment ( ReentrantLock )  分段锁
但是在 Java 8 之后， JDK 却弃用了这个策略，重新使用了 synchronized+cas。