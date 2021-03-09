# AQS

## 同步器状态
[[waitStatus]]

### 条件锁
[[Condition]]

### tryAquire 前置的获取锁方法，如插队
tryAquire 看同步器功能，子类实现
非公平锁 [[nonfairsync]]
公平锁 [[fairSync]]

## addWaiter 快速入队
[[aqs 快速入队]]

### 共享 / 互斥
aquireShare vs. aquire/acquireQueued
[[aqs 共享锁]] 
[[aqs 互斥锁]]


## 采用 unsafe
[[unsafe]] 来修改字段 head tail state
