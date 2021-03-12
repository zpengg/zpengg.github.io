# linux
## 性能
[[指标]]
[[CPU]]
## w
[[grep]]
[[sed]]

## 设备 & 运行
[[proc]]目录

- 内存信息
/proc/meminfo
- 硬盘信息\分区表
fdisk -l
- [[top]] cpu
- [[ps]] 进程

## 文件
- [[tail]]
- find

## 网络
ifconfig
iptables 防火墙
route 路由
netstat 端口

## 用户 & 组
w
id
/etc/passwd
/etc/group

## 服务
```bash
# 查看当前用户的计划任务服务
crontab -l 

# 列出所有系统服务
chkconfig –list 

# 列出所有启动的系统服务程序
chkconfig –list | grep on 
```