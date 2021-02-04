# Hash
## 实现
[[zipmap]] 2.6 以前
[[ziplist]]
[[dict]] with [[ht]]

数据量少的时候是 ziplist（老） zipmap（新）
量多的时候是 dict

## 特点

1. 小哈希 hset, 会更加节省内存（相对于 set) 会编码成ziplist
2. 一个哈希并不适合存储大量的字段 field, 字段需要遍历所有entry数组 O(n)

#### 配置
#### ziplist
hash-max-ziplist-entries 512  # hash 的元素个数超过 512 就必须用标准结构存储
hash-max-ziplist-value 64  # hash 的任意元素的 key/value 的长度超过 64 就必须用标准结构存储

#### zipmap 
hash-max-zipmap-entries
    默认值512，
    当某个map的元素个数达到最大值，但是其中最大元素的长度没有达到设定阀值时，
    其HASH的编码采用一种特殊的方式(更有效利用内存)。本参数与下面的参数组合使用来设置这两项阀值。设置元素个数

hash-max-zipmap-value
    默认值64，设置map中元素的值的最大长度

#### 其他
activerehashing
    默认值yes，用来控制是否自动重建hash
    Active rehashing每100微秒使用1微秒cpu时间排序，以重组Redis的hash表
    重建是通过一种lazy方式，写入hash表的操作越多，需要 执行rehashing的步骤也越多，