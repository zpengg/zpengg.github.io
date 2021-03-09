# Ziplist
ziplist是一堆**字节数据** 靠约定结构来解析 
Object encoding ziplist

## ziplist 结构
```
<总Byte> <tail偏移byte> <entry 个数> <......entry...> <0xFF>
<zlbytes> <zltail> <zllen> <entry> <entry> ... <entry> <zlend>
```

### 各段含义
zlbytes：32bit无符号整数，表示ziplist占用的字节总数（包括本身占用的4个字节）；
zltail：32bit无符号整数，记录最后一个entry的偏移量，方便快速定位到最后一个entry；
zllen：16bit无符号整数，记录entry的个数；
entry：存储的若干个元素，可以为字节数组或者整数；
zlend：ziplist最后一个字节，是一个结束的标记位，值固定为255。

### tail 偏移：方便逆向

### entry最多 255
ziplist 结构所最多包含的 entry 个数。最大值为 255

### Entry 结构

<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/a040efadb38089de384ceec672b73823.png"/> </div>

#### previous_entry_length 前一节点长度
previous_entry_length 表示前一个数据项占用的总字节数。这个字段的用处是为了让 ziplist 能够从后向前遍历，双向链表
 - previous_entry_length < 254 只用 1 Byte 来表示
 - previous_entry_length >= 254 用 4 Bytes Integer 来表示


根据第 1 个字节的不同 存储不同长度的字符串或者整数 9 种方式

##### 作用：逆向遍历
prev_ptr = curr_ptr - curr_entry.previous_entry_length

##### 性能问题：连锁更新 cascade update
前节点长度变大时 可能引起 entry 的连锁更新
低概率 O（n^2）

>压缩列表里恰好有多个连续的、长度介于250字节到253字节之间的结点
>即使出现连锁更新，只要结点数量不多，就不会造成影响


#### encoding 
encoding 的长度和值根据保存的是 int 还是 byte[]，还有数据的长度而定；
##### 字节数组编码 表 7-2
##### 整数编码 表 7-3


## 特点: 节约内存，格式简单
最主要是为了节约内存，list，zset， hash 在数据量少的时候都用到了这种结构。
存储效率很高，但是它不利于修改操作，插入和删除操作需要频繁的申请释放内存。
小端（little endian）模式字节流 低位字节开头

### 转换链表配置 阈值
[[zset]]
[[hash]]

阈值与两个东西有关
1. entry 元素个数
2. entry 长度

```
hash-max-ziplist-entries 512  # hash 的元素个数超过 512 就必须用标准结构存储
hash-max-ziplist-value 64  # hash 的任意元素的 key/value 的长度超过 64 就必须用标准结构存储
zset-max-ziplist-entries 128  # zset 的元素个数超过 128 就必须用标准结构存储
zset-max-ziplist-value 64  # zset 的任意元素的长度超过 64 就必须用标准结构存储
list ...
```

