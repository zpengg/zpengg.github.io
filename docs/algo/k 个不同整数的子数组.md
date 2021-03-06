
# 992 k 个不同整数的子数组
## 时间
[[2021-02-09]]
## 题目
[NO.992](https://leetcode-cn.com/problems/subarrays-with-k-different-integers/solution/cong-zui-jian-dan-de-wen-ti-yi-bu-bu-tuo-7f4v/)
## 相关概念
[[数组]]
[[滑动窗口]]

## 思路
### 子数组个数 与 数组长度 关系
子数组 arr, subArr = n
增加一位 数字 
子数组个数 增加 subArr += n+1;

### 恰好 K = 最多 K - 最多 k-1
放宽子数组的定义 

### 滑动窗口
每次移动r, 并调整l.此时合法窗口[l, r] 满足最多 K 位数字。
净增加子数组（即以r结尾的子数组）r-l+1;

累加可求的 总数

### 差分
恰好 K = 最多 K - 最多 k-1



## code
```java
class Solution {
    int atMost(int[] A, int K){
        int n = A.length;
        int r = 0, l =0; 
        HashMap<Integer,Integer> window = new HashMap();
        int cnt = 0;
        while(r<n){
            int rI = A[r];
            r++;
            window.put(rI, window.getOrDefault(rI, 0)+1);

            while(l<r && window.size() > K){
                int lI = A[l];
                int lICnt = window.get(lI);
                if(lICnt ==  1){
                    window.remove(lI);
                }else{
                    window.put(lI, lICnt -1);
                }
                l++;
            }
            // 增加 以 r 结尾的 子数组
            cnt += r-l+1;
        }
        return cnt;
    }
    public int subarraysWithKDistinct(int[] A, int K) {
        // 最多K问题 差分 求 恰好 K
        return atMost(A, K) - atMost(A, K-1);
    }
}

```
## 坑点