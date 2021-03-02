# ArrayList

---

![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/b582bdbc74401259648f0d6bb1a4b0a7.png)

Clonable 可克隆
Serializable 可序列化
RamdomAccess 随机访问
都是空接口，相当于一个声明，约定

## List
重点关注 List 接口

![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/70282f18a00dc95df682759717b31906.png)

List 接口则主要是比 Collection 接口多了一些 与 index 相关 的接口

## AbstractList
定义了
- AbstractList
- SubList
- RandomAccessSubList
三个抽象类，暂时先略过后面两个

![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/ef87acb8388cfdc3b3ad3e372c6eb891.png)

AbstractList 有 Itr 内部类，不作细述。
迭代器 日常使用得不多，Iterator 模式是用于遍历集合类的标准访问方法。
```java
Iterator<String> iterator = lst.iterator();
//iterator.hasNext()如果存在元素的话返回true
while(iterator.hasNext()) {... }
...
for(Iterator it = c.iterater(); it.hasNext(); it.next()) 
```
由集合本身实现，它可以把访问逻辑从不同类型的集合类中抽象出来，从而避免向客户端暴露集合的内部结构。
### iterator 中 fail-fast
里面通常有变量`modCount` 描述列表的结构变化次数。主要用于 failed-fast。当不是预期的修改出现，快速抛出异常

## ArrayList
### 常量：默认容量 ，空数组
三个常量，给定默认值
```JAVA
// 没指定容量的时候，默认容量
private static final int DEFAULT_CAPACITY = 10;

// 空数组，从 0 开始扩容。
// 构造函数传空集合或指定 size=0 时
private static final Object[] EMPTY_ELEMENTDATA = {};

// 空数组，从默认容量 10 开始扩容。
private static final Object[] DEFAULTCAPACITY_EMPTY_ELEMENTDATA = {};
```
### 内部数组 , size
两个变量
elementData 存储数据
size 存入数据的数量，与 capacity 不一样
```JAVA
//存放数据的容器
transient Object[] elementData; // non-private to simplify nested class access

private int size;
```
### 构造函数
#### size 影响扩容的初始值
 - 构造函数传空集合或指定 size=0 时，扩容从 0 开始增长
 - 不指定 size，从 10 开始增长
 - 指定 size，从 size 开始增长
```java
public ArrayList(int initialCapacity) {
    if (initialCapacity > 0) {
        //Object Array
        this.elementData = new Object[initialCapacity];
    } else if (initialCapacity == 0) {
        //空数组
        this.elementData = EMPTY_ELEMENTDATA;
    } else {
        throw new IllegalArgumentException("Illegal Capacity: "+
                initialCapacity);
    }
}

public ArrayList() {
    this.elementData = DEFAULTCAPACITY_EMPTY_ELEMENTDATA;
}

//从其他集合构造
public ArrayList(Collection<? extends E> c) {
    elementData = c.toArray();
    if ((size = elementData.length) != 0) {
        // c.toArray might (incorrectly) not return Object[] (see 6260652)
        if (elementData.getClass() != Object[].class)
            elementData = Arrays.copyOf(elementData, size, Object[].class);
    } else {
        // replace with empty array. 空集合
        this.elementData = EMPTY_ELEMENTDATA;
    }
}
```

## 删除
### 复制数组，最后一个元素置null，避免重复引用

### 实现接口
具体的数据访问方式主要是实现了 AbstractList。

![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/0545378e5b916afb9bcfc95ee467a967.png)

这里不对具体的操作数据的方法细说。细节的可以自己翻源码查看一下。
### 扩容
主要关注扩容，数据检查的一些方法。
比如需要插入数据的时候，通常会`ensureCapacity`方法确保容量

```JAVA
public void ensureCapacity(int minCapacity) {
    int minExpand = (elementData != DEFAULTCAPACITY_EMPTY_ELEMENTDATA)
        // any size if not default element table
        ? 0
        // larger than default for default empty table. It's already
        // supposed to be at default size.
        : DEFAULT_CAPACITY;

    if (minCapacity > minExpand) {
        ensureExplicitCapacity(minCapacity);
    }
}

private static int calculateCapacity(Object[] elementData, int minCapacity) {
    if (elementData == DEFAULTCAPACITY_EMPTY_ELEMENTDATA) {
        return Math.max(DEFAULT_CAPACITY, minCapacity);
    }
    return minCapacity;
}

private void ensureCapacityInternal(int minCapacity) {
    ensureExplicitCapacity(calculateCapacity(elementData, minCapacity));
}

```
#### fail-fast
ArrayList 也采用了快速失败的机制，通过记录 modCount 参数来实现。
在面对**并发的修改**时，迭代器很快就会完全失败，避免出错了继续执行。
```java
private void ensureExplicitCapacity(int minCapacity) {
    //记录修改容量的次数，主要用于快速失败
    modCount++;

    // overflow-conscious code
    if (minCapacity - elementData.length > 0)
        grow(minCapacity);
}
```

#### 扩容：1.5X or more
最终判断需要扩容的话
调用 grow(minCapacity);
```JAVA
private void grow(int minCapacity) {
    // overflow-conscious code
    // 常规扩容 oldCapacity * 1.5
    int oldCapacity = elementData.length;
    int newCapacity = oldCapacity + (oldCapacity >> 1); 
    // 1.5 倍还不够，一步到位
    if (newCapacity - minCapacity < 0)
        newCapacity = minCapacity;
    // 超过最大容量了
    if (newCapacity - MAX_ARRAY_SIZE > 0)
        newCapacity = hugeCapacity(minCapacity);
    // minCapacity is usually close to size, so this is a win:
    elementData = Arrays.copyOf(elementData, newCapacity);
}
```
minCapacity 是需要达到的最小容量，与真正的扩展容量的大小是有区别的

```JAVA
/**
 * The maximum size of array to allocate.
 * Some VMs reserve some header words in an array.
 * Attempts to allocate larger arrays may result in
 * OutOfMemoryError: Requested array size exceeds VM limit
 */
private static final int MAX_ARRAY_SIZE = Integer.MAX_VALUE - 8;

private static int hugeCapacity(int minCapacity) {
    if (minCapacity < 0) // overflow
        throw new OutOfMemoryError();
    return (minCapacity > MAX_ARRAY_SIZE) ?
        Integer.MAX_VALUE :
        MAX_ARRAY_SIZE;
}

```
`MAX_ARRAY_SIZE`是 此处是部分 VM 会保留头部   数组的对象头信息相较于其他 Object，多了一个表示数组长度的信息。 
VM 内存足够的话，才可以设置为 `MAX_ARRAY_SIZE` 这么大。 再高就溢出了

基于 index 的访问方法会进行 rangeCheck
```JAVA
private void rangeCheck(int index) {
    if (index >= size)
        throw new IndexOutOfBoundsException(outOfBoundsMsg(index));
}

private void rangeCheckForAdd(int index) {
    if (index > size || index < 0)
        throw new IndexOutOfBoundsException(outOfBoundsMsg(index));
}

private String outOfBoundsMsg(int index) {
    return "Index: "+index+", Size: "+size;
}
```

基于 object 的则是主要用到 equals 方法遍历去寻找元素
```JAVA
for (int i = 0; i < size; i++)      
    if (o.equals(elementData[i]))
        return i;
```

修改数据需要通过复制数组实现，同时还会修改`modCount`
```JAVA
public static native void arraycopy(Object src,  int  srcPos,
        Object dest, int destPos,
        int length);
```
