# 01 Trie树
## 01 Trie树
```java
    int[][] son;
//返回此时trie树中的数字里，与a异或最大的数字
    private int query(int a){
        int p = 0, res = 0;
        // 非负整数 i=30
        for(int i = 30; i >= 0; i--){
            int u = a >> i & 1;//最高位，次高位，...
            if(son[p][u ^ 1] != 0){//如果可以走，u是1，就往0走，u是0，就往1走
                res = res * 2 + u ^ 1;
                p = son[p][u ^ 1];
            }else{
                res = res *2 + u;
                p = son[p][u];
            }
        }
        return res;
    }
    //在trie树中插入数字a
    private void insert(int a){
        int p = 0;
        for(int i = 30; i >= 0; i--){
            int u = a >> i & 1;
            if(son[p][u] == 0){
                son[p][u] = ++idx;
            }
            p = son[p][u];
        }
    }

作者：deena
链接：https://leetcode-cn.com/problems/maximum-xor-with-an-element-from-array/solution/java-triezi-dian-shu-chi-xian-si-xiang-b-p25y/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

```

