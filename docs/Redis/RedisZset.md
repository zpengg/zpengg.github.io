RedisZset

```C
#define ZSKIPLIST_MAXLEVEL 32
#define ZSKIPLIST_P 0.25
 
typedef struct zskiplistNode {
    robj *obj;
    double score;
    struct zskiplistNode *backward;
    struct zskiplistLevel {
        struct zskiplistNode *forward;
        unsigned int span;
    } level[];
} zskiplistNode;

typedef struct zskiplist {
    struct zskiplistNode *header, *tail;
    unsigned long length;
    int level;
} zskiplist;
```
如图所示
```
<- node ->
        ->
        ...level
        ->
```

## zset
当数据较少时，sorted set是由一个ziplist来实现的。

当数据多的时候，才转换成zset

```C
typedef struct zset {
    dict *dict;
    zskiplist *zsl;
} zset;

```
 - dict用来查询数据到分数(score)的对应关系
 - skiplist用来根据分数查询数据（可能是范围查找）