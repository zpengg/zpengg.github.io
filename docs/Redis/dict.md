# DICT 字典

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
两个 [[ht]]

### rehash 条件
由 负载因子 决定扩容 or 收缩
[[rehash]]



##### 分配空间： 两倍已用 最近的二的幂
ht[0].used * 2<= 2^n, 最近的 2^n(2 的幂）