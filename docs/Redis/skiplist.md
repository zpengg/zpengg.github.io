# skiplist 跳表

## 定义
``` c
typedef struct zskiplistNode {
    robj *obj;
    double score;
    struct zskiplistNode *backward;
    struct zskiplistLevel {
        struct zskiplistNode *forward;
        unsigned int span; // 跨度
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
backward  双向指针  forward (多个，by levels)
        <- node ->
                ->
                ... 指向不同 level 的节点
                ->
```

## 内存布局
主要是zsl部分

```
+----------------------+                                       +--------+     +------------+    +---------+
|     redisObject      |                                   +-->| dictht |     |  StringObj | -> |  long   |
+----------------------+                       +-------+   |   +--------+     +------------+    +---------+
|         type         |                   +-->| dict  |   |   | table  | --> |  StringObj | -> |  long   |
|      REDIS_ZSET      |                   |   +-------+   |   +--------+     +------------+    +---------+
+----------------------+                   |   | ht[0] | --+                  |  StringObj | -> |  long   |
|       encoding       |      +--------+   |   +-------+      +-----+         +------------+    +---------+
| OBJ_ENCODING_ZIPLIST |      |  zset  |   |                  | L32 | -> NULL
+----------------------+      +--------+   |                  +-----+
|          ptr         | ---> |  dict  | --+                  | ... |
+----------------------+      +--------+       +--------+     +-----+    +-----------+                     +-----------+
                              |  zsl   | --->  | header | --> | L4  | -> |     L4    | ------------------> |     L4    | -> NULL
                              +--------+       +--------+     +-----+    +-----------+                     +-----------+
                                               | tail   |     | L3  | -> |     L3    | ------------------> |     L3    | -> NULL
                                               +--------+     +-----+    +-----------+    +-----------+    +-----------+
                                               | level  |     | L2  | -> |     L2    | -> |     L2    | -> |     L2    | -> NULL
                                               +--------+     +-----+    +-----------+    +-----------+    +-----------+
                                               | length |     | L1  | -> |     L1    | -> |     L1    | -> |     L1    | -> NULL
                                               +--------+     +-----+    +-----------+    +-----------+    +-----------+
                                                                 NULL <- |     BW    | <- |     BW    | <- |     BW    |
                                                                         +-----------+    +-----------+    +-----------+
                                                                         | StringObj |    | StringObj |    | StringObj |
                                                                         +-----------+    +-----------+    +-----------+
                                                                         |    long   |    |    long   |    |    long   |
                                                                         +-----------+    +-----------+    +-----------+
```

## skiplistnode
```
      ...
 +-----------+
 |     L4    | -> NULL
 +-----------+
 |     L3    | -> NULL
 +-----------+
 |     L2    | -> NULL
 +-----------+
 |     L1    | -> NULL
 +-----------+
 |     BW    |
 +-----------+
 | StringObj |
 +-----------+
 |    long   |
 +-----------+
```

## 后退指针

```
                +-----------+    +-----------+    +-----------+
        NULL <- |     BW    | <- |     BW    | <- |     BW    |
                +-----------+    +-----------+    +-----------+
```


## zskiplist 
### 头节点
MAX 32 层 （没有值, 只有层导航用）
`zsl->header = zslCreateNode(ZSKIPLIST_MAXLEVEL,0,NULL);`


## 插入节点
### 随机层数 幂率分布 值范围[1,max]
相当于连续抛硬币`P(n) =(1/4)^n`

```c
int zslRandomLevel(void) {
    int level = 1;
    while ((random()&0xFFFF) < (ZSKIPLIST_P * 0xFFFF))
        level += 1;
    return (level<ZSKIPLIST_MAXLEVEL) ? level : ZSKIPLIST_MAXLEVEL;
}
```
#### 0.25 的空间开销
节点层数至少为1。而大于1的节点层数，满足一个概率分布。
节点层数恰好等于1的概率为1-p。
节点层数大于等于2的概率为p，而节点层数恰好等于2的概率为p(1-p)。
节点层数大于等于3的概率为p2，而节点层数恰好等于3的概率为p2(1-p)。
节点层数大于等于4的概率为p3，而节点层数恰好等于4的概率为p3(1-p)。
......
因此，一个节点的平均层数（也即包含的平均指针数目），计算如下：

skiplist平均层数计算

现在很容易计算出：

当p=1/2时，每个节点所包含的平均指针数目为2；
当p=1/4时，每个节点所包含的平均指针数目为1.33。这也是Redis里的skiplist实现在空间上的开销。

## 相关配置
```C
#define ZSKIPLIST_MAXLEVEL 32
#define ZSKIPLIST_P 0.25
 