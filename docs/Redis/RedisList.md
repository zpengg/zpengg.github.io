# RedisList


## adlist 
双端链表结构

```c 
typedef struct listNode{
       //前置节点
       struct listNode *prev;
       //后置节点
       struct listNode *next;
       //节点的值
       void *value;  
}listNode
```

```c
typedef struct list{
     //表头节点
     listNode *head;
     //表尾节点
     listNode *tail;
     //链表所包含的节点数量
     unsigned long len;
     //节点值复制函数
     void (*free) (void *ptr);
     //节点值释放函数
     void (*free) (void *ptr);
     //节点值对比函数
     int (*match) (void *ptr,void *key);
}list;
```

## 特点
- 可以直接获得头、尾节点。
- 双向

跟 sds 也对长度处理了
- 常数时间复杂度得到链表长度。

## ziplist
ziplist 结构

<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/7ffb02c911e8745ec6341106c98f7aea.png"/> </div>


小端（little endian）模式字节流 低位字节开头

Entry 结构

<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/a040efadb38089de384ceec672b73823.png"/> </div>


previous_entry_length 表示前一个数据项占用的总字节数。这个字段的用处是为了让ziplist能够从后向前遍历，双向链表

 - previous_entry_length < 254 只用一个字节来表示

 - previous_entry_length >= 254 用 4 Bytes Integer 来表示

encoding的长度和值根据保存的是int还是string，还有数据的长度而定；

根据第1个字节的不同 存储不同长度的字符串或者整数 9种方式

### 最大容量
ziplist结构所最多包含的entry个数。最大值为 215215

### ziplist 用途

最主要是为了节约内存，list，zset， hash 在数据量少的时候都用到了这种结构.

存储效率很高，但是它不利于修改操作，插入和删除操作需要频繁的申请释放内存。

### 转换阈值
REDIS_HASH_MAX_ZIPLIST_VALUE 64
REDIS_HASH_MAX_ZIPLIST_ENTRIES 512

## quicklist 
quicklist结构是在redis 3.2版本中新加的数据结构，用在列表的底层实现。
adlist(linked list) 可以说是没有出场的余地了

## 结构
```C 
typedef struct quicklistNode {
    struct quicklistNode *prev;
    struct quicklistNode *next;
    unsigned char *zl;
    unsigned int sz;             /* ziplist size in bytes */
    unsigned int count : 16;     /* count of items in ziplist */
    unsigned int encoding : 2;   /* RAW==1 or LZF==2 */
    unsigned int container : 2;  /* NONE==1 or ZIPLIST==2 */
    unsigned int recompress : 1; /* was this node previous compressed? */
    unsigned int attempted_compress : 1; /* node can't compress; too small */
    unsigned int extra : 10; /* more bits to steal for future usage */
} quicklistNode;
```

*zl 数据指针，如果没有被压缩，就指向ziplist结构，反之指向quicklistLZF结构 

```C
typedef struct quicklistLZF {
    unsigned int sz; /* LZF size in bytes*/
    char compressed[];
} quicklistLZF;
```

quicklistLZF结构表示一个被压缩过的ziplist。其中：

sz: 表示压缩后的ziplist大小。
compressed: 是个柔性数组（flexible array member），存放压缩后的ziplist字节数组。

```C
typedef struct quicklist {
    quicklistNode *head;
    quicklistNode *tail;
    unsigned long count;        /* total count of all entries in all ziplists */
    unsigned int len;           /* number of quicklistNodes */
    int fill : 16;              /* fill factor for individual nodes */
    unsigned int compress : 16; /* depth of end nodes not to compress;0=off */
} quicklist;
```

fill: 16bit，ziplist大小设置，存放list-max-ziplist-size参数的值。
compress: 16bit，节点压缩深度设置，存放list-compress-depth参数的值。

会影响插入时，是否需要创建节点或者直接从zlist 中插入

<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/fcdb2c189d2caf83b7450c0c914b6244.png"/> </div>


