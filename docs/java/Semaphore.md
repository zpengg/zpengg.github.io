# Semaphore
信号量
## 基本原理
Semaphore初始化的时候需要指定许可的次数，许可的次数是存储在state中；
尝试获取一个许可的时候，则state的值减1；
当state的值为0的时候，则无法再获取许可；
## 许可的个数可以动态改变；


## 应用： 秒杀
```java
   public static boolean seckill() {
        if (!SEMAPHORE.tryAcquire()) {
            System.out.println("no permits, count="+failCount.incrementAndGet());
            return false;
        }

        try {
            // 处理业务逻辑
            Thread.sleep(2000);
            System.out.println("seckill success, count="+successCount.incrementAndGet());
        } catch (InterruptedException e) {
            // todo 处理异常
            e.printStackTrace();
        } finally {
            SEMAPHORE.release();
        }
        return true;
    }
```