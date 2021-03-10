# Future
## AbstractExecutorService.submit()
```java
public <T> Future<T> submit(Callable<T> task) {
    // 非空检测
    if (task == null) throw new NullPointerException();
    // 包装成FutureTask
    RunnableFuture<T> ftask = newTaskFor(task);
    // 交给execute()方法去执行
    execute(ftask);
    // 返回futureTask
    return ftask;
}
protected <T> RunnableFuture<T> newTaskFor(Callable<T> callable) {
    // 将普通任务包装成FutureTask
    return new FutureTask<T>(callable);
}
```

## Future 接口
只暴露get方法，常作为返回值
## FutureTask 实现类
### RUN： 线程执行逻辑
正常: state从NEW->COMPLETING->NORMAL，
异常：state从NEW->COMPLETING->EXCEPTIONAL
### GET: awaitDone 中阻塞调用线程直到任务完成
```java
// init with dummy
private volatile WaitNode waiters;
```

#### awiatDone()
```java
  private int awaitDone(boolean timed, long nanos)
        throws InterruptedException {
        final long deadline = timed ? System.nanoTime() + nanos : 0L;
        WaitNode q = null;
        boolean queued = false;
        for (;;) {
            // handle interrupt
            if (Thread.interrupted()) {
                removeWaiter(q);
                throw new InterruptedException();
            }

            int s = state;
            if (s > COMPLETING) {
                // 5 真正完成 恢复
                if (q != null)
                    q.thread = null;
                return s;
            }
            else if (s == COMPLETING) // cannot time out yet
                // 4 将要完成 让出 让他继续立个FLAG
                Thread.yield();
            else if (q == null)
                // 1.
                q = new WaitNode();
            else if (!queued)
                // 2.
                queued = UNSAFE.compareAndSwapObject(this, waitersOffset,
                                                     q.next = waiters, q);
            else if (timed) {
                // 3. 限时
                nanos = deadline - System.nanoTime();
                if (nanos <= 0L) {
                    removeWaiter(q);
                    return state;
                }
                LockSupport.parkNanos(this, nanos);
            }
            else
                // 3.不限时
                LockSupport.park(this);
        }
    }

```

## 例子
```java
// 任务执行的结果用Future包装
Future<Integer> future = threadPool.submit(() -> {
    try {
        Thread.sleep(1000);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    System.out.println("return: "   num);
    // 返回值
    return num;
});
```

## 应用 
[[RPC]] 异步调用
dubbo的异步调用（它是把Future扔到RpcContext中的）