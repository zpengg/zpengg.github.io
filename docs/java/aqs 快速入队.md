# AQS 快速入队
## 排队部分 addWaiter(Node mode)
### 快速入队
重复代码，但放循环外优化性能
```Java
private Node addWaiter(Node mode) {
    Node node = new Node(Thread.currentThread(), mode);
    // Try the fast path of enq; backup to full enq on failure
    Node pred = tail;
    if (pred != null) {
        node.prev = pred;
        // CAS非自旋
        if (compareAndSetTail(pred, node)) {
            pred.next = node;
            return node;
        }
    }
    // 退化为自选
    enq(node);
    return node;
}
```
### 自旋入队 (性能低)
先从队列尾部进行CAS快速入队，失败时再使用enq自旋入队
```Java
private Node enq(final Node node) {
    for (;;) {
        Node t = tail;
        if (t == null) { // Must initialize
            if (compareAndSetHead(new Node())) // head 是空Node 不持有线程
                tail = head;
        } else {
            node.prev = t;
            if (compareAndSetTail(t, node)) { // CASTail tail可能被其他线程更新了
                t.next = node;
                return t;
            }
        }
    }
}
```

