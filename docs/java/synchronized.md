# synchronized
## 用法
对象内同步
```java
// 1.block
public void func() {
    synchronized (this) {
        // ...
    }
}
// 2.method
public synchronized void func () {

```

类内同步
```java
// 3.class
public void func() {
    synchronized (SynchronizedExample.class) {
        // ...
    }
}
// 4.static method
public synchronized static void fun() {
    // ...
}

```



## 字节码 monitorenter/exit & ACC_SYNCHRONIZED

### monitor: JVM ObjectMonitor
每个对象都会与一个monitor相关联，当某个monitor被拥有之后就会被锁住，当线程执行到monitorenter指令时，就会去尝试获得对应的monitor。对线程计数器计数
- count
- owner
- waitset wait 状态阻塞队列， 进入wait释放锁
- entrylist block 状态
- recursion 重入

## 对象 到 monitor
对象头 --> markword 32bit -->


## 特性
[[锁膨胀]]
[[锁消除]]

## wait/notify
配合[[Object]]的wait()、notify()系列方法可以实现等待/通知模式。