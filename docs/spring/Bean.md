# Bean
[[作用域]]
[[注入]]
## 创建 Bean
追溯到 doCreateBean
 - createBeanInstance， 实例化，实际上就是调用对应的构造方法构造对象，此时只是调用了构造方法
 - populateBean，填充属性，这步property进行populate
 - initializeBean，调用init方法，或者AfterPropertiesSet方法

```java
	protected Object doCreateBean(final String beanName, final RootBeanDefinition mbd, final Object[] args) {

        ...
        //1.实例化bean对象
        instanceWrapper = createBeanInstance(beanName, mbd, args);
        ...
        //1.1为此bean，创建一个ObjectFactory对象添加到singletonFactories中。
        //这里把Bean先缓存了起来
        addSingletonFactory(beanName, () -> getEarlyBeanReference(beanName, mbd, bean));
        
        ...
        //2.装配属性 
        populateBean(beanName, mbd, instanceWrapper);
        
        ...
        //3.初始化bean
        exposedObject = initializeBean(beanName, exposedObject, mbd);
    }
```
## 获取 bean
### ApplicationContext.getBean()
### AbstractBeanFactory.doGetBean 按作用域
其中[[单例]]模式，用到单例注册表
### 三级缓存解决循环依赖
[[三级缓存]]
[[循环依赖]]
## 装配过程
Spring装配Bean的过程

实例化 createBean; 获得一个工厂 ObjectFactory
设置属性值 populateBean;

如果实现了BeanNameAware接口,调用setBeanName设置Bean的ID或者Name;
如果实现 BeanFactoryAware接口,调用setBeanFactory 设置BeanFactory;
如果实现ApplicationContextAware,调用setApplicationContext设置ApplicationContext

调用 [[BeanPostProcessor]] 的预先初始化方法;
调用InitializingBean的afterPropertiesSet()方法;
调用定制init-method方法；
调用BeanPostProcessor的后初始化方法;

## Spring容器关闭过程

调用DisposableBean的destroy();
调用定制的destroy-method方法;

