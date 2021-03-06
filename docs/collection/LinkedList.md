#  LinkedList

---

两个deque 放一起说了。
<!--more-->
## 继承关系

![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/7f8e65651d9eee9c06cf5c6a4923564e.png)

queue已经介绍过了
现看下deque提供的接口

### Deque

![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/4f1bcff8fe223388933253f5e29ec295.png)

deque 主要多了头尾的概念，两头都可以操作，同时提供了stack会用到的push pop接口。
双端队列,队列和栈的综合体

然后也会提供两个方向的迭代器

### AbstractSequetialList
AbstractSequetianList 区别于 AbstractList 主要是以顺序迭代访问的方式，实现了部分index访问接口（ramdon-access, O(n)），需要通过迭代器来找到该位置

子类需要实现listIterator的方法。

用迭代器抽象的顺序列表。
LinkedList （双向）链表是其中一种实现。

## LinkedList
LinkedList 内部的节点修改
增加节点
- 从头
- 从尾
- 从某节点前插入

```JAVA
/**
 * Links e as first element.
 */
private void linkFirst(E e) {
    final Node<E> f = first;
    final Node<E> newNode = new Node<>(null, e, f);
    first = newNode;
    if (f == null)
        last = newNode;
    else
        f.prev = newNode;
    size++;
    modCount++;
}
/**
 * Links e as last element.
 */
void linkLast(E e) {
    final Node<E> l = last;
    final Node<E> newNode = new Node<>(l, e, null);
    last = newNode;
    if (l == null)
        first = newNode;
    else
        l.next = newNode;
    size++;
    modCount++;
}

/**
 * Inserts element e before non-null Node succ.
 */
void linkBefore(E e, Node<E> succ) {
    // assert succ != null;
    final Node<E> pred = succ.prev;
    final Node<E> newNode = new Node<>(pred, e, succ);
    succ.prev = newNode;
    if (pred == null)
        first = newNode;
    else
        pred.next = newNode;
    size++;
    modCount++;
}
```

删除节点
- 从头
- 从尾
- 删除中间节点，关联前后节点，有必要还更新头尾节点引用

```JAVA
/**
 * Unlinks non-null first node f.
 */
private E unlinkFirst(Node<E> f) {
    // assert f == first && f != null;
    final E element = f.item;
    final Node<E> next = f.next;
    f.item = null;
    f.next = null; // help GC
    first = next;
    if (next == null)
        last = null;
    else
        next.prev = null;
    size--;
    modCount++;
    return element;
}

/**
 * Unlinks non-null last node l.
 */
private E unlinkLast(Node<E> l) {
    // assert l == last && l != null;
    final E element = l.item;
    final Node<E> prev = l.prev;
    l.item = null;
    l.prev = null; // help GC
    last = prev;
    if (prev == null)
        first = null;
    else
        prev.next = null;
    size--;
    modCount++;
    return element;
}

/**
 * Unlinks non-null node x.
 */
E unlink(Node<E> x) {
    // assert x != null;
    final E element = x.item;
    final Node<E> next = x.next;
    final Node<E> prev = x.prev;

    if (prev == null) {
        first = next;
    } else {
        prev.next = next;
        x.prev = null;
    }

    if (next == null) {
        last = prev;
    } else {
        next.prev = prev;
        x.next = null;
    }

    x.item = null;
    size--;
    modCount++;
    return element;
}

```



