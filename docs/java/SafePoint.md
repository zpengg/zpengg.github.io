# SafePoint 

## 线程可以安全停顿的位置
这些特定的位置主要在： 
1、循环的末尾 
2、方法临返回前 / 调用方法的call指令后 
3、可能抛异常的位置

## GC
[[OopMap]]
每个被JIT编译过后的方法也会在一些特定的位置记录下OopMap，记录了执行到该方法的某条指令的时候，栈上和寄存器里哪些位置是引用。

这样GC在扫描栈的时候就会查询这些OopMap就知道哪里是引用了。

## SafeRegion 引用关系不会改变的区域
[[SafeRegion]]