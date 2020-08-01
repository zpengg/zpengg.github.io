# RedisHash
数据量少的时候是 ziplist（老） zipmap（新）
量多的时候是 dict

<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/ccaa3098a178e98a8e4ed1b559fbfc3e.png"/> </div>


特点： 两个 ht

使用哈希会更加节省内存，一个哈希并不适合存储大量的字段field
## rehash

## 渐进式 rehash
- 为 ht[1] 分配空间， 让字典同时持有 ht[0] 和 ht[1] 两个哈希表。
- 在字典中维持一个索引计数器变量 rehashidx ， 并将它的值设置为 0 ，表示 rehash 工作正式开始。
- 在 rehash 进行期间， 每次对字典执行添加、删除、查找或者更新操作时， 程序除了执行指定的操作以外， 还会顺带将 ht[0] 哈希表在 rehashidx 索引上的所有键值对 rehash 到 ht[1] ， 当 rehash 工作完成之后， 程序将 rehashidx 属性的值增一。
- 随着字典操作的不断执行， 最终在某个时间点上， ht[0] 的所有键值对都会被 rehash 至 ht[1] ， 这时程序将 rehashidx 属性的值设为 -1 ， 表示 rehash 操作已完成。

## 负载因子
散列表的负载因子 = 填入表中的元素个数/散列表的长度
我自己的记法是，已使用桶占比。跟 java 类似

### zipmap
zipmap主要是为了节省内存空间而设计的字符串-字符串映射结构

#### 参数
配置域字段最大个数限制
hash-max-zipmap-entries 512

配置字段值最大字节限制
hash-max-zipmap-value 64

#### 结构
zipmap (不用了)

<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/d72ad7fa106d306baf1e7e48d43fe56d.png"/> </div>

