Redis 对象 & 数据结构总结


<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/94fa411dbf14c578016b4dea3dbf3823.png"/> </div>


## 对象结构
```C
typedef struct redisObject {
    unsigned type:4;
    unsigned encoding:4;
    unsigned lru:LRU_BITS; /* lru time (relative to server.lruclock) */
    int refcount;
    void *ptr;
} robj;
```

### 5种对象
```C
 /* Object types */
#define OBJ_STRING 0
#define OBJ_LIST 1
#define OBJ_SET 2
#define OBJ_ZSET 3
#define OBJ_HASH 4
```
### 编码方式
```C
/* Objects encoding. Some kind of objects like Strings and Hashes can be
 * internally represented in multiple ways. The 'encoding' field of the object
 * is set to one of this fields for this object. */
#define OBJ_ENCODING_RAW 0     /* Raw representation -- 简单动态字符串sds*/
#define OBJ_ENCODING_INT 1     /* Encoded as integer -- long类型的整数*/
#define OBJ_ENCODING_HT 2      /* Encoded as hash table -- 字典dict*/
#define OBJ_ENCODING_ZIPMAP 3  /* Encoded as zipmap -- 3.2.5版本后不再使用 */
#define OBJ_ENCODING_LINKEDLIST 4 /* Encoded as regular linked list -- 双向链表*/
#define OBJ_ENCODING_ZIPLIST 5 /* Encoded as ziplist -- 压缩列表*/
#define OBJ_ENCODING_INTSET 6  /* Encoded as intset -- 整数集合*/
#define OBJ_ENCODING_SKIPLIST 7  /* Encoded as skiplist -- 跳表*/
#define OBJ_ENCODING_EMBSTR 8  /* Embedded sds string encoding -- embstr编码的sds*/
#define OBJ_ENCODING_QUICKLIST 9 /* Encoded as linked list of ziplists -- 由双端链表和压缩列表构成的高速列表*/
```
<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/4cf7587786066cb5ca4b11612b2555bc.png"/> </div>

### refcount 引用计数，回收