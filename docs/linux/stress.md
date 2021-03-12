# stress
stress 是一个 Linux 系统压力测试工具，这里我们用作异常进程模拟平均负载升高的场景。

stress -u 占用CPU
stress -i io
stress -c 并发


stress 基于多进程的，会fork多个进程，导致进程上下文切换，导致us开销很高；
stress 进程执行的计算是sqrt函数（库函数，所以usr cpu高）


## see also

[[sysbench]]