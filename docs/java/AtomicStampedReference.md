# AtomicStampedReference

## ABA

## Pair<> 版本号，值    
比如，上面的栈结构增加一个版本号用于控制，每次CAS的同时检查版本号有没有变过。
还有一些数据结构喜欢使用高位存储一个邮戳来保证CAS的安全。
