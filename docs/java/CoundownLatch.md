# CountDownLatch
[[共享锁]] 倒计数器
## state 初始化，次数不可调整
计数器
count ==0 可以获取锁
count > 0 需要排队
## awiat 阻塞，加共享锁
调用await的线程要排队 
## countdown 修改state
调用countdown ，tryReleaseShared  每次减一
直到state ==0 才释放锁
## 对比 thread.join
Thread.join()是在主线程中调用的，它只能等待被调用的线程结束了才会通知主线程，而CountDownLatch则不同，它的countDown()方法可以在线程执行的任意时刻调用，灵活性更大