# intset
数量<512, 全是整数时 set 的实现方式


## 定义
```c++
typedef struct intset {
    uint32_t encoding;
    uint32_t length;
    int8_t contents[];
} intset;
```

## 分类
按整数值分类

int16_t
int32_t
int64_t

## 特点
### 不重复
### 升序
### 加入过大整数时， 升级
出现长 一点的整数 会整个set的整数类型 升级, **保持类型一致**
从尾部元素开始复制到新空间对应位置
同时增加一个元素的空间
### 不降级