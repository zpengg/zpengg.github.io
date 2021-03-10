# ThreadLocal
线程内存储的能力
## static ThreadLocal.ThreadLocalMap 
ThreadLocal的静态内部类ThreadLocalMap
[[弱引用]] ThreadLocal 的 Entry<ThreadLocal, object>
```java
// 内部类ThreadLocalMap
    static class ThreadLocalMap {
        
        static class Entry extends WeakReference<ThreadLocal<?>> {
            Object value;
            // 内部类Entity，实际存储数据的地方
            // Entry的key是ThreadLocal对象，不是当前线程ID或者名称
            Entry(ThreadLocal<?> k, Object v) {
                super(k);
                value = v;
            }
        }
        // 注意这里维护的是Entry数组
        private Entry[] table;
    }

```
为**每个Thread**都维护了一个数组table，
ThreadLocal确定了一个数组下标，而这个下标就是value存储的对应位置。。

### 每个 Thread 会创建一个 ThreadLocalMap 对象
thread 内
`ThreadLocal.ThreadLocalMap threadLocals = null;`
 Thread t = Thread.currentThread();
 ThreadLocalMap map = getMap(t);

外部引用 ------------------------------------+
 |                                          |
运行过程中创建的ThreadLocal                  |
 |                                          |
 |      | weak key    | value  |            |
 计算   |-------------|--------|        没有引用关联
 |      | key | object |   -----------------
 +----- | key | object |

thread中
threadLocal实例 持有 threadLocals 对象
threadLocals 数组 记录用弱引用作key 的 Entry对象， entry 强引用 实际想关联的 object 

## set
```java
public void set(T value) {
    //(1)获取当前线程（调用者线程）
    Thread t = Thread.currentThread();
    //(2)以当前线程作为key值，去查找对应的线程变量，找到对应的map
    ThreadLocalMap map = getMap(t);
    //(3)如果map不为null，就直接添加本地变量，key为当前定义的ThreadLocal变量的this引用，值为添加的本地变量值
    if (map != null)
        map.set(this, value);
    //(4)如果map为null，说明首次添加，需要首先创建出对应的map
    else
        createMap(t, value);
}

ThreadLocalMap getMap(Thread t) {
    return t.threadLocals; //获取线程自己的变量threadLocals，并绑定到当前调用线程的成员变量threadLocals上
}

```


## 内存泄漏
线程如果不进入terminated状态，ThreadLocalMap就不会被GC回收，这才是ThreadLocal内存泄露的原
如 spring 线程池 每次请求复用了线程。不会销毁 ThreadLocal

## 单例模式
threadLocal 指向自己
```java
public class ThreadLocalInstance {
    private static final ThreadLocal<ThreadLocalInstance> threadLocalInstanceThreadLocal
             = new ThreadLocal<ThreadLocalInstance>(){
        @Override
        protected ThreadLocalInstance initialValue() {
            return new ThreadLocalInstance();
        }
    };
    private ThreadLocalInstance(){
 
    }
 
    public static ThreadLocalInstance getInstance(){
        return threadLocalInstanceThreadLocal.get();
    }
 
}
```
## 应用
### 维护session
### SimpleDateFormat
更推荐joda