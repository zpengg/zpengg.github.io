# DSN
gorm库使用dsn作为连接数据库的参数，dsn翻译过来就叫数据源名称，用来描述数据库连接信息。一般都包含数据库连接地址，账号，密码之类的信息。

## DSN格式：
```
[username[:password]@][protocol[(address)]]/dbname[?param1=value1&...&paramN=valueN]

```
