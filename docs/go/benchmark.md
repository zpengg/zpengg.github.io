# bench mark
## API
```go
b.StopTimer()
b.StartTimer()
b.ResetTimer()
b.Run(name string, f func(b *B))
b.RunParallel(body func(*PB))
b.ReportAllocs()
b.SetParallelism(p int)
b.SetBytes(n int64)
testing.Benchmark(f func(b *B)) BenchmarkResult
```


## serial & parrel
```go
// 最基本用法，测试dosomething()在达到1秒或超过1秒时，总共执行多少次。b.N的值就是最大次数。
func BenchmarkFoo(b *testing.B) {
  for i:=0; i<b.N; i++ {
    dosomething()
  }
}

'''
goos: darwin
goarch: amd64
pkg: strings
cpu: Intel(R) Core(TM) i9-9880H CPU @ 2.30GHz
BenchmarkIndexRune
BenchmarkIndexRune-16    	69456598	        16.34 ns/op
PASS
'''

//创建P个goroutine之后，再把b.N打散到每个goroutine上执行。所以并行用法就比较适合IO型的测试对象。
func BenchmarkFoo(b *testing.B) {
	b.RunParallel(func(pb *testing.PB) {
		for pb.Next() {
			dosomething()
		}
	})
}
```

## 指定范围内计时

```go
// src code
func (b *B) StartTimer() {
	if !b.timerOn {
		// 记录当前时间为开始时间 和 内存分配情况
		b.timerOn = true
	}
}
func (b *B) StopTimer() {
	if b.timerOn {
		// 累计记录执行的时间（当前时间 - 记录的开始时间）
    // 累计记录内存分配次数和分配字节数
		b.timerOn = false
	}
}
func (b *B) ResetTimer() {
	if b.timerOn {
		// 记录当前时间为开始时间 和 内存分配情况
	}
	// 清空所有的累计变量
}

```

### case
```go
init(); // 初始化工作
b.ResetTimer()
for i:=0; i<b.N; i++ { dosomething1() }
b.StopTimer()
otherWork(); // 例如做一些转换工作
b.StartTimer()
for i:=0; i<b.N; i++ { dosomething2() }
```