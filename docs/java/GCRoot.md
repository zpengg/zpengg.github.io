# GCRoot
## WHAT
JAVA里可作为GC Roots的对象 :
 - 虚拟机栈（栈帧中的本地变量表）中引用的对象 
 - 方法区中的类 静态属性 引用的对象 
 - 方法区中的 常量 引用的对象 
 - 本地方法栈中JNI（即Native方法）的引用的对象 (通过句柄表)

## 准确式GC
- 标记阶段 STW
- [[OopMap]]

## SafePoint
为每一个操作记录OopMap不现实