# CAS
## 原子性

## 可见性 
配合 [[volatile]] 
```java
IntStream.range(0,100).forEach(i->
    new Thread(()-> IntStream.range(0, 1000)
            .forEach(j-> increment())
        ).start();
    );
)
```


## Cas
```java
/* 
* @param 操作的对象；
* @param 对象中字段的偏移量；
* @param 原来的值，即期望的值；
* @param 要修改的值；
*/
public final native boolean unsafe.compareAndSwapInt(this , valueOffset , expect , update);
``` 
 


[[ABA]]
