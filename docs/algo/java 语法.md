# 刷题易错 Java 语法
## char  转 int
`int i = ch - '0';`
## String 转 Integer
`Integer.parseInt(str);`
## String 转 char 操作时 避免转成int
```java
    char c = '0';
    System.out.println(c);//0
    System.out.println(c -1);//47 转换成int 再转string了
    c+=1;
    System.out.println(c);//1
```
[[打开转盘锁]]

## 随机数
```java
Random r = new Random();
r.nextInt(n);
// return [0,n)
```
## Integer 相等
-128到127有缓存 可以用==
对比Integer，保守点用equals
map等容器中取出来做对比常用

## 千分位
int hi = 1_000_000_000;
增加分隔，好看点

## 指数 
Math.pow(a,b); // a^b
double i = 1e9; // 10^9
int i = 1e9; // 编译错误: java: 不兼容的类型: 从double转换到int可能会有损失
int i =(int) 1e9; //没有问题 10^9
## 二分
int mid = l + (r-l >>>1);

## 长度
字符串 length()
数组 length
容器 size（）

## compartor
(o1 - o2)>0, o1 < o2
据第一个参数小于、等于或大于第二个参数分别返回负整数、零或正整数
## 排序
传入的是 less Comparator less时返回true
升序： Arrays.sort(pair, (o1, o2) ->(o1 - o2));

记忆：
参数顺序升序 (o1, o2) ->(o1 - o2)
参数逆序降序 (o1, o2) ->(o2 - o1)
默认升序（无比较器）
## 循环
### break 多层循环
```java
 search: 
for(sr = 0; sr < R; sr++)
    for( sc = 0; sc<C; sc++)
        if(board[sr][sc]==0)
            break search;
```
## 数组
### 二维数组
#### 初始化
```java
// new
int[][] mtx= new int[][]{ {1,2,3}, {4,5,6} }
// 不new 也可以
int[][] directions = {
    {0,-1}, 
    {0,1}, 
    {-1,0}, 
    {1,0}
};

```
#### List<Integer> -> int
```java
int[] intArray = arrayList.stream().mapToInt(Integer::intValue).toArray();
```

#### 打印数组
`Arrays.deepToString(int[][])`

Collections.
## 容器
### Stack.empty; deque.isEmpty;
### hashMap 记录计数
用 Integer.equals 或转换类型get(x).intValue

### 队列
offer: return boolean
add:  return boolean but throws unchecked exception when FULL

// 移除并获取 [计票]
poll: return null when empty
remove: throws NoSuchElementException when empty

// 仅获取 不移除 [看一眼]
peek: Retrieves, but does not remove 
element：throws NoSuchElementException when empty

### 双端队列 
除了queue还有对应的双端接口xxlast,xxfirst
element 对应 getFirst,getLast