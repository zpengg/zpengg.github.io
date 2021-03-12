# main 
在Go语言中, 只有package为main时才能执行main方法
项目根目录下不能 多个 main 函数

```bash
go run: cannot run non-main package
```

```go
package main

import (
	"fmt"
	"math"
)
const s string = "constant"

func main() {
	fmt.Println(s)
	const n = 4000
	const d = 3e20/n
	fmt.Println(int64(d))
	fmt.Println(math.Sin(n))
}

```

## package
[[package]]