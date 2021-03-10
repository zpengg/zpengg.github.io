# major.minor 限制
[[java7]]
[[java8]]
[[javap]]
## 如何查看
### 解压
通过解压导致报错的jar包
jar -xvf xxx.jar
### jdk
首先可以看看
vim META-INF/MANIFEST.MF 

里面可查看 打包该jar 时使用的jdk版本
![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/de5d190c3eacece07cbbb8395821c315.png)
划红线的是上传该包的队友

### class 版本
查看里面的class文件
javap xxxx.class
![](http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/760170b67fd09b93b374eca6184b8eaf.png)
可以查看到 文件中

minor version:0
major version:51

51 对应的是 7
52 是8


## 结论
### 高版本jdk 可打低版本包，但仍可能有bug