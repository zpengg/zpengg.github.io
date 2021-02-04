# adlist
## 实现
![双端链表](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/1611387660617ba3.png)


```c 
typedef struct listNode{
       //前置节点
       struct listNode *prev;
       //后置节点
       struct listNode *next;
       //节点的值（多态）
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


