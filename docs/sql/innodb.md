# InnoDB
## page

Page是整个InnoDB存储的最基本构件，也是InnoDB磁盘管理的最小单位，与数据库相关的所有内容都存储在这种Page结构里。Page分为几种类型，常见的页类型有数据页（B-tree Node）Undo页（Undo Log Page）系统页（System Page） 事务数据页（Transaction System Page）等。单个Page的大小是16K（编译宏UNIV_PAGE_SIZE控制），每个Page使用一个32位的int值来唯一标识，这也正好对应InnoDB最大64TB的存储容量（16Kib * 2^32 = 64Tib）。一个Page的基本结构如下图所示：


![page结构](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/1612926888b464ff.png)
![page头部](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/16129269953f7ff5.png)


最初数据是按照插入的先后顺序排列的，但是随着新数据的插入和旧数据的删除，数据物理顺序会变得混乱，但他们依然保持着逻辑上的先后顺序。

## 特性
事务型

行锁

外键: InnoDB 支持外键。

备份: InnoDB 支持在线热备份。

崩溃恢复: MyISAM 崩溃后发生损坏的概率比 InnoDB 高很多，而且恢复的速度也更慢。