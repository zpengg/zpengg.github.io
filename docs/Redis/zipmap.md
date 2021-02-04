# ZipMap

## 历史 & 背景
zipmap利用字符串实现了一个简单的hash_table结构，又通过固定的字节表示节省空间
2.6 版本前的hash 编码方式之一 后使用情形比ziplist 取代

[[ziplist]]

## 结构
<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/d72ad7fa106d306baf1e7e48d43fe56d.png"/> </div>


```
<zmlen><len>"foo"<len><free>"bar"<len>"hello"<len><free>"world"
```

## 特点 len 254 需要遍历
zipmap中的数量如果超过254的时候需要遍历才能得到key-value对的个数。

### 配置
配置域字段最大个数限制
hash-max-zipmap-entries 512

配置字段值最大字节限制
hash-max-zipmap-value 64

