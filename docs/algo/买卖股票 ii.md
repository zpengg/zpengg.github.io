# 122 买卖股票 ii
## 时间
[[2021-01-28]]
## 题目
[NO.122](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/description/)
给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。

设计一个算法来计算你所能获取的最大利润。你可以尽可能地完成更多的交易（多次买卖一支股票）。

注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
## 相关概念
[[动态规划]]
[[系列-买卖股票]]


## 思路
无限次交易

## code
```java
class Solution {
    public int maxProfit(int[] prices) {
        int n = prices.length;
        int empty = 0 , hold = Integer.MIN_VALUE;
        for(int i = 0 ; i < n; i++){
            int temp = empty;
            empty = Math.max(temp, hold + prices[i]);
            hold = Math.max(hold, temp - prices[i]);
        }
        return empty;
    }
}
```

## 坑点

