# ConcurrentHashMap
## 历史
它的原理是引用了内部的 Segment ( ReentrantLock )  分段锁
但是在 Java 8 之后， JDK 却弃用了这个策略，重新使用了 synchronized+cas。


## sizeCtl
- -1，表示有线程正在进行初始化操作
- -(1 + nThreads)，表示有n个线程正在一起扩容
- 0，默认值，后续在真正初始化的时候使用默认容量
- > 0，初始化或扩容完成后下一次的扩容门槛

## put 方法
```java
public V put(K key, V value) {
    return putVal(key, value, false);
}

final V putVal(K key, V value, boolean onlyIfAbsent) {
    if (key == null || value == null) throw new NullPointerException();
    int hash = spread(key.hashCode());
    // 要插入的元素所在桶的元素个数
    int binCount = 0;
    // 死循环，结合CAS使用
    for (Node<K,V>[] tab = table;;) {
        Node<K,V> f; int n, i, fh;
        // ...
        // 根据桶中形态 
        // null,list,tree
        // ...
       
    }
    // 成功插入元素，元素个数加1（是否要扩容在这个里面）
    addCount(1L, binCount);
    // 成功插入元素返回 null, 已有的返回 替换前旧值
    return null;
}
```

### 初始化 table 和 sizeCtl
```java
if (tab == null || (n = tab.length) == 0)
    // 如果桶未初始化或者桶个数为0，则初始化桶
    tab = initTable();
```
```java
private final Node<K,V>[] initTable() {
    Node<K,V>[] tab; int sc;
    // tab.length != 0 更新成功 跳出循环
    while ((tab = table) == null || tab.length == 0) {
        if ((sc = sizeCtl) < 0)
            // 初始化或者扩容，让出CPU
            Thread.yield(); // lost initialization race; just spin
        else if (U.compareAndSwapInt(this, SIZECTL, sc, -1)) {
            try {
                // 再次检查table是否为空，防止ABA问题
                if ((tab = table) == null || tab.length == 0) {
                    int n = (sc > 0) ? sc : DEFAULT_CAPACITY;
                    // 新建数组
                    @SuppressWarnings("unchecked")
                    Node<K,V>[] nt = (Node<K,V>[])new Node<?,?>[n];
                    // 赋值给table桶数组
                    table = tab = nt;
                    // n - (n >>> 2) = n - n/4 = 0.75n 熟悉的负载因子！！
                    sc = n - (n >>> 2);
                }
            } finally {
                // 把sc赋值给sizeCtl，这时存储的是扩容门槛
                sizeCtl = sc;
            }
            break;
        }
    }
    return tab;
}
```
#### CAS 保证只有一个线程在初始化
#### 负载因子写死 扩容门槛 是 桶数组大小 的0.75倍
同数组大小 即
### 桶无元素，CAS 进桶
```java
else if ((f = tabAt(tab, i = (n - 1) & hash)) == null) {
    if (casTabAt(tab, i, null,
            new Node<K,V>(hash, key, value, null)))
        // 如果使用CAS插入元素成功，则break跳出循环，流程结束
        break;                   // no lock when adding to empty bin
}

```


### hash == MOVED 先迁移 helpTransfer
```java
else if ((fh = f.hash) == MOVED)
    // 如果要插入的元素所在的桶的第一个元素的hash是MOVED，则当前线程帮忙一起迁移元素
    tab = helpTransfer(tab, f);

```
#### 迁移 transfer
扩容2倍
迁移元素先从靠后的桶开始；
迁移完成的桶在里面放置一ForwardingNode类型的元素，标记该桶迁移完成；

### synchornize 对桶加锁 （分段）
```java
else {
    V oldVal = null;
    // f 之前算出的 桶 头节点
    synchronized (f) {
        // 再次检测第一个元素是否有变化，变化了需要从头来过
        // 算出 f 的过程中，桶头就可能已经被修改，需要再次判断是否还是桶头
        if (tabAt(tab, i) == f) {
            // 如果第一个元素的hash值大于等于0（说明不是在迁移，也不是树）
            if (fh >= 0) {
                // 链表
            }
            else if (f instanceof TreeBin) {
                // 树
            }
        }
    }
    // 如果binCount不为0，说明成功插入了元素或者寻找到了元素
    if (binCount != 0) {
        // 如果链表元素个数达到了8，则尝试树化
        // 因为上面把元素插入到树中时，binCount只赋值了2，并没有计算整个树中元素的个数
        // 所以不会重复树化
        if (binCount >= TREEIFY_THRESHOLD)
            treeifyBin(tab, i);
        // 如果要插入的元素已经存在，则返回旧值
        if (oldVal != null)
            return oldVal;
        // 退出外层大循环，流程结束
        break;
    }
}
```

