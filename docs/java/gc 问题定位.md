# 问题定位
[[调试原理]]
[[分析工具]]
## 动态扩容
-Xms -Xmx 不一致
Allocation Failure
不断调整堆大下坡和分代大小
> 尽量将成对出现的空间大小配置参数设置成固定
## 显式GC
> old 少 导致直接内存得不到及时释放
要保留显式GC
同时可配为后台并行 ExplicitGCInvokesConcurrent 

## metaspace
jcmd or dump 看 Histogram 那个包的Class增加 较多
加监控 metaspace

## CMS OldGC 频繁
> 定时清除的缓存、连接等

## CMS OldGC 常
> CMS GC 单次 STW 最大超过 1000ms, 不会频繁发生
避免动态类卸载
## CMS 退化
> 晋升失败 or Concurrent Mode Failure
提前ygc 减少晋升

## FullGC
 - CPU 占用 100%
 - jstat 发生次数很多，同时次数不断增加；
 - 堆 or 方法区
### 过早晋升


## 堆外/本地内存
> jni, nio主动申请未释放
添加 -XX:NativeMemoryTracking=detail JVM参数后重启项目 NMT
查看内存分布
```bash
# 看进程占用
top 
# 看线程占用
top -H -p <pid>  
# gc 统计 ms 显示 cnt 条
jstat -gcutil <pid> <ms> <cnt>
```