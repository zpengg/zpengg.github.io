# ParNew
年轻代 并行 [[垃圾回收器]]
收集线程数默认是 (ncpus <= 8) ? ncpus : 3 + ((ncpus * 5) / 8)
可以通过-XX:ParallelGCThreads= N 来调整； 