# LinkedHashMap
## 双向链表 已经在hashMap 实现
[[HashMap]] 

## accessOrder 两种顺序
accessOrder =false 自然顺序 hashMap本身有维护
accessOrder =true 访问顺序，访问过后要修改顺序

### 钩子函数 处理 accessOrder   
定义了一些钩子
// Callbacks to allow LinkedHashMap post-actions
void afterNodeAccess(Node<K,V> p) { }
void afterNodeInsertion(boolean evict) { }
void afterNodeRemoval(Node<K,V> p) { }

## Entry 增加 双向指针
```java
 static class Entry<K,V> extends HashMap.Node<K,V> {
        Entry<K,V> before, after;
        Entry(int hash, K key, V value, Node<K,V> next) {
            super(hash, key, value, next);
        }
    }
```
