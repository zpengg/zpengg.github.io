# RCE
代码调用了bash来执行系统命令并且将用户的输出拼接到命令语句中。


## How
- 使用API
- 避免代码执行命令 （远程执行）
- 执行命令先转义处理
- 白名单 
- 用户输入预处理
- 预期数据格式校验 date mail phone