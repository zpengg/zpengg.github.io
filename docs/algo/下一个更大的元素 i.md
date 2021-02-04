# 496 下一个更大的元素 i
## 时间
[[2021-01-06]]
## 题目
[NO.496](https://leetcode-cn.com/problems/next-greater-element-i/)

给定两个 没有重复元素 的数组 nums1 和 nums2 ，其中nums1 是 nums2 的子集。找到 nums1 中每个元素在 nums2 中的下一个比其大的值。

nums1 中数字 x 的下一个更大元素是指 x 在 nums2 中对应位置的右边的第一个比 x 大的元素。如果不存在，对应位置输出 -1 。
nums1和nums2中所有元素是唯一的。
nums1和nums2 的数组大小都不超过1000。
## 相关概念
[[单调栈]]

## 思路
1. 单调栈模版
2. 记录弹出元素映射当前覆盖元素(第一个大的X）
## code

```java
class Solution {
    public int[] nextGreaterElement(int[] findNums, int[] nums) {
        Stack<Integer> stack = new Stack<>();
        HashMap<Integer, Integer> map = new HashMap();
        int[] res = new int[findNums.length];
        for(int i = 0; i<nums.length; i ++){
            while(!stack.empty() && nums[i] > stack.peek())
                map.put(stack.pop(), nums[i]);
            stack.push(nums[i]);
        }
        while(!stack.empty()){
            map.put(stack.pop(),-1);
        }

        for (int i  = 0; i<findNums.length; i ++){
            res[i] = map.get(findNums[i]);
        }
        return res;
    }
}

```
## 坑点

