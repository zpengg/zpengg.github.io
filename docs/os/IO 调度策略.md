# IO调度
NOOP： FIFO
CFQ completly fair queuing： IO请求地址排序，默认的磁盘调度算法，减少寻道
DEADLINE： 优化极端CFQ 饿死情况，最大等待时间
ANTICIPATORY： 连续IO deadline基础上相邻的优先 随机读写变顺序读写
