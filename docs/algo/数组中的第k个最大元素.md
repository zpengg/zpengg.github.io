# 数组中的第K个最大元素
# 215 数组中的第k个最大元素
## 时间
[[2021-01-15]]
## 题目
[NO.215](https://leetcode-cn.com/problems/kth-largest-element-in-an-array/description/)
## 相关概念
[[二叉堆]]
小顶堆/优先队列
[[快速选择]]

## 思路
topk 经典问题，
两种方法
## 堆
时间O(nlogk)
空间O(k)
## 快速选择
线性复杂度O(n) 线性 ！！！
空间复杂度O(logn) 栈

## code
### 优先队列
```java
class Solution {
    public int findKthLargest(int[] nums, int k) {
        PriorityQueue<Integer> q = new PriorityQueue<>();
        for(int i: nums){
            if(q.size()==k){
                int in = Math.max(q.poll(),i);
                q.offer(in);
            }else{
                q.offer(i);
            }
        }
        return q.peek();
    }
}
```
### 快速选择
```java
class Solution {
    Random random = new Random();
    public int findKthLargest(int[] nums, int k) {
        int n = nums.length;
        return quickSelect(nums, 0, n-1, n-k);
    }
    public int quickSelect(int[] a, int l, int r, int index){
        System.out.println(l+" "+r+ " " + index);
        int q = randomPartition( a,  l,  r);
        if(q == index){
            return a[q];
        }else{
            return q < index? quickSelect(a, q + 1,r, index):quickSelect(a, l, q-1, index);
        }
    }
    public int randomPartition(int[] a, int l, int r){
        int i = random.nextInt(r-l+1) + l;
        swap(a, i, r);
        return partition(a,l, r);
    }
    public int partition(int[] a, int l, int r){
        int x = a[r], i = l;
        for (int j = l; j<r; j++){
             if(a[j]<=x){
                 swap(a,i,j);
                 i++;
             }
        }
        swap(a, i, r);
        return i;
    }
    public void swap(int[] a, int i , int j){
        int temp = a[i];
        a[i] = a [j];
        a[j] = temp;
    }
}

```
## 坑点



