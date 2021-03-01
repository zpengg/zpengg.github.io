# IO多路复用
1 个线程就可以管理多个socket，只有当socket真正有读写事件发生才会占用资源来进

## 内核态
轮询在内核态进行

## 分类
select 轮询
poll
epoll 事件通知 异步