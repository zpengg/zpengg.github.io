# 188 买卖股票 iv
## 时间
[[2021-01-29]]
## 题目
[NO.188](link)
给定一个整数数组 prices ，它的第 i 个元素 prices[i] 是一支给定的股票在第 i 天的价格。

设计一个算法来计算你所能获取的最大利润。你最多可以完成 k 笔交易。

注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。

 
## 相关概念
[[动态规划]]
[[系列-买卖股票]]

k = k 泛化模版题

## 思路

## code
```java
class Solution {
    public int maxProfit(int k, int[] prices) {
        int n = prices.length;
        int[][][] dp = new int[n + 1][k + 1][2];

        // base i = 0  all k
        for (int j = 0; j < k + 1; j++) {
            dp[0][j][0] = 0;
            dp[0][j][1] = Integer.MIN_VALUE;
        }
        for (int i = 1; i < n + 1; i++) {
            // base k = 0  all i
            dp[i][0][0] = 0;
            dp[i][0][1] = Integer.MIN_VALUE;
            for (int j = 1; j < k + 1; j++) {
                dp[i][j][0] = Math.max(dp[i-1][j][0], dp[i-1][j][1] + prices[i-1]);
                dp[i][j][1] = Math.max(dp[i-1][j][1], dp[i-1][j-1][0] - prices[i-1]);
            }
        }
        int max = Integer.MIN_VALUE;
        // 取各种交易次数中最大
        for (int j = 0; j < k + 1; j++) {
            max = Math.max(dp[n][j][0], max);
        }
        return max;
    }
}

```
## 坑点