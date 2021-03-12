# CPU 数量
## 查看 CPU 数量
```bash
# 1 top
top
# 2 /proc/cpuinfo 
grep 'model name' /proc/cpuinfo | wc -l
```

