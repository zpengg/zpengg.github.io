# 643 子数组的最大平均数 I
## 时间
[[2021-02-04]]
## 题目
[NO.643](link)
## 相关概念

[[滑动窗口]]
## 思路
定长窗口 
sum = sum + nums[r+1] - sum[l];

## code
```java
class Solution {
    public double findMaxAverage(int[] nums, int k) {
        int l = 0 , r = k-1;
        
        int sum = 0;
        for(int i = 0 ; i< k; i++){
            sum += nums[i];
        }
        int max = sum;
        while(r<nums.length){
            sum-= nums[l];
            l++;
            r++;
            if( r == nums.length) break;
            sum+= nums[r];
            max = Math.max(sum, max);
        }
        return max * 1.0 / k;
    }
}

```

## 坑点
需要比较出入元素的场景, 用for 可以减少边界判断
```java

for(int i =k ; i<n ; i++){
    // todo
    // nums[r+1] -> nums[i]
    // nums[l] -> nums[i-k]

}
```