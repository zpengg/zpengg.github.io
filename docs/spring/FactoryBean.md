# FactoryBean
是个 [[Bean]]
一个能生产或者修饰对象生成的工厂Bean

## 源码
```java
public interface FactoryBean<T> {
    T getObject() throws Exception;
    Class<?> getObjectType();
    boolean isSingleton();
}
```
## 代码生成Bean 的逻辑 （区别于xml等配置的模式）
用户可以通过实现该接口定制实例化Bean的逻辑k