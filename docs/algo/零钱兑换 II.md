# 518 零钱兑换 II
## 题目
[NO.518](https://leetcode-cn.com/problems/coin-change-2/)

给定不同面额的硬币和一个总金额。写出函数来计算可以凑成总金额的硬币组合数。假设每一种面额的硬币有无限个。 

示例 1:

输入：amount = 5, coins = [1, 2, 5]
输出：4
解释：有四种方式可以凑成总金额：
5=5
5=2+2+1
5=2+1+1+1
5=1+1+1+1+1
```java
class Solution {
    public int change(int amount, int[] coins) {
    
}
```
## 相关概念
### 回顾
[[零钱兑换]] 求最少硬币数，这题求组合数

## 思路
1. 目标：方法数/组合数

2. `dp[i][j]`： nums 取前 `i` 个数字和为`j`的方法数
注意坐标：第`i`行时 新加入的数字为`nums[i-1]`
i 范围 [0~nums.length+1]
j 范围 [0~amount+1] 

3. base
```java
dp[0][j] = 1;
dp[i][0] = 0;
```
4. 转移逻辑
```java
dp[i][j]= SUM(dp[i-1][j-k*nums[i-1]]);
```
5. 最后返回
```java
dp[nums.length][amount]
```
## code
```java
class Solution {
    public int change(int amount, int[] coins) {
        int len = coins.length;
        int[][] dp = new int[len+1][amount+1];
        for (int i = 0; i<=len; i++ ){
            // amount == 0 全不取
            dp[i][0] = 1;
        }
        for (int i = 1; i<=len; i++){
            for(int j=1; j<=amount; j++){
                int sum =0;
                int kmax = j/coins[i-1];
                for(int k=kmax; k>=0; k--){
                    sum += dp[i-1][j-k*coins[i-1]];
                }
                dp[i][j]=sum;
            }
        }
        return dp[len][amount];
    }
}

```
## 坑点
base：amount == 0 时 什么都不取就是一种方法
坐标：第 i 行时 新加入的数字为 nums[i-1]