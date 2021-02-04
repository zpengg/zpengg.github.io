# 380 常数时间插入、删除和获取随机元素
## 时间
[[2021-01-05]]
## 题目
[NO.380](https://leetcode-cn.com/problems/insert-delete-getrandom-o1/solution/chang-shu-shi-jian-cha-ru-shan-chu-he-huo-qu-sui-j/)
## 相关概念
空间换时间

## 思路
HashMap + ArrayList
map 映射 val->idx, O（1）快速删除
### 难点删除 ，移动末尾到删除位置。避免数组copy


## code
```java
  Random r = new Random();
    List<Integer> list;
    Map<Integer, Integer> map;
    /** Initialize your data structure here. */
    public RandomizedSet() {
        map = new HashMap();
        list = new ArrayList();
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    public boolean insert(int val) {
        if(map.containsKey(val))
            return false;
        int idx = list.size();
        list.add(val);
        map.put(val, idx);
        return true;
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    public boolean remove(int val) {
        if(!map.containsKey(val))
            return false;
        int idx = map.get(val);
        int lastIdx = list.size()-1;
        int rp = list.get(lastIdx);
        list.set(idx, rp);
        map.put(rp, idx);
        map.remove(val);
        list.remove(lastIdx);

        return true;
    }
    
    /** Get a random element from the set. */
    public int getRandom() {
        return list.get(r.nextInt(list.size()));
    }

```

## 坑点

## 扩展 
### 允许重复元素
LT 381

`Map<Integer, Integer> map`改成`Map<Integer, Set<Integer>>`