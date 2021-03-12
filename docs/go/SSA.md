# SSA

静态单赋值（Static Single Assignment、SSA）是[[中间代码]]的特性，
每个变量就只会被赋值一次。

## 例子
```go
x := 1
x := 2
y := x

// 对代码进行优化后的结果
x_1 := 1 // 可省略
x_2 := 2
y_1 := x_2
```

