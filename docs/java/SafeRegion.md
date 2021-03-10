# SafeRegion 引用关系不变

如果线程已经停止了，那要怎么到达Safepoint呢？对于这个问题就需要安全区域（Safe Region）解決。
Safe Region指一段代码判断之中，引用关系不会发生变化。在这个区域中发生GC都是安全的。
线程停止都会进入到Safe Region中，
当线程恢复执行，也就是从Safe Region离开时，会先检查系统是否正在GC，是的话会等到GC完成后离开Safe Region。

