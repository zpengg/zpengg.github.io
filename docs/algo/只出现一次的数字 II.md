# 137 只出现一次的数字 II
## 时间
[[2021-01-16]]
## 题目
[NO.137](给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现了三次。找出那个只出现了一次的元素。

说明：

你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？

示例 1:

输入: [2,2,3,2]
输出: 3
示例 2:

输入: [0,1,0,1,0,1,99]
输出: 99)
## 相关概念

## 思路
### （3 * set - sum）/2
set 去重 
### 位运算
todo

## code
```java
class Solution {
    public int singleNumber(int[] nums) {
        HashSet<Integer> set = new HashSet();
        long sumnums = 0;
        for (int i : nums){
            set.add(i);
            sumnums+= i; 
        }
        long sum = 0;
        for (int i : set) sum+=i;
        return (int)(( 3* sum  - sumnums)/ 2);

    }
}
```

## 坑点
### int 求和 用long 防止溢出