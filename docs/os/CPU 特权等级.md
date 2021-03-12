# CPU 特权等级
[[CPU]]

在计算机科学中, 分级保护域（英语：hierarchical protection domains）,[1][2]，经常被叫作保护环（Protection Rings），又称环型保护（Rings Protection）、CPU环（CPU Rings），

![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/4ac040-1625977708.png)

## 目的
RING设计的初衷是将系统权限与程序分离出来，使之能够让OS更好的管理当前系统资源

## 权限限制对象
限制的是部分指令 

## R0 & R3
内核空间（Ring 0）具有最高权限，可以直接访问所有资源；
用户空间（Ring 3）只能访问受限资源，不能直接访问内存等硬件设备，必须通过系统调用陷入到内核中，才能访问这些特权资源。
而其他驱动程序位于R1、R2层，每一层只能访问本层以及权限更低层的数据。

现在的OS，包括Windows和Linux都没有采用4层权限，而只是使用2层——R0层和R3层

## 系统调用: 特权模式切换

