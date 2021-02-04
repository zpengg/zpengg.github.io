# DFS
## 二叉树 DFS 模版
```java
void traverse(TreeNode root) {
    // !! common search end
    if (root == null) return;

    // todo: preorder
    traverse(root.left);
    //  todo: inorder
    traverse(root.right);
    // todo: postorder
}

```
### 二叉树 DFS 三种顺序
```java
void traverse(TreeNode root) {
    // todo: 前序遍历
    traverse(root.left)
    // todo: 中序遍历
    traverse(root.right)
    // todo: 后序遍历
}
```

 - [[前序遍历]]
 - [[中序遍历]]
 - [[后序遍历]]

![preOrder](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/01ef97b746f00de07af173f14c25a382.png)
FBADCEGIH

![inOrder](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/60d100fa13aba49d28f9548fd26bb5d5.png)
BACDEFGHI

![postOrder](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/1c79c39a1566d5f7d66222c34d981baf.png)
ABCDEFGHI

### 中序遍历不唯一

## 问题类型
### 排列 permutation
[[全排列]]
[[戳气球]]
### 组合 combination
[[组合]]
[[括号生成]]
### 子集 subset
[[子集]]