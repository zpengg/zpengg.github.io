# 消费者 Leader 选举
## 选举时间
消费者加入[[消费者组]]无leader要选举，
Leader 离开后也会选举
[[再均衡]] 要选举
## 组协调器 
### 随机选出（成员 HashMap 中 第一个键值对）
[[组协调器]]从 [[元数据]] 直接获取 第一个Hash 键值对 相当于 **随机** 
没有其他成员的时候，第一个入组的即 [[消费者 Leader]]
```scala
private val members = new mutable.HashMap[String, MemberMetadata]
leaderId = members.keys.headOption
```
选完进行[[消费者分区分配策略]]
