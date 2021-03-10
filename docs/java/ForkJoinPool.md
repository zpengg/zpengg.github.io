# ForJoinPool
java7中新增的线程池类
## 先分后合
最适合的是计算密集型任务

## ManagedBlocker 
告诉将要阻塞

## RecursiveTask 
## 例子: 累加分治
```java
class CountTask extends RecursiveTask<Integer>{
    private static final long serialVersionUID = -7524245439872879478L;

    private static final int THREAD_HOLD = 2;

    private int start;
    private int end;

    public CountTask(int start,int end){
        this.start = start;
        this.end = end;
    }

    @Override
    protected Integer compute() {
        int sum = 0;
        //如果任务足够小就计算
        boolean canCompute = (end - start) <= THREAD_HOLD;
        if(canCompute){
            for(int i=start;i<=end;i++){
                sum += i;
            }
        }else{
            int middle = (start + end) / 2;
            CountTask left = new CountTask(start,middle);
            CountTask right = new CountTask(middle+1,end);
            //执行子任务
            left.fork();
            right.fork();
            //获取子任务结果
            int lResult = left.join();
            int rResult = right.join();
            sum = lResult + rResult;
        }
        return sum;
    }
}
```