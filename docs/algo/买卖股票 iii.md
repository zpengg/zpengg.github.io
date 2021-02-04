# 123 买卖股票 iii
## 时间
[[2021-01-28]]
## 题目
[NO.123](link)
## 相关概念
[[动态规划]]
[[系列-买卖股票]]

买卖 最多两回合 k = 2

## 思路


## code
```java
class Solution {
    public int maxProfit(int[] prices) {
        int n = prices.length;
        int[][][] dp= new int [n+1][3][2];
        for(int i = 0 ; i <=n ; i++){
            if(i ==  0 ){
                for(int k  = 0 ; k<=2; k++){
                    dp[0][k][0] = 0;
                    dp[0][k][1] = Integer.MIN_VALUE;
                }
                continue;
            }
            dp[i][0][0] = 0;
            dp[i][0][1] = Integer.MIN_VALUE;
            for(int k  = 1 ; k<=2; k++){
                dp[i][k][0] = Math.max(dp[i-1][k][0], dp[i-1][k][1] + prices[i-1]);
                dp[i][k][1] = Math.max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[ i-1]);
            }
        }
        int max = Integer.MIN_VALUE;
        for(int k = 0 ; k<=2;k++){
            max = Math.max(dp[n][k][0],max);
        }
        return max;

    }
}

```

## 坑点

