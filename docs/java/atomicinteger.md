# AtomicInteger
## 可见性
用 [[volatile]] 保证可见性
## 原子性
> volatile 保证可见性，禁止无法解决原子性
如 count++ 
 - 获取count 
 - 加1

有可能被线程调度打断。
使用CAS 保证原子性

## 例子
```java
import java.util.stream.IntStream;

public class Main {
    private static AtomicInteger count = 0;
    //private static int count = 0;  // 不具有原子性

    public static void increment() {
        count++;
    }

    public static void main(String[] args) {
        // 100 线程 每个自增1000次
        IntStream.range(0, 100)
                .forEach(i->
                        new Thread(()-> IntStream.range(0, 1000)
                                .forEach(j->increment())).start());

        // 这里使用2或者1看自己的机器
        // 我这里是用run跑大于2才会退出循环
        // 但是用debug跑大于1就会退出循环了
        while (Thread.activeCount() > 1) {
            // 让出CPU
            Thread.currentThread().getThreadGroup().list();
            Thread.yield();
        }

        System.out.println(count);
    }
}

```

## CompareAndSet 原子操作

[[Unsafe]]
[[CAS]]
```java
public final boolean compareAndSet(int expect, int update) {
    return unsafe.compareAndSwapInt(this, valueOffset, expect, update);
}
// Unsafe中的方法
public final native boolean compareAndSwapInt(Object var1, long var2, int var4, int var5);
```


## getAndIncrement 乐观锁：CAS + 自旋锁
```java
public final int getAndIncrement() {
    return unsafe.getAndAddInt(this, valueOffset, 1);
}

// Unsafe中的方法
public final int getAndAddInt(Object var1, long var2, int var4) {
    int var5;
    do {
        var5 = this.getIntVolatile(var1, var2);
    } while(!this.compareAndSwapInt(var1, var2, var5, var5 + var4));

    return var5;
}

```