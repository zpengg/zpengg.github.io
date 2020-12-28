# Trie树
一次建树，多次查询
## TrieNode 定义
```java
class TrieNode {
    // 可能出现的字母
    private TrieNode[] links;

    // 可能出现的字母数量
    private final int R = 26;

    // 是不是单词结尾
    private boolean isEnd;

    public TrieNode() {
        links = new TrieNode[R];
    }

    public boolean containsKey(char ch) {
        return get(ch) != null;
    }
    public TrieNode get(char ch) {
        return links[ch -'a'];
    }
    public void put(char ch, TrieNode node) {
        links[ch -'a'] = node;
    }
    public void setEnd() {
        isEnd = true;
    }
    public boolean isEnd() {
        return isEnd;
    }


```
## 接口
```java
class Trie {

    public Trie() {
        root = new TrieNode();
    }

    /** 向 Trie 树中插入键 */
 public void insert(String word) {
        TrieNode node = root;
        for (int i = 0; i < word.length(); i++) {
            char currentChar = word.charAt(i);
            if (!node.containsKey(currentChar)) {
                node.put(currentChar, new TrieNode());
            }
            node = node.get(currentChar);
        }
        node.setEnd();
    }

    
    /** 在 Trie 树中查找键 */
    public boolean search(String word) {
       TrieNode node = searchPrefix(word);
       return node != null && node.isEnd();
    }

    
    /** 搜索前缀 */
    public boolean startsWith(String prefix) {
        TrieNode node = searchPrefix(prefix);
        return node != null;
    }

    private TrieNode searchPrefix(String word) {
        TrieNode node = root;
        for (int i = 0; i < word.length(); i++) {
           char curLetter = word.charAt(i);
           if (node.containsKey(curLetter)) {
               node = node.get(curLetter);
           } else {
               return null;
           }
        }
        return node;
    }
}
```

## 实现

## 复杂度
### 单次插入
时间复杂度：O(m)，其中 m 为键长。查找or插入该单次

空间复杂度：O(m)。最坏的情况下，新插入的键和 Trie 树中已有的键**没有公共前缀**。此时需要添加 m 个结点，使用 O(m) 空间。

### 查找
时间复杂度 : O(m)。算法的每一步均搜索下一个键字符。最坏的情况下需要 m 次操作。
空间复杂度 : O(1)。
## 参考
[LC 实现 Trie (前缀树)](https://leetcode-cn.com/problems/implement-trie-prefix-tree/solution/shi-xian-trie-qian-zhui-shu-by-leetcode/)

[](https://leetcode-solution.cn/solutionDetail?url=https%3A%2F%2Fapi.github.com%2Frepos%2Fazl397985856%2Fleetcode%2Fcontents%2Fthinkings%2Ftrie.md)
## 扩展
[[01 trie树]]