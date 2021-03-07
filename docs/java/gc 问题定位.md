# 问题定位
[[分析工具]]
## FullGC
 - CPU 占用 100%
 - jstat 发生次数很多，同时次数不断增加；
 - 堆 or 方法区

```bash
# 看进程占用
top 
# 看线程占用
top -H -p <pid>  
# gc 统计 ms 显示 cnt 条
jstat -gcutil <pid> <ms> <cnt>
```