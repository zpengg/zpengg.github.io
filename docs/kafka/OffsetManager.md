# OffsetManager
## 作用
管理 [[消费位移]]
旧版本存zookeeper
新版本存储在 __consumer_offsets 

## __consumer_offsets 存储格式
```
Offset:
key: <group,topic,partition>
value: 
```

## Compact 策略
compact 定期删除存在kafka上的位移
`__consumer_offset` 会定期删除 内存中 `offsetCache`


清理内存 offsetCache 三元组的数据
筛选出不活跃的 key = <group,topic,partition> 三元组，添加 value = null的墓碑记录
将墓碑记录写入日志文件
如果开启了 [[compaction]] 日志合并， 则只会剩下最新的key记录 