# CMS
## CMS 缩短STW 优先
CMS， Concurrent Mark Sweep， compact可选

- 对CPU资源非常敏感。
- 无法处理浮动垃圾，可能出现Concurrent Model Failure失败而导致另一次Full GC的产生。
- 因为采用标记-清除算法所以会存在空间碎片的问题，导致大对象无法分配空间，不得不提前触发一次Full GC。
### 流程
**初始标记**: STW，仅仅只是标记一下 GC Roots 能直接关联到的对象，速度很快。 
**并发标记**: 进行 GC Roots Tracing 的过程，它在整个回收过程中耗时最长，不停顿。
预清理：
可被终止的预清理：
**重新标记**: STW，为了修正并发标记期间因用户程序继续运作而导致标记产生变动的那一部分对象的标记记录。可提前 ygc，减少停顿
并发清除: 不需要停顿。
并发重置状态等待下次CMS的触发(CMS-concurrent-reset)

### concurrent mode failure
老年代清理过程， 放不下晋升新对象

serial old  兜底
CMSScavengeBeforeRemark remark阶段可以申请 YGC

#### 可能原因
1. CMS触发太晚
方案：将-XX:CMSInitiatingOccupancyFraction=N调小；

2. 空间碎片太多
方案：开启空间碎片整理，并将空间碎片整理周期设置在合理范围；

-XX:+UseCMSCompactAtFullCollection （full gc 做 空间碎片整理）
-XX:CMSFullGCsBeforeCompaction=n （10次full gc 做一次压缩）

> 所有带有“FullCollection”字样的VM参数都是跟真正的full GC相关 
3. 垃圾产生速度超过清理速度
 - 存在大对象；
 - 晋升太快
    - 晋升阈值过小；
    - Survivor空间过小；
    - Eden区过小，导致晋升速率提高；