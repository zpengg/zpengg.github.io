# work-stealing

当某个线程空闲时，也就是该线程上所有的协程都在休眠（或者一个协程都没有），它就会去其它线程的就绪队列上去偷一些协程来运行。也就是说这些线程会主动找活干，在正常情况下，运行时会尽量平均分配工作任务。