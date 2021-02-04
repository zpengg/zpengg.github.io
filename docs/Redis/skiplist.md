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

## 相关配置
```C
#define ZSKIPLIST_MAXLEVEL 32
#define ZSKIPLIST_P 0.25
 