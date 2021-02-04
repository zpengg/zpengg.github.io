# dict 字典

## 定义
```c++
typedef struct dictEntry {
    void *key;
    union {
        void *val;
        uint64_t u64;
        int64_t s64;
        double d;
    } v;
    struct dictEntry *next;
} dictEntry;

/* 各类型数据 的对应的 函数 */
typedef struct dictType {
    uint64_t (*hashFunction)(const void *key);
    void *(*keyDup)(void *privdata, const void *key);
    void *(*valDup)(void *privdata, const void *obj);
    int (*keyCompare)(void *privdata, const void *key1, const void *key2);
    void (*keyDestructor)(void *privdata, void *key);
    void (*valDestructor)(void *privdata, void *obj);
} dictType;

/* This is our hash table structure. Every dictionary has two of this as we
 * implement incremental rehashing, for the old to the new table. */
typedef struct dictht {
    dictEntry **table;
    unsigned long size; //总是2的指数次幂
    unsigned long sizemask; // sizemask = size -1
    unsigned long used; // 存节点数量 含链表
} dictht;

typedef struct dict {
    dictType *type;
    void *privdata;
    dictht ht[2]; /* 两个 ht 渐进 rehash*/
    long rehashidx; /* rehashing not in progress if rehashidx == -1 */
    unsigned long iterators; /* number of iterators currently running */
} dict;

```

dict 长这样：
<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/ccaa3098a178e98a8e4ed1b559fbfc3e.png"/> </div>

## 特点
### hashTable 实现
两个 [[ht]]

### 负载因子
散列表的负载因子 = 填入表中的元素个数/散列表(数组)的长度
load_factor = ht[0].used/ ht[0].size
动态的参数

> 和java hashmap 有不同， java是把load factor 作为固定参数，`threshold = capacity * load_cactor`, 去计算需要扩容的阈值

### rehash 条件
由 负载因子 决定扩容 or 收缩
1. bgsave bgrewriteaof 没执行中 load_factor>=1
2. bgsave bgrewriteaof 执行中 load_factor>=5

#### 渐进式 rehash
- 为 ht[1] 分配空间， 让字典同时持有 ht[0] 和 ht[1] 两个哈希表。
- 在字典中维持一个索引计数器变量 rehashidx ， 并将它的值设置为 0 ，表示 rehash 工作正式开始。
- 在 rehash 进行期间， 每次对字典执行添加、删除、查找或者更新操作时， 程序除了执行指定的操作以外， 还会顺带将 ht[0] 哈希表在 rehashidx 索引上的所有键值对 rehash 到 ht[1] ， 当 rehash 工作完成之后， 程序将 rehashidx 属性的值增一。
- 随着字典操作的不断执行， 最终在某个时间点上， ht[0] 的所有键值对都会被 rehash 至 ht[1] ， 这时程序将 rehashidx 属性的值设为 -1 ， 表示 rehash 操作已完成。
- 交换 2 个 ht，释放并重建空白替换旧的 周而复始

##### 分配空间： 两倍已用 最近的二的幂
ht[0].used * 2<= 2^n, 最近的 2^n(2 的幂）