# Quicklist
## 背景
[[adlist]] 
各个节点是单独的内存块 碎片问题 

[[ziplist]] 
长度很长的时候，一次realloc可能会导致大批量的数据拷贝
## quicklist
3.2 版本后 [[list]] 的实现
一个由ziplist组成的双向链表。节点是ziplist


## 定义
```c++
typedef struct quicklistNode {
    struct quicklistNode *prev;
    struct quicklistNode *next;
    unsigned char *zl;
    unsigned int sz;             /* ziplist size in bytes */
    unsigned int count : 16;     /* count of items in ziplist */
    unsigned int encoding : 2;   /* RAW==1 or LZF==2 */
    unsigned int container : 2;  /* NONE==1 or ZIPLIST==2  预留， 但目前都是2*/
    unsigned int recompress : 1; /* was this node previous compressed? */
    unsigned int attempted_compress : 1; /* node can't compress; too small */
    unsigned int extra : 10; /* more bits to steal for future usage */
} quicklistNode;

// quicklistLZF结构表示一个被压缩过的ziplist
typedef struct quicklistLZF {
    unsigned int sz; /* LZF size in bytes*/
    char compressed[];
} quicklistLZF;

typedef struct quicklist {
    quicklistNode *head;
    quicklistNode *tail;
    unsigned long count;        /* total count of all entries in all ziplists */
    unsigned int len;           /* number of quicklistNodes */
    int fill : 16;              /* fill factor for individual nodes */
    unsigned int compress : 16; /* depth of end nodes not to compress;0=off */
} quicklist;

```

## 特点
### 不包含空余头节点 初始化为null
### LZF encoding 进一步压缩
无损
对重复值进行压缩
通过hash表来判断是否重复数据
默认模式是VERY_FAST

[参考](https://blog.csdn.net/yitouhan/article/details/108035859?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control)

#### quicklistLZF
柔性数组

### container
预留字段，目前都是ziplist

## 配置
[[ziplist]]配置关系
list-max-ziplist-size ：每个 quicklist 节点上的 ziplist 长度

当取负值的时候，表示按照占用字节数来限定每个quicklist节点上的ziplist长度。这时，它只能取-1到-5这五个值，每个值含义如下：

-5: 每个quicklist节点上的ziplist大小不能超过64 Kb。（注：1kb => 1024 bytes）
-4: 每个quicklist节点上的ziplist大小不能超过32 Kb。
-3: 每个quicklist节点上的ziplist大小不能超过16 Kb。
-2: 每个quicklist节点上的ziplist大小不能超过8 Kb。（-2是Redis给出的默认值）
-1: 每个quicklist节点上的ziplist大小不能超过4 Kb。

list-compress-depth ：quicklist头尾两端不进行**LZF**压缩的节点数目 默认0

