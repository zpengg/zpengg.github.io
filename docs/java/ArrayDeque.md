# ArrayDeque
父接口参考 [[LinkedList]] deque

## ArrayDeque
隐藏掉 Cloneable 和 Serializable 两个接口 方便对比一下。

<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/92f077c99c9b8a1431179e2ab2acf9d8.png"/> </div>
功能上 ArrayList，LinkedList 两个是继承了 AbstractList，因此，他们都提供了基于 index 访问的方式。
而 ArrayDeque 则是直接从 AbstractCollection 外加了 Deque 的两头访问的方法。

### ArrayDeque 构造函数
无参默认 16，有参数取最近 2 的幂（8 个起）。
```JAVA
    public ArrayDeque() {
        elements = new Object[16];
    }

    public ArrayDeque(int numElements) {
        allocateElements(numElements);
    }

    public ArrayDeque(Collection<? extends E> c) {
        allocateElements(c.size());
        addAll(c);
    }

    private void allocateElements(int numElements) {
        elements = new Object[calculateSize(numElements)];
    }

    private static int calculateSize(int numElements) {
        int initialCapacity = MIN_INITIAL_CAPACITY;//8
        // Find the best power of two to hold elements.
        // Tests "<=" because arrays aren't kept full.
        // 最高位1 之后全置1，然后+1进位为最近的二的幂 
        if (numElements >= initialCapacity) {
            initialCapacity = numElements;
            initialCapacity |= (initialCapacity >>>  1);
            initialCapacity |= (initialCapacity >>>  2);
            initialCapacity |= (initialCapacity >>>  4);
            initialCapacity |= (initialCapacity >>>  8);
            initialCapacity |= (initialCapacity >>> 16);
            initialCapacity++;

            if (initialCapacity < 0)   // Too many elements, must back off
                initialCapacity >>>= 1;// Good luck allocating 2 ^ 30 elements
        }
        return initialCapacity;
    }

```
### 环状：二进制 mask 取模
```JAVA
    public void addFirst(E e) {
        if (e == null)
            throw new NullPointerException();
        elements[head = (head - 1) & (elements.length - 1)] = e;
        if (head == tail)
            doubleCapacity();
    }

    public void addLast(E e) {
        if (e == null)
            throw new NullPointerException();
        elements[tail] = e;
        if ( (tail = (tail + 1) & (elements.length - 1)) == head)
            doubleCapacity();
    }
```
#### 二进制 mask
`head = (head - 1) & (elements.length - 1)` 这一句可以看到 `head` 更新是一个 `&`操作，而元素长度刚好是 2 的幂，所以相当于是取模操作。
这时 head 和 tail 指针 相当于是数组头尾连接的 **环** 上移动。
head == tail 的情况就相当于整个环已经满了。
这样可以高效利用已分配的空间。

### 扩容： 2x, 复制数组
扩容相对于 ArrayList 来说简单一点，满了直接 doubleCapacity()。。

```JAVA
public void addFirst(E e) {
    if (e == null)
        throw new NullPointerException();
    elements[head = (head - 1) & (elements.length - 1)] = e;
    if (head == tail)
        doubleCapacity();
}

public void addLast(E e) {
    if (e == null)
        throw new NullPointerException();
    elements[tail] = e;
    if ( (tail = (tail + 1) & (elements.length - 1)) == head)
        doubleCapacity();
}

private void doubleCapacity() {
    assert head == tail;
    int p = head;
    int n = elements.length;
    int r = n - p; // number of elements to the right of p
    int newCapacity = n << 1;
    if (newCapacity < 0)
        throw new IllegalStateException("Sorry, deque too big");
    Object[] a = new Object[newCapacity];
    System.arraycopy(elements, p, a, 0, r);
    System.arraycopy(elements, 0, a, r, p);
    elements = a;
    head = 0;
    tail = n;
}

```
当然 double 之后，伴随着的是数组复制，以及 head tail 两个指针的重置为 0，n。
