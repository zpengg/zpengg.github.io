# happens-before 约束重排
插入内存屏障。 禁止会改变程序结果的[[指令重排]]规则

## 8个规则
 - 程序顺序规则 OP先|后
 - 监视器锁规则 加锁|解锁
 - voatile变量 写|再读
 - 传递性 A|B + B|C = A|B|C = A|C
 - 线程 Start 后才能操作
 - fork|join
 - create|finalize
 - 传递性


