# BKDRHash
https://blog.csdn.net/wanglx_/article/details/40400693

为了减少碰撞，应该使该字符串中每个字符都参与哈希值计算，使其符合雪崩效应
SUM(ahijklmn)= 2^35*a + 2^30*h + 2^25*I + 2^20*j + 2^15*k + 2^10*l + 2^5*m + 2^0*n
需要抛弃最高位，也就是对0x100000000(也就是2^33)取余，根据同余定理：
只剩下低位，最后面的字付串。

而只要计算就可能会溢出，CPU对于溢出的处理是抛弃最高位，比如两个unsigned int 的值相加结果为33位，那么最高位33位就会被抛弃
SUM(bc)= 系数^1 * b + 系数^0 * c 系数要取奇树

大多源码使用的都是特殊的奇数2^n-1，那是因为在CPU的运算中移位和减法比较快.

``` 关键代码
while (*str)
	{
		hash = hash * seed + (*str++);
	}
``` BKDRHash
