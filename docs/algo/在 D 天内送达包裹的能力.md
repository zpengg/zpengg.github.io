# 1011 在 D 天内送达包裹的能力
## 时间
[[2021-01-04]]
## 题目
[NO.1011](https://leetcode-cn.com/problems/capacity-to-ship-packages-within-d-days/description/)
传送带上的包裹必须在 D 天内从一个港口运送到另一个港口。

传送带上的第 i 个包裹的重量为 weights[i]。每一天，我们都会按给出重量的顺序往传送带上装载包裹。我们装载的重量不会超过船的最大运载重量。

返回能在 D 天内将传送带上的所有包裹送达的船的最低运载能力。

 1 <= D <= weights.length <= 50000
1 <= weights[i] <= 500
## 相关概念
[[二分查找]]
## 思路
1. 边界 
min>=max(weight);
max<=sum(weight);

[min，max] 之间找到尽可能小的值

## code
```java
class Solution {
    public int shipWithinDays(int[] weights, int D) {
        int left = getMax(weights);//至少能长得下
        int right = getSum(weights);// 一天装完
        while(left<right){
            int mid = left + (right - left)/2;
            if(canFinish(weights, D, mid)){
                right = mid;
            }else{
                left = mid + 1;
            }
        }
        return right;
    }
    boolean canFinish(int[] w, int D, int cap){
        int i =0;
        for(int day = 0; day<D; day++){
            int maxCap = cap;
            while((maxCap-=w[i])>=0){
                i++;
                if(i == w.length)
                    return true;
            }
        }
        return false;
    }

    int getMax(int[] weights){
        int max = 0;
        for(int i: weights){
            max = Math.max(i, max);
        }
        return max;
    }
    int getSum(int[] weights){
        int sum = 0;
        for (int i: weights){
            sum+=i;
        }
        return sum;
    }

}

```

## 坑点
## 相似
[[爱吃香蕉的珂珂]]