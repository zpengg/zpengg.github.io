# WeakHashmap
## 数组 + 链表， 没有红黑树
因为 entry 会被回收，不会太多
 
## 引用队列， 失效队列
```java
/**
 * 引用队列，当弱键失效的时候会把Entry添加到这个队列中
 */
private final ReferenceQueue<Object> queue = new ReferenceQueue<>();
```

## entry 继承弱应用
将一对key, value放入到 WeakHashMap 里并不能避免该key值被GC回收，
除非在 WeakHashMap 之外还有对该key的强引用

### 构造函数 父类对key 做弱引用
```java
private static class Entry<K,V> extends WeakReference<Object> implements Map.Entry<K,V> {
    // 可以发现没有key, 因为key是作为弱引用存到Referen类中
    V value;
    final int hash;
    Entry<K,V> next;

    Entry(Object key, V value,
          ReferenceQueue<Object> queue,
          int hash, Entry<K,V> next) {
        // 调用WeakReference的构造方法初始化key和引用队列
        super(key, queue);
        this.value = value;
        this.hash  = hash;
        this.next  = next;
    }
}

public class WeakReference<T> extends Reference<T> {
    public WeakReference(T referent, ReferenceQueue<? super T> q) {
        // 调用Reference的构造方法初始化key和引用队列
        super(referent, q);
    }
}

public abstract class Reference<T> {
    // 实际存储key的地方
    private T referent;         /* Treated specially by GC */
    // 引用队列
    volatile ReferenceQueue<? super T> queue;
    
    Reference(T referent, ReferenceQueue<? super T> queue) {
        this.referent = referent;
        this.queue = (queue == null) ? ReferenceQueue.NULL : queue;
    }
}
```

## 没有WeakHashSet, 不过可以包装成set
```java
// 将WeakHashMap包装成一个Set
Set<Object> weakHashSet = Collections.newSetFromMap(
        new WeakHashMap<Object, Boolean>());
```

## 每次操作都会清除过期

## 对比 hashmap
### hash 4 次异或, 减少冲突

### 链表头插入

### resize 顺带清理元素
清理后 还需要扩容  才使用新桶
否则挪回旧桶，移动了两次 

transefer(old, new)
transefer(new, old)

### 要重算index


## 使用
### new String() 才会失效