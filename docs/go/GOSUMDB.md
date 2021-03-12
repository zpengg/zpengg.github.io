# GOSUMDB

go env -w GOSUMDB="off"



## 常见环境变量

1. GOSUMDB="sum.golang.org"
2. GOPRIVATE="git.company.com"


不得不说，Go 官方对安全问题前所未有的重视，随着 Go module 功能的引入，包依赖的安全问题引起了 Go team 的关注，经过激烈的讨论，最终决定推出一个全球的依赖包 Certificate Transparency log 中心。CT log最初其实是在证书领域被应用的，由于一些CA乱颁发或者由于安全问题被签发了很多有问题的可信证书，最终导致严重的安全问题。CT服务的推出让所有被签发的证书公开透明，很容易就能发现有人恶意签发可信证书，窃取用户加密数据。当然了，现在的 chrome 早就支持了CT。回过头来，为了保证开发者的依赖库不被人恶意劫持篡改，Go team 推出了 Go module checksum database。服务器地址为：sum.golang.org。当你在本地对依赖进行变动（更新/添加）操作时，Go 会自动去这个服务器进行数据校验，保证你下的这个代码库和世界上其他人下的代码库是一样的。如果有问题，会有个大大的安全提示。当然背后的这些操作都已经集成在 Go 里面了，开发者不需要进行额外的操作。


环境变量 GOSUMDB 可以用来配置你使用哪个校验服务器和公钥来做依赖包的校验, 就像下面:

GOSUMDB="gosum.io+ce6e7565+AY5qEHUk/qmHc5btzW45JVoENfazw8LielDsaI+lEbq6"

Go1.13 中当设置了 GOPROXY="https://proxy.golang.org" 时 GOSUMDB 默认指向 "sum.golang.org"，其他情况默认都是关闭的状态。