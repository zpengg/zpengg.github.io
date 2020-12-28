# BFS

```java

    // offer root 
    Queue<TreeNode> q = new LinkedList<>();
    q.offer(root);

    while (!q.isEmpty()) {
        TreeNode cur = q.poll();
        /* 层级遍历代码位置 */
        if (cur == null) {
            // todo: end
            continue;
        }
        // todo: par
        /*****************/
        // template handle son
        q.offer(cur.left);
        q.offer(cur.right);
    }
```