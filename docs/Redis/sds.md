# Sds

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
![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/1611373338d69e22.png)

3.2 之后针对长度还做了优化，暂且忽略了。

### 特性
1. 内存动态分配。free 预留了空间，解决分配问题。改变时也会检查
2. 避免溢出问题。buff 区动态调整
3. 预处理长度。len 计算好长度 解决长度查询问题
4. 兼容 C 字符串。 重用部分 C 字符串接口 如 printf
5. 二进制安全。可以识别`\n`空字符，用 len 来判断到达末尾。

### 作用
 - 字符串
 - 缓冲区。[[AOF]] 和 客户端输入的缓冲区都是由 sds 实现

### 源码

[[sds]]

## 参考
官方的文档

https://github.com/redis/redis-doc/blob/master/topics/internals-sds.md

居然还有单独的库

https://github.com/antirez/sds
## 拼接字符串 sdscat
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

### 计算分配空间 makeRoomFor（buff区预留free大小， 动态扩展）
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


## 兼容 char * 
```c
typedef char *sds;
```
可以避免使用 sds->buf ，兼容使用 char * 做函数的库函数 ( strcmp,strcat 等 )。

官网的图
```
-----------
|5|0|redis|
-----------
^   ^
sh  sh->buf
-----------
```

```C
s = sdscat ( s, "Some more data" ) ;
```

API 返回后不能确定内部是否重新分配了空间，若 s 重新分配了需要重新返回引用

## 创建新字符串
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

## 逆序存位数组

bitcount 使用了查表&swar算法


