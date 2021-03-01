# MMU

                            +--------+
                            |  MMU   |
+---+  virtual addr         +--------+
|CPU| ----------------->    |  TLB   |
+---+                       | +---+  |
                            |  TWU   |
                            +--------+
- [[TLB]]： 是页表的高速**缓存**，存储着最近转化的一些目录项
- Table Walk Unit：负责从页表中读取虚拟地址对应的物理地址,**转换**

<img src="https://pic1.zhimg.com/50/v2-fe44ad1f24e6963bc8f3c2fc24899c05_hd.jpg?source=1940ef5c" data-caption="" data-size="normal" data-rawwidth="641" data-rawheight="201" data-default-watermark-src="https://pic4.zhimg.com/50/v2-b3cd68fdc6fe9e58e82c5566a53de6b6_hd.jpg?source=1940ef5c" class="origin_image zh-lightbox-thumb" width="641" data-original="https://pic4.zhimg.com/v2-fe44ad1f24e6963bc8f3c2fc24899c05_r.jpg?source=1940ef5c"/>

作者：axiqia
链接：https://www.zhihu.com/question/63375062/answer/1403291487
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。