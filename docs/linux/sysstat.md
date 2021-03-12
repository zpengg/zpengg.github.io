# sysstat
## vmstat 看总体 虚拟内存 & CPU

```bash
# 每隔5秒输出1组数据
$ vmstat 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 0  0      0 7005360  91564 818900    0    0     0     0   25   33  0  0 100  0  0
```

单位秒

r, running/runnable [[就绪队列]]长度
b, blocked **不可中断**睡眠状态的进程数。
cs, context switch 上下文切换
in, interrupt 中断

## mpstat 看单 CPU
mpstat - Report processors related statistics.
mpstat 是一个常用的多核 CPU 性能分析工具，用来实时查看每个 [[CPU]] 的性能指标，以及所有 CPU 的平均指标。
```bash
# mpstat -P ALL 5 1

06:13:44 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
06:13:49 PM  all    1.00    0.00    1.20    0.00    0.00    0.00    0.00    0.00    0.00   97.79
06:13:49 PM    0    1.00    0.00    1.20    0.00    0.00    0.00    0.00    0.00    0.00   97.79

Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:     all    1.00    0.00    1.20    0.00    0.00    0.00    0.00    0.00    0.00   97.79
Average:       0    1.00    0.00    1.20    0.00    0.00    0.00    0.00    0.00    0.00   97.79

```
## pidstat 看线程

pidstat 是一个常用的进程性能分析工具，用来实时查看[[进程]]的 CPU、内存、I/O 以及上下文切换等性能指标。

```bash

# 每隔5秒输出1组数据
$ pidstat -w 5
Linux 4.15.0 (ubuntu)  09/23/18  _x86_64_  (2 CPU)

08:18:26      UID       PID   cswch/s nvcswch/s  Command
08:18:31        0         1      0.20      0.00  systemd
08:18:31        0         8      5.40      0.00  rcu_sched
...
```
