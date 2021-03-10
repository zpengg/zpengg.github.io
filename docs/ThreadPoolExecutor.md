# ThreadPoolExecutor
## 参数
- 核心数量 corePoolSize， 池最小数量，不够创建，超过回收
- 最大数量， **队列满后后创建** 非核心线程， 池中所有线程最多数量。
- 空闲时间， 超过 corePoolSize 的线程 等待超时 会终止
- 空闲时间单位，
- 阻塞队列长度
### 非核心线程：队列满后创建非核心线程。
非核心线程超时idle 会回收

### 拒绝策略: 队列已满 && 最大线程已满

### 参数设置
[[线程池参数]]

## case
```java
public class ThreadPoolTest01 {
    public static void main(String[] args) {
        // 新建一个线程池
        // 核心数量为5，最大数量为10，空闲时间为1秒，队列长度为5，拒绝策略打印一句话
        ExecutorService threadPool = new ThreadPoolExecutor(5, 10,
                1, TimeUnit.SECONDS, new ArrayBlockingQueue<>(5),
                Executors.defaultThreadFactory(), new RejectedExecutionHandler() {
            @Override
            public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
                System.out.println(currentThreadName()   ", discard task");
            }
        });

        // 提交20个任务，注意观察num
        for (int i = 0; i < 20; i  ) {
            int num = i;
            threadPool.execute(()->{
                try {
                    System.out.println(currentThreadName()   ", "  num   " running, "   System.currentTimeMillis());
                    Thread.sleep(2000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            });
        }

    }

    private static String currentThreadName() {
        return Thread.currentThread().getName();
    }
}
```
## excute(Runnable command)提交任务
1. 工作线程数量小于**核心数量**，池创建核心线程；
2. 线程数达到核心数量，任务进入**任务队列**；
3. 任务队列满了，池创建**非核心线程**；
4. 队列达到最大数量，执行拒绝策略；


## Worker 内部类： Thread 的包装
mianLock 控制 workers 的访问
```java
private final ReentrantLock mainLock = new ReentrantLock();
private final HashSet<Worker> workers = new HashSet<Worker>();
```
### aqs： 主线程结束线程时tryLock（）
Worker 内部 [[aqs]] 
外部调用shutDown() tryLock成功优雅结束线程。
shutDownNow() 则会中断正在执行党的任务
### runWorker（）
```java
    final void runWorker(Worker w) { 
        Thread wt = Thread.currentThread();
        Runnable task = w.firstTask;
        w.firstTask = null;
        // 外部加了锁 shutDown()
        w.unlock(); // allow interrupts
        boolean completedAbruptly = true;
        try {
            while (task != null || (task = getTask()) != null) {
                w.lock();
                // If pool is stopping, ensure thread is interrupted;
                // if not, ensure thread is not interrupted.  This
                // requires a recheck in second case to deal with
                // shutdownNow race while clearing interrupt
                if ((runStateAtLeast(ctl.get(), STOP) ||
                     (Thread.interrupted() &&
                      runStateAtLeast(ctl.get(), STOP))) &&
                    !wt.isInterrupted())
                    wt.interrupt();
                try {
                    beforeExecute(wt, task); // hook
                    Throwable thrown = null;
                    try {
                        // 真正执行位置
                        task.run();
                    } catch (RuntimeException x) {
                        thrown = x; throw x;
                    } catch (Error x) {
                        thrown = x; throw x;
                    } catch (Throwable x) {
                        thrown = x; throw new Error(x);
                    } finally {
                        afterExecute(task, thrown); //hook
                    }
                } finally {
                    task = null;
                    w.completedTasks++;
                    w.unlock();
                }
            }
            completedAbruptly = false;
        } finally {
            processWorkerExit(w, completedAbruptly);
        }
    }
```
