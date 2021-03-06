# LogManager
## 步骤
 - 初始化logs
 - 后台定时任务和维护线程

## 初始化logs
checkpoint 文件记录 文件夹下所有文件状态
对应：
 1个log对象
 一组logsegment

初始化 Pool[TopicAndPartition, Log]()对象
## 定时任务

cleanupLogs 删除过期消息
flushDirtyLogs 持久化刷盘
checkpointRecoveryPointOffsets 更新checkpoint文件

## 后台维护线程
[[日志合并]]