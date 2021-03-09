# Phaser

## evenQ & oddQ
队列会根据当前阶段的奇偶性选择不同的队列；任务完成后放入另一个队列
最后一个完成后，会唤醒队列线程，进入下一个阶段
## state
state，状态变量，高32位存储当前阶段phase，中间16位存储参与者的数量，低16位存储未完成参与者的数量
## PARTIES 任务数量可以控制
## 使用
```java
public class PhaserTest {

    // 参与者
    public static final int PARTIES = 3;
    // 步骤数
    public static final int PHASES = 4;

    public static void main(String[] args) {

        Phaser phaser = new Phaser(PARTIES) {
            @Override
            protected boolean onAdvance(int phase, int registeredParties) {
                System.out.println("=======phase: "   phase   " finished=============");
                return super.onAdvance(phase, registeredParties);
            }
        };

        for (int i = 0; i < PARTIES; i  ) {
            new Thread(()->{
                for (int j = 0; j < PHASES; j  ) {
                    System.out.println(String.format("%s: phase: %d", Thread.currentThread().getName(), j));
                    phaser.arriveAndAwaitAdvance(); // 等待进入下一步
                }
            }, "Thread "   i).start();
        }
    }
}

```

