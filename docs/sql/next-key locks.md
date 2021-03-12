# next-key locks

Next-Key Locks 是 MySQL 的 InnoDB 存储引擎的一种锁实现。


下面 两个组合实现 的 [[锁]]
## Record Locks 锁定记录的索引
Record Locks 锁定一个记录上的索引，而不是记录本身。 如果表没有设置索引，InnoDB 会自动在主键上创建隐藏的聚簇索引，因此 Record Locks 依然可以使用。 ¶ Gap Locks 

## Gap Locks 锁定范围
索引之间的间隙 
锁定左开右闭合区间


## gaplock 降级 record
查询的索引含有**唯一属性** 的时候，Next-Key Lock 会进行优化，将其降级为Record Lock，即仅锁住索引本身，不是范围。