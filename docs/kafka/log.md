# log 文件
dir: <topic>-<partition>
每个文件夹里有多个logsegment, 一个logsegment里面有多个文件（后缀不同） 


## 日志读取过程
日志文件 描述的是一组物理文件
logsegment 一定范围内 索引和数据 文件

```
log --跳表--> logsegment --> .index 

.index with pos --二分查找<pos, offset> --> .log whth offset
```


## Logsegment
指一组文件，根据第一条消息 baseOffset 来命名, 固定 20 位数字
在内存中使用**跳表**存储 
```
.log 日志文件
.index offset index
.timeindex timestamp index
```
[[日志索引]]

## 几个关键offset
### recover point
已經flush到磁盤 recovery-point-offset-checkpoint 的偏移量
```
           HW
            |
            |uncommited
|msg|msg|msg|msg|msg|
        |unflushed  |
        |          LEO 
recover point 
```
### log start offset
```
lso
|
|0|1|2|...

```
### LEO
log end offset
当前文件写入位置
```
        leo
        |
|0|1|2|   |

```

### HW
High watermark
消费者可读位置，
消费者看到的是leader副本的HW，但描述的是ISR副本集合的HW

HW = ISR中最小的LEO

```
       hw（min leo）
       |
|0|1|2| |

|0|1|2|3| |
         |
       other leo
```

### LW
低水位
AR 最小 logstartOffset
LW增长时刻
 - 日志拉取导致 新建日志分段
 - 删除消息请求

[[消息格式]]