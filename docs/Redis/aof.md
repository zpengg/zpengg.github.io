# Aof
append only file

## 生成步骤
### 追加到缓冲区末尾
位置: 内存
[[redisServer]] -> aof_buf

### 文件写入
位置：内存缓冲区
事件循环中, 处理完文件事件，时间事件之后, 
serverCron 中调用 flushApendOnlyFile 

### 文件同步
位置：硬盘

#### 配置 appendfsync
 - always 每次 write 后都会调用 fsync（Linux 为调用 fdatasync）。影响性能 请勿设置
 - everysec 超过 1 秒写入 有专门线程 [[bio]]。 默认值。最多丢 1 秒数据
 - no 则 write 后不会有 fsync 调用，由 **操作系统** 自动调度刷磁盘，性能是最好的 与everysec 相近

## 还原步骤
没有网络连接的客户端 读文件执行命令

## AOF文件
### 重写 REWRITE
BGREWRITEAOF

**无须读取旧文件！！！**
为了 减少aof文件空间大小

通过读取当前值，写入体积更少的新文件，保证 最终一致

在**子进程**进行 避免使用锁

#### 旧命令合并
#### 新命令写 AOF 重写缓冲区 
从创建子进程开始，新命令都会另外写入 AOF 重写缓冲区。

#### 重写完成
发信号通知父进程
新文件 合并 重写缓冲区, 原子 覆盖 AOF 旧文件