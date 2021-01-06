# 142 环形链表 ii
## 时间
[[2020-12-29]]
## 题目
[NO.142](link)
给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。

为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。注意，pos 仅仅是用于标识环的情况，并不会作为参数传递到函数中。

说明：不允许修改给定的链表。

进阶：

你是否可以使用 O(1) 空间解决此题？
## 相关概念
[[链表]]
[[双指针]]
## 思路

## code
```java
public class Solution {
    public ListNode detectCycle(ListNode head) {
        ListNode fast,slow;
        fast = slow = head;
        while(fast!= null && fast.next!= null){
            fast = fast.next.next;
            slow = slow.next;
            if(fast == slow) break;
        }
        // 关键 1x速度， 重走一遍
        slow = head;
        while(slow != fast){
            fast = fast.next;
            slow = slow.next;
        }
        return slow;
    }
}

```

## 坑点
### 有环逻辑 快慢指针
```java

 while(fast!= null && fast.next!= null){
            fast = fast.next.next;
            slow = slow.next;
            if(fast == slow) break;
        }
```
### slow = head 重新走至相遇点
