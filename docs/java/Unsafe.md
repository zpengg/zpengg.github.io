# Unsafe

## 静态实例方法
sun.misc.Unsafe, 仅供核心类使用，不暴露给普通用户

public static Unsafe getUnsafe()
根据 [[类加载器]] 判断是系统类，否则抛出SecurityException

## 反射 实例化
硬是要用， 用[[反射]]获得
## varHandle

JDK9 之后，官方推荐使用 java.lang.invoke.Varhandle 来替代 Unsafe 大部分功能，对比 Unsafe ，
[[Varhandle]]有着相似的功能，但会更加安全，并且，在并发方面也提高了不少性能。
## 作用
- 修改私有字段
- 抛出 checked [[异常]]
- 使用堆外内存
- [[CAS]] 无锁算法
- [[park]]、unpark 阻塞，唤醒[[线程]]