# IDOR
Insecure Direct Object References (IDOR) 
直接使用用户提供的输入去访问对象，没有做访问控制

- 水平越权 访问其他用户
- 垂直越权 访问权限更高的用户


## How
- Session 控制
- 利用hash 不可猜测, 比如图片链接等
- 检查用户身份