#### 链表
```java
if (fh >= 0) {
    binCount = 1;
    // 遍历整个桶，每次结束binCount加1
    for (Node<K,V> e = f;; ++binCount) {
    K ek;
    if (e.hash == hash &&
            ((ek = e.key) == key ||
                    (ek != null && key.equals(ek)))) {
        // 如果找到了这个元素，则赋值了新值（onlyIfAbsent=false）
        // 并退出循环
        oldVal = e.val;
        if (!onlyIfAbsent)
            e.val = value;
        break;
    }
    Node<K,V> pred = e;
    if ((e = e.next) == null) {
        // 如果到链表尾部还没有找到元素
        // 就把它插入到链表结尾并退出循环
        pred.next = new Node<K,V>(hash, key,
                value, null);
        break;
    }
}
```

#### 树形式
```java
else if (f instanceof TreeBin) {
    // 如果第一个元素是树节点
    Node<K,V> p;
    // 桶中元素个数赋值为2，避免重复树化
    binCount = 2;
    // 如果成功插入则返回null, 否则返回寻找到的节点
    if ((p = ((TreeBin<K,V>)f).putTreeVal(hash, key,
            value)) != null) {
        // 如果找到了这个元素，则赋值了新值（onlyIfAbsent=false）
        oldVal = p.val;
        if (!onlyIfAbsent)
            p.val = value;
    }
}
```

## 扩容 addCount
### CounterCell 计算元素个数
LongAdder 思想, Strip 并发写思想
### CAS
整个扩容过程都是通过CAS控制sizeCtl这个字段来进行的
扩容时sizeCtl高位存储扩容邮戳(resizeStamp)，低位存储扩容线程数加1（1+nThreads）

```java
private final void addCount(long x, int check) {
    CounterCell[] as; long b, s;
 
    // 先尝试把数量加到baseCount上，如果失败再加到分段的CounterCell上
    if ((as = counterCells) != null ||
            !U.compareAndSwapLong(this, BASECOUNT, b = baseCount, s = b + x)) {
        CounterCell a; long v; int m;
        boolean uncontended = true;
        // 加到CounterCell
        if (as == null || (m = as.length - 1) < 0 ||
                (a = as[ThreadLocalRandom.getProbe() & m]) == null ||
                !(uncontended =
                        U.compareAndSwapLong(a, CELLVALUE, v = a.value, v + x))) {
            fullAddCount(x, uncontended); // 类似longadder 的longaccumulate
            return;
        }
        if (check <= 1)
            return;
        // 计算元素个数
        s = sumCount();
    }

    if (check >= 0) {
        Node<K,V>[] tab, nt; int n, sc;
        // 如果元素个数达到了扩容门槛，则进行扩容
        while (s >= (long)(sc = sizeCtl) && (tab = table) != null &&
                (n = tab.length) < MAXIMUM_CAPACITY) {
            // rs是扩容时的一个邮戳标识
            int rs = resizeStamp(n);
            if (sc < 0) {
                // 扩容中
                if ((sc >>> RESIZE_STAMP_SHIFT) != rs || sc == rs + 1 ||
                        sc == rs + MAX_RESIZERS || (nt = nextTable) == null ||
                        transferIndex <= 0)
                    // 扩容已经完成了，退出循环
                    // 正常应该只会触发nextTable==null这个条件，其它条件没看出来何时触发
                    break;
 
                // 扩容未完成，则当前线程加入迁移元素中
                // 并把扩容线程数加1
                if (U.compareAndSwapInt(this, SIZECTL, sc, sc + 1))
                    transfer(tab, nt);
            }
            else if (U.compareAndSwapInt(this, SIZECTL, sc,
                    (rs << RESIZE_STAMP_SHIFT) + 2))
                // 首发扩容线程
                // sizeCtl的高16位存储着rs这个扩容邮戳
                // sizeCtl的低16位存储着扩容线程数加1，即(1+nThreads)
                // 所以官方说的扩容时sizeCtl的值为 -(1+nThreads)是错误的
 
                // 进入迁移元素
                transfer(tab, null);
            // 重新计算元素个数
            s = sumCount();
        }
    }
}
```