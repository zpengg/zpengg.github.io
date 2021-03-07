# SATB
Snapshot at the beginning
并发标记阶段，创建对象图，堆快照
适合G1的分区块的堆结构，同时解决了CMS的主要烦恼：重新标记暂停时间长带来的潜在风险

写前栅栏