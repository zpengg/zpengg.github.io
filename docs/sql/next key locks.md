# Next Key Locks
当前读
select * from table where id>3
锁住id=3这条记录以及id>3这个区间范围，锁住索引记录之间的范围，避免范围间插入记录，以避免产生幻影行记录。

##  锁定查询 key 以上的范围