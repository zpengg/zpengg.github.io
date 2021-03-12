# JWT
## 格式
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ
```

以`.`分割 xxxxx.yyyyy.zzzzz
- 头部（header)
- 载荷（payload)
- 签证（signature)


## HEADER:
{
  "alg": "HS256",
  "typ": "JWT"
}
编码结果 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9 

## PAYLOAD:
{
  "sub": "1234567890",
  "name": "John Doe",
  "iat": 1516239022
}
编码结果 eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9 

## 生成 VERIFY SIGNATURE
JWTs can be signed using a secret (with the HMAC algorithm) 
或者 a public/private key pair using RSA or ECDSA

HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  your-256-bit-secret
) 

secret 可选 base64 encoded 先进行编码

## 非对称加密
减少对授权中心的调用
授权中心用**私钥** 对JWT进行加签
网关 和 微服务 本地用公钥对jwt 进行鉴权 

```
# 校验
if 公钥（ signature ）== base64UrlEncode(header) + "." + base64UrlEncode(payload)
```

## 
Token本身并没有任何加密机制，它依赖于HTTPS的通道保密能力