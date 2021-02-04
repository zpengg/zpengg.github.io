# 1140 石子游戏 II
## 时间
[[2021-01-22]]
## 题目
[NO.1140](https://leetcode-cn.com/problems/stone-game-ii/description/)
亚历克斯和李继续他们的石子游戏。许多堆石子 排成一行，每堆都有正整数颗石子 piles[i]。游戏以谁手中的石子最多来决出胜负。

亚历克斯和李轮流进行，亚历克斯先开始。最初，M = 1。

在每个玩家的回合中，该玩家可以拿走剩下的 前 X 堆的所有石子，其中 1 <= X <= 2M。然后，令 M = max(M, X)。

游戏一直持续到所有石子都被拿走。

假设亚历克斯和李都发挥出最佳水平，返回亚历克斯可以得到的最大数量的石头。

输入：piles = [2,7,9,4,4]
输出：10
解释：
如果亚历克斯在开始时拿走一堆石子，李拿走两堆，接着亚历克斯也拿走两堆。在这种情况下，亚历克斯可以拿到 2 + 4 + 4 = 10 颗石子。 
如果亚历克斯在开始时拿走两堆石子，那么李就可以拿走剩下全部三堆石子。在这种情况下，亚历克斯可以拿到 2 + 7 = 9 颗石子。
所以我们返回更大的 10。 

## 相关概念


## 思路
1. base: M足够大时 先手一次性取完
2. 循环方向 倒过来
3. dp[i][j]: M = i 时， 第j堆 开始可以取走。
4. 状态转换 & 选择:
```
1. 比较少，可以全拿

len > i + 2 * j :
    dp[i][j] = sumToEnd[j-1];

2. 不能全取的情况下,拿 x 块能让对方尽可能拿的少(但对方依然会是最优策略）

当前剩余：sumToEnd[j - 1]
当前 M= i, 先手拿X： 1 <= x <= 2 * i
对方下一轮 M值: nextM = Math.max(i, x);
对方下一轮 堆开始位置: nextJ = j+x;
对方下一轮最多可以拿： dp[nextM][nextJ];
我这轮最多可以拿的总数：x + (剔除对手最优情况下拿掉一些, 可能还剩的一些）
但直接算不好算，但剩下的数量是固定的， 减掉对手最佳状态，即可得到状态转移关系

我这轮最多可以拿的总数：
foreach x:
    dp[i][j] = Max( sumToEnd[j - 1] - dp[Math.max(i,x)][j+x]) );

完整：
len < i + 2 * j :
    foreach x : 
        dp[i][j] = Math.max(dp[i][j], sumToEnd[j - 1] - dp[Math.max(i,x)][j+x]);

```
5. 终点状态 dp[1][1]

## code
```java
class Solution {
    public int stoneGameII(int[] piles) {
        int n = piles.length;
        int[][] dp = new int[n+1][n+1];
        int[] sumToEnd = new int[n];
        int prev = 0;
        for(int i =n - 1 ;  i>=0;  i--){
            sumToEnd[i] = prev + piles[i];
            prev = sumToEnd[i];
        }
        // 第i轮 每次可以拿 [1 : 2*i] 个
        for(int i =(n+1)/2 ; i >0 ; i --){
            // 从第j堆开始拿
            for(int j = n ; j>0; j--){
                // 剩下的全部要了
                if( j+2*i > n){
                    dp[i][j] = sumToEnd[j-1];
                } else {
                    for(int x = 1; x <= 2*i; x++){
                        dp[i][j] = Math.max(dp[i][j], sumToEnd[j - 1] - dp[Math.max(i,x)][j+x]);
                    }
                }

            }
        }
        return dp[1][1];
    }
}

```

## 坑点
### M 的转移
### 状态转移用减法
