

## 背景 ( 内存管理 & 长度复杂度 )
-   C 处理数组和字符串，要考虑分配空间，溢出等问题
-   长度改变，内存重新分配
-   获取长度需要遍历，O ( n )

## sdshdr
> The implementation of Redis strings is contained in sds.c ( sds stands for Simple Dynamic Strings )

### 结构
``` c
// 3.2 之前
struct sdshdr{
     //记录 buf 数组中已使用字节的数量
     //等于 SDS 保存字符串的长度
     int len;
     //记录 buf 数组中未使用字节的数量
     int free;
     //字节数组，用于保存字符串
     char buf[];
}
```

3.2 之后针对长度还做了优化，暂且忽略了。

### 作用
屏蔽内存溢出问题

len 计算好长度 解决长度查询问题

free 预留了空间 解决分配问题

### 扩容
```C
sds sdscat ( sds s, const char *t ) {
    return sdscatlen ( s, t, strlen ( t )) :
}
```
wrap 长度参数

```C
sds sdscatlen ( sds s, const void *t, size_t len ) {
    struct sdshdr *sh;
    size_t curlen = sdslen ( s ) ;
    s  = sdsMakeRoomFor ( s, len ) ;
    if ( s == NULL ) return NULL;

    sh = ( void * ) ( s-sizeof ( struct sdshdr )) ;
    memcpy ( s+curlen, t, len ) ;
    sh->len = curlen + len;
    sh->free = sh->free - len;
    s [curlen+len] = '\0';
    return s;
}
```

分配空间

```C
sds makeRoomFor ( sds s, size_t addlen ) {
    struct sdshdr *sh, *newsh;
    size_t free = sdsavail ( s ) ;
    if ( free > addlen ) return s; //无需扩展

    size_t len, newlen;
    len = sdslen ( s ) ;
    sh = ( void* ) ( s-sizeof ( struct sdshdr )) ) ;

    newlen = ( len + adulen ) ;
    //redis 扩容规则
    if ( newlen < SDS_MAX_PREALLOC )
        newlen *= 2;
    else
        newlen += SDS_MAX_PERALLOC

    newsh = zrelloc ( sh, sizeof ( struct sdshdr ) + newlen + 1 ) ;
    if ( news == NULL ) return NULL;
    newsh->free = newlen - len;
    return newsh->buf;
}
```

官网的图
```
-----------
|5|0|redis|
-----------
^   ^
sh  sh->buf
-----------
```

## 兼容 char * 
```c
typedef char *sds;
```
可以避免使用 sds->buf ，兼容使用 char * 做函数的库函数 ( strcmp,strcat 等 )。

```C
s = sdscat ( s, "Some more data" ) ;
```

API 返回后不能确定内部是否重新分配了空间，若 s 重新分配了需要重新返回引用

## 创建
sdsnew
```C
sds sdsnewlen(const void *init, size_t initlen) {
    void *sh;
    sds s;
    char type = sdsReqType(initlen);
    /* Empty strings are usually created in order to append. Use type 8
     * since type 5 is not good at this. */
    if (type == SDS_TYPE_5 && initlen == 0) type = SDS_TYPE_8;
    int hdrlen = sdsHdrSize(type);
    unsigned char *fp; /* flags pointer. */

    sh = s_malloc(hdrlen+initlen+1);
    if (!init)
        memset(sh, 0, hdrlen+initlen+1);
    if (sh == NULL) return NULL;
    s = (char*)sh+hdrlen;
    fp = ((unsigned char*)s)-1;
    switch(type) {
        case SDS_TYPE_5: {
            *fp = type | (initlen << SDS_TYPE_BITS);
            break;
        }
        case SDS_TYPE_8: {
            SDS_HDR_VAR(8,s);
            sh->len = initlen;
            sh->alloc = initlen;
            *fp = type;
            break;
        }
        case SDS_TYPE_16: {
            SDS_HDR_VAR(16,s);
            sh->len = initlen;
            sh->alloc = initlen;
            *fp = type;
            break;
        }
        case SDS_TYPE_32: {
            SDS_HDR_VAR(32,s);
            sh->len = initlen;
            sh->alloc = initlen;
            *fp = type;
            break;
        }
        case SDS_TYPE_64: {
            SDS_HDR_VAR(64,s);
            sh->len = initlen;
            sh->alloc = initlen;
            *fp = type;
            break;
        }
    }
    if (initlen && init)
        memcpy(s, init, initlen);
    s[initlen] = '\0';
    return s;
}

```
分配空间

    sh = s_malloc(hdrlen+initlen+1);

但是返回的是 s 的位置


    s = (char*)sh+hdrlen;


## 参考
官方的文档

https://github.com/redis/redis-doc/blob/master/topics/internals-sds.md

居然还有单独的库

https://github.com/antirez/sds
