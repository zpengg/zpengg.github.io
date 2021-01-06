# 下一个更大的元素 I
# 496 下一个更大的元素 i
## 时间
[[2021-01-06]]
## 题目
[NO.496](https://leetcode-cn.com/problems/next-greater-element-i/)
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

