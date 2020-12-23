# 45 跳跃游戏 II
## 时间
[[2020-12-21]]
## 题目
[NO.45](https://leetcode-cn.com/problems/jump-game-ii)
给定一个非负整数数组，你最初位于数组的第一个位置。

数组中的每个元素代表你在该位置可以跳跃的最大长度。

你的目标是使用最少的跳跃次数到达数组的最后一个位置。

示例:

输入: [2,3,1,1,4]
输出: 2
解释: 跳到最后一个位置的最小跳跃数是 2。
     从下标为 0 跳到下标为 1 的位置，跳 1 步，然后跳 3 步到达数组的最后一个位置。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/jump-game-ii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
## 相关概念
[[贪心算法]]
## 思路
i：当前位置
end：当前位置最远选项
选择: j = [1~end];
far: 在一趟选择中找到中，最远的可跳位置
贪心选择：遍历完一躺 跳最远的， 并计数 
```java
if end==i：//该下躺了
    条数+
    end = far
    // 下一跳新区间 [i+1~end] 看下一跳的可跳范围
```

## code
```java
class Solution {
    public int jump(int[] nums) {
        int n = nums.length;
        int end = 0;
        int far = 0;
        int jump = 0;
        for(int i =0; i<n-1; i++){
            far = Math.max(nums[i]+ i, far);
            if(end == i){
                jump++;
                end = far;
            }
        }
        return jump ;
    }
}


```



## 坑点