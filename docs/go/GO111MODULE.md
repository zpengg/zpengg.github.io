# GO111MODULE
GO111MODULE 有三个值：
off GO111MODULE=off，go命令行将不会支持module功能，寻找依赖包的方式将会沿用旧版本那种通过vendor目录或者GOPATH模式来查找。 
on GO111MODULE=on，go命令行会使用modules，而一点也不会去GOPATH目录下查找
auto（默认值）GO111MODULE=auto，默认值，go命令行将会根据当前目录来决定是否启用module功能。
 - 当前目录在GOPATH/src之外且该目录包含go.mod文件
 - 当前文件在包含go.mod文件的目录下面

当module功能启用时，GOPATH在项目构建过程中不再担当import的角色，但它仍然存储下载的依赖包，具体位置在$GOPATH/pkg/mod。


go get 下载到 pkg 目录下
