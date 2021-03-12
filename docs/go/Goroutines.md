# goroutine
```go
package main

import (
    "fmt"
    "time"
)

func f(from string) {
    for i := 0; i < 3; i++ {
        fmt.Println(from, ":", i)
    }
}

func main() {

    // 不加 go 同步运行
    f("direct")

    // 加 go 并发运行
    go f("goroutine")

    go func(msg string) {
        fmt.Println(msg)
    }("going")

    time.Sleep(time.Second)
    fmt.Println("done")
}

```

Go自己管理不收OS调度的
一般的电脑可以同时开的thread数量大概几千个。而GO语言可以开启的goroutine，却可以达到几百万个

，协程是不切换的，执行完协程A，再执行协程B
协程切换的条件有两个

go是多线程模型，通过环境变量GOMAXPROCS可以控制核心数量

线程的调度是由操作系统负责的，调度算法运行在内核态，而协程的调用是由 Go 语言的运行时负责的，调度算法运行在用户态。



[[运行调度器]]
