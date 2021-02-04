# 560 和为k的子数组
## 时间
[[2021-01-15]]
## 题目
[NO.560](https://leetcode-cn.com/problems/subarray-sum-equals-k/description/)
给定一个整数数组和一个整数 k，你需要找到该数组中和为 k 的连续的子数组的个数。

示例 1 :

输入:nums = [1,1,1], k = 2
输出: 2 , [1,1] 与 [1,1] 为两种不同的情况。
说明 :

数组的长度为 [1, 20,000]。
数组中元素的范围是 [-1000, 1000] ，且整数 k 的范围是 [-1e7, 1e7]。
## 相关概念
[[前缀和]]
子数组问题

## 思路

## code
```java
class Solution {
    public int subarraySum(int[] nums, int k) {
        int n = nums.length;
        int res = 0;
        Map<Integer, Integer> map = new HashMap<>();
        int sumi = 0;
        map.put(0,1);
        for(int i = 0; i < n; i++){
            sumi += nums[i];
            int key = sumi - k;
            int cnt = map.getOrDefault(key, 0);

            if(cnt!= 0){
                res+= cnt;
            }

            map.put(sumi, map.getOrDefault(sumi,0)+1 );
        }
        return res;
    }
}

```

## 坑点
### 区间和 sum 要先取后设，因为可能有重复的， 不能直接设置为1
