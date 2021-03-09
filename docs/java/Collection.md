# Java集合
Show me the code！
近期开始计划进行源码的阅读了

## 数据结构
java常用的数据结构主要存在于java.util，主要继承于两个顶级接口Collection、Map
![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/23199c9d9b475d577daf4f4e8211fd22.png)

### Collection
约定构造方法
 - 无参数
 - 以Collection 类型参数 的构造方法 主要用于复制

对不支持的接口要抛出 UnsupportedOperationException

#### Set
Set 描述了集合中元素的 **不可重复性**, 不存在两个元素 ` e1.equals(e2)`

#### List
List 描述的是 **顺序关系**
有了顺序，就可以通过index序号访问
比起collection, 多了index 相关的一些接口

#### AbstractCollection
![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/542ced3a26aa9b6dda14b5d0de0aa4b3.png)
基于Iterator，实现了以上的接口
但Iterator 和 size()函数 还是抽象的 需要子类去实现。

也就是说每个AbstractCollection的子类, 都有一套基于迭代器 增、删、查存在 元素的方式。
但找到并修改 需要一些明确的位置的话就需要别的接口提供

### Map
![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/8a92473914125932eafee58fa4358665.png)
Map 接口里面还有一个`Entry<K,V>`接口
`Entry<K,V>` 描述的是一个key-value对，一组映射关系
key是不可以重复的, 引申Entry 也不会重复

Map 同时描述了三组关系 
 - a set of keys
 - a set of entry
 - a collection of values

注释中还提到是取代(take place of)以前的抽象类 Distionary

另外可以看到当Entry里value值不使用的时候，其实也就是相当于一个set了
set本质上也是这样实现的
如Hashset 内部 是一个HashMap， 而TreeSet 内部则是一个NavigableMap

### 两者关系
虽然见到两个接口的继承关系是分割的，但他们内部又由一些成员关联起来

### 历史原因
至此，我们以上是对1.8 一些简单集合的分析
但看代码时还可以关注历史版本中一些类的演变，改进，优化, 替代 等关系

比如:
vector 及其子类
dictionary 及其子类 hashtable
1.7的hashmap 与 1.8的差别

## 阅读顺序

先从最常见的入手, 几个基础接口都看一下

list相关的
 - [[ArrayList]]

map相关的
 - [[HashMap]] HashSet
 - [[TreeMap]] TreeSet
set 底层实现是Map
Collection 工具也可包装成set

以下用得少点 各个击破

这些也是刷题时常遇到的，先看看
 - [[PriorityQueue]] 堆
 - [[LinkedList]][[ArrayDequeue]] 双端队列,链表等概念 dequeue, 
 - [[LinkedHashMap]] LRU 与 LinkHashMap 关系, 利用了hashMap的钩子 

这些和语言特性有关系
 - WeakHashMap 弱引用 cache
 - EnumMap EnumSet

历史原因 先了解下特性再去看
synchronize 方法, 性能低，但事实还是有并发问题，如： add if not exist
 - [[Vector]] Stack
 - [[HashTable]]


 并发
 - [[ConcurrentHashMap]]
