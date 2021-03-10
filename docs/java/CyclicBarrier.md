# CyclicBarrier

阻塞一组线程直到这些线程同时达到某个条件才继续执行，

> 等大家到同一起跑线
## 没有显式Countdown
## 互斥： 只有一个在运行
[[ReentrantLock]]
## 条件锁
[[条件锁]]

完成的任务 park 在 Condition 队列
否则再放回

## 例子：
使用一个CyclicBarrier使得三个线程保持同步，当三个线程都到达 cyclicBarrier.await();处大家再一起往下运行。

```java
public class CyclicBarrierTest {
    public static void main(String[] args) {
        CyclicBarrier cyclicBarrier = new CyclicBarrier(3);

        for (int i = 0; i < 3; i++) {
            new Thread(()->{
                System.out.println("before");
                try {
                    cyclicBarrier.await();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } catch (BrokenBarrierException e) {
                    e.printStackTrace();
                }
                System.out.println("after");
            }).start();
        }
    }
}    

```