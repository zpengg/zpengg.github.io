
# JVMTI
JVMTI (JVM Tool Interface)是Java虚拟机对外提供的Native编程接口，通过JVMTI，外部进程可以获取到运行时JVM的诸多信息，比如线程、GC等

## agent: java让外部访问的代理
使用Java的Instrumentation接口(java.lang.instrument)来编写Agent
### main钩子

### 宿主挂载agent
> IDEA crack 原理

将编写的Agent打成jar包后，就可以挂载到目标JVM上去了。
### 目标启动时 or 运行时
-javaagent:[=]
