# zshrc 

```zsh
# mysql
export PATH=/usr/local/mysql/bin:$PATH

# py + virtualenv
export PATH=$PATH:/Users/zhanpeng.ye/Library/Python/2.7/bin
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

# npm
export PATH=~/.npm-global/bin:$PATH

# my sh
export PATH=~/.mysh:$PATH

# antigen
source /usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh
antigen init ~/.antigenrc

# go
# 将以下代码添加到 .zshrc 或者 .bashrc 中。
export PATH=$(brew --prefix go@1.14)/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH
 
# 只支持 go mod 管理包依赖
export GO111MODULE="on"
# 私有库不做verify
export GOPRIVATE="*"

export GONOPROXY="*"
export GONOSUMDB="*"


```
## related
[[antigen]]
[[npm]]
[[virtualenv wrapper]]