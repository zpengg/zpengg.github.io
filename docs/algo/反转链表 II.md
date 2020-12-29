#  206 反转链表 II
## 时间
[[2020-12-29]]
## 题目
[NO.206](https://leetcode-cn.com/problems/reverse-linked-list-ii/solution/fan-zhuan-lian-biao-ii-by-leetcode/)
## 相关概念
[[链表]]
## 思路
## 递归
找到位置后 只交换值
## 迭代 

## code
```java
 public ListNode reverseBetween(ListNode head, int m, int n) {
        ListNode blank = new ListNode();
        blank.next = head;
        ListNode forward =blank;
        ListNode prev =blank;
        for (int i = 0; i<m-1; i++){
            prev = prev.next;
            forward = forward.next;
        }
        ListNode curr = prev.next ;
        ListNode rangeTail = curr;
        ListNode last = null;
        for (int i = m; i<=n; i++){
            ListNode next = curr.next;
            curr.next = last;
            last = curr;
            curr = next;
        }
        prev.next = last;
        rangeTail.next = curr;
        return blank.next;
    }

```
## 坑点
### 计算循环终点 使用while 倒计n,m
直接用for 计算边界容易出错