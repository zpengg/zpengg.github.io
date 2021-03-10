# BeanPostProcessor
BeanPostProcessor 来拦截bean的创建，并在bean初始化前后，添加相应的操作。
连接Spring [[IOC]]和[[AOP]]的桥梁

对象创建后处理器
## ApplicationContext.registerBeanPostProcessors
### BBP对象，必须在普通对象创建之前被创建。
https://cloud.tencent.com/developer/news/247109

## BeanPostProcessors的作用
BeanPostProcessor是spring提供的一个扩展点（钩子函数），通过BeanPostProcessor扩展点，我们可以对Spring管理的bean进行再加工。比如：修改bean的属性(@ConfigurationProperties注解的原理)、生成一个动态代理（事物）等。

[BeanPostProcessor](https://5b0988e595225.cdn.sohucs.com/images/20180620/72943a141d504272978a8d543b8a6327.jpeg)

与AOP有关 下文提及。
## 应用 
[[AOP]]