# Spring 知识点

标签（空格分隔）： Spring Java框架 

---

[TOC]

常用启动方法，入口：

```java
public static void main(String[] args) {
    ApplicationContext context = new ClassPathXmlApplicationContext("classpath:applicationfile.xml");
}
```

## IOC 
> ioc是目的，di是手段。ioc是指让生成类的方式由传统方式（new）反过来，既程序员不调用new,需要类的时候由框架注入（di），是同一件不同层面的解读。

ResourceLoader
BeanFactory

ApplicationContext 继承于这两个

## bean 作用域
作用域包括
 - singleton（单例模式） 默认
 - prototype（原型模式）
 - request（HTTP请求）
 - session（会话）
 - global-session（全局会话）

https://www.cnblogs.com/amunamuna/p/10959796.html

## spring-context 会引入下面的包
<div align="center"> <img src="http://zpengg.oss-cn-shenzhen.aliyuncs.com/img/0464e17e26b765be0b02d632876f8db1.png"/> </div>

## BeanFactory & ApplicationContext
ApplicationContext 的两个顶层接口 BeanFactory 与 ResourceLoader。
BeanFactory 提供了最简单的容器的功能，提供了实例化对象和取对象的功能。
ApplicationContext 继承 BeanFactory
![ApplicationContext](https://pic4.zhimg.com/80/v2-1006341abadfd3466b5b4587f349ab27_720w.jpg)

## 容器加载过程
AbstractApplicationContext.refresh()   
```java
 
    @Override
	public void refresh() throws BeansException, IllegalStateException {
		synchronized (this.startupShutdownMonitor) {
			// Prepare this context for refreshing.
			prepareRefresh();

			// Tell the subclass to refresh the internal bean factory.
			ConfigurableListableBeanFactory beanFactory = obtainFreshBeanFactory();

			// Prepare the bean factory for use in this context.
			prepareBeanFactory(beanFactory);

			try {
				// Allows post-processing of the bean factory in context subclasses.
				postProcessBeanFactory(beanFactory);

				// Invoke factory processors registered as beans in the context.
				invokeBeanFactoryPostProcessors(beanFactory);

				// Register bean processors that intercept bean creation.
				registerBeanPostProcessors(beanFactory);

				// Initialize message source for this context.
				initMessageSource();

				// Initialize event multicaster for this context.
				initApplicationEventMulticaster();
                // ------
				// Initialize other special beans in specific context subclasses.
				onRefresh();
                // ------
				// Check for listener beans and register them.
				registerListeners();

				// Instantiate all remaining (non-lazy-init) singletons.
				finishBeanFactoryInitialization(beanFactory);

				// Last step: publish corresponding event.
				finishRefresh();
			}

			catch (BeansException ex) {
				logger.warn("Exception encountered during context initialization - cancelling refresh attempt", ex);

				// Destroy already created singletons to avoid dangling resources.
				destroyBeans();

				// Reset 'active' flag.
				cancelRefresh(ex);

				// Propagate exception to caller.
				throw ex;
			}
		}
```

## 注入方式
第一种，SET注入
a类中持有b类的引用，并且a类有b的set方法。在bean中添加<property>标签即可注入。实质上是将b实例化，然后调用set方法注入。
```java
 <bean id="a" class="com.qunar.pojo.StudentA" scope="singleton">
        <property name="studentB" ref="b"></property>
    </bean>
```
第二种，构造器注入
a类中持有b类的引用，并且a的构造函数参数中有b。实质上就是通过构造函数注入，创建a对象时要把b对象传进去。


```java
  <bean id="a" class="com.qunar.pojo.StudentA">
        <constructor-arg index="0" ref="b"></constructor-arg>
    </bean>
```

3.静态工厂
如果有需要静态工厂实例化的类，不能通过静态工厂.方法实现。在bean属性中对应类指向静态工厂，对应方法指向返回实例的方法

第四种，实例工厂
如果工厂不是静态，需要实例化，就实例化对应工厂，设定factory-bean和factory-method进行方法调用。

[参考资料](https://www.jianshu.com/p/ff532b67902a)

## 如何解决循环依赖

### Spring 创建 Bean 流程
getBean -> doGetBean ->if mbd.isSingleton -> createBean -> doCreateBean

### 初始化三步走：
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

### Spring 单例实现的原理
原理：单例注册表
优点：可以被继承

源码：
```java
	private final Map<String, Object> singletonObjects = new ConcurrentHashMap<String, Object>(64);

    protected Object getSingleton(String beanName, boolean allowEarlyReference) {
    	Object singletonObject = this.singletonObjects.get(beanName);
    	if (singletonObject == null && isSingletonCurrentlyInCreation(beanName)) {
    		synchronized (this.singletonObjects) {
    			singletonObject = this.earlySingletonObjects.get(beanName);
    			if (singletonObject == null && allowEarlyReference) {
    				ObjectFactory<?> singletonFactory = this.singletonFactories.get(beanName);
    				if (singletonFactory != null) {
    					singletonObject = singletonFactory.getObject();
    					this.earlySingletonObjects.put(beanName, singletonObject);
    					this.singletonFactories.remove(beanName);
    				}
    			}
    		}
    	}
    	return (singletonObject != NULL_OBJECT ? singletonObject : null);
    }
```

### 涉及到三级缓存

```java
/** Cache of singleton objects: bean name --> bean instance */
private final Map<String, Object> singletonObjects = new ConcurrentHashMap<String, Object>(256);
/** Cache of singleton factories: bean name --> ObjectFactory */
private final Map<String, ObjectFactory<?>> singletonFactories = new HashMap<String, ObjectFactory<?>>(16);
/** Cache of early singleton objects: bean name --> bean instance */
private final Map<String, Object> earlySingletonObjects = new HashMap<String, Object>(16);
```

#### 为什么需要3级 不是2级

回头看1.1 步骤
```
	protected Object doCreateBean(final String beanName, final RootBeanDefinition mbd, final Object[] args) {
	...
	    // Eagerly cache singletons to be able to resolve circular references
		// even when triggered by lifecycle interfaces like BeanFactoryAware.
		boolean earlySingletonExposure = (mbd.isSingleton() && this.allowCircularReferences &&
				isSingletonCurrentlyInCreation(beanName));
		if (earlySingletonExposure) {
			if (logger.isDebugEnabled()) {
				logger.debug("Eagerly caching bean '" + beanName +
						"' to allow for resolving potential circular references");
			}
			addSingletonFactory(beanName, new ObjectFactory<Object>() {
				@Override
				public Object getObject() throws BeansException {
					return getEarlyBeanReference(beanName, mbd, bean);
				}
			});
		}
	...
	}

/**
	 * Obtain a reference for early access to the specified bean,
	 * typically for the purpose of resolving a circular reference.
	 * @param beanName the name of the bean (for error handling purposes)
	 * @param mbd the merged bean definition for the bean
	 * @param bean the raw bean instance
	 * @return the object to expose as bean reference
	 */
	protected Object getEarlyBeanReference(String beanName, RootBeanDefinition mbd, Object bean) {
		Object exposedObject = bean;
		if (bean != null && !mbd.isSynthetic() && hasInstantiationAwareBeanPostProcessors()) {
			for (BeanPostProcessor bp : getBeanPostProcessors()) {
				if (bp instanceof SmartInstantiationAwareBeanPostProcessor) {
					SmartInstantiationAwareBeanPostProcessor ibp = (SmartInstantiationAwareBeanPostProcessor) bp;
					exposedObject = ibp.getEarlyBeanReference(exposedObject, beanName);
					if (exposedObject == null) {
						return exposedObject;
					}
				}
			}
		}
		return exposedObject;
	}
```
存放在singletonFactories好处是可扩展，我们在这个里面会调用beanPostProcessor 从而可以在我们实现提前获取对象引用的时候进行一些操作

### BeanPostProcessors的作用
BeanPostProcessor是spring提供的一个扩展点（钩子函数），通过BeanPostProcessor扩展点，我们可以对Spring管理的bean进行再加工。比如：修改bean的属性(@ConfigurationProperties注解的原理)、生成一个动态代理（事物）等。

[BeanPostProcessor](https://5b0988e595225.cdn.sohucs.com/images/20180620/72943a141d504272978a8d543b8a6327.jpeg)

与AOP有关 下文提及。

#### @Autowired与BPP的关系
@Autowired, @Inject, @Value, 和 @Resource 都是由Spring的BeanPostProcessor来处理的。
在你自己定义的BeanPostProcessor或者BeanFactoryPostProcessor里面是不可以使用这些注解的，要么使用xml要么使用@Bean。

### 为什么prototype不能打破循环引用
当Spring容器遍历那些循环依赖的bean时，只要遍历到那种已经遍历过一次的bean，并且它们不是通过属性注入依赖的singleton时，就会直接抛出BeanCurrentlyInCreationException异常。
org.springframework.beans.factory.support.AbstractBeanFactory#doGetBean

```java
if (isPrototypeCurrentlyInCreation(beanName)) {
                throw new BeanCurrentlyInCreationException(beanName);
            }
```

### @Autoired 按类型 @Resource 按名称 
@Autowired默认按类型装配（这个注解是属业spring的），默认情况下必须要求依赖对象必须存在，如果要允许null值，可以设置它的required属性为false，如：@Autowired(required=false) ，如果我们想使用名称装配可以结合@Qualifier注解进行使用
1.如果没有指定@Qualifier，默认安装类型注入，找不到则抛出异常。
2，如果指定了@Qualifier，则按照名称注入，找不到则抛出异常。


@Resource（这个注解属于J2EE的），默认按照名称进行装配
1. 如果同时指定了name和type，则从Spring上下文中找到唯一匹配的bean进行装配，找不到则抛出异常
2. 如果指定了name，则从上下文中查找名称（id）匹配的bean进行装配，找不到则抛出异常
3. 如果指定了type，则从上下文中找到类型匹配的唯一bean进行装配，找不到或者找到多个，都会抛出异常
4. 如果既没有指定name，又没有指定type，则自动按照byName方式进行装配；如果没有匹配，则回退为一个原始类型进行匹配，如果匹配则自动装配；

Filter过滤器
过滤器拦截web访问url地址。 严格意义上讲，filter只是适用于web中，依赖于Servlet容器，利用Java的回调机制进行实现。
作用对象： path
应用场景： 资源访问，访问方法限制，编码，过滤敏感词

Interceptor拦截器
拦截器拦截以 .action结尾的url，拦截Action的访问。 Interfactor是基于Java的反射机制（APO思想）进行实现，不依赖Servlet容器。
作用对象： 类，如Controller
应用场景： 登陆拦截器

Spring AOP拦截器
只能拦截Spring管理Bean的访问（业务层Service）。 具体AOP详情参照 Spring AOP：原理、 通知、连接点、切点、切面、表达式
作用对象： 类活着类的具体方法等
应用场景： 日志、�事务

实际开发中，AOP常和事务结合：Spring的事务管理:声明式事务管理(切面)
### filter vs interceptor
filter 基于 filter 接口中的 doFilter **回调函数**， interceptor 则基于 Java 本身的 **反射机制**；
filter 是依赖于 servlet 容器的，没有 servlet 容器就无法回调 doFilter 方法，而 interceptor 与 servlet 无关；
filter 的过滤范围比 interceptor 大，filter 除了过滤请求外通过通配符可以保护页面、图片、文件等，而 interceptor 只能过滤请求，只对 action 起作用，在 action 之前开始，在 action 完成后结束（如被拦截，不执行action）；
在 action 的生命周期中，拦截器可以被多次调用，而过滤器只能在容器初始化时被调用一次。

### interceptor vs AOP
spring Interceptor也是一种aop思想，我们这里面的spring AOP主要是讲aop应用，interceptor 的使用场合比aop小很多，顾名思义，它是拦截一些action请求，但是比aop使用起来简便；
程序执行的顺序是先进过滤器，再进拦截器，最后进切面；
Interceptor可以阻止代码执行下去，当preHandle返回false，那么这个请求就到此结束，真正的被拦截了，但是aop不能，它只是单纯的切入添加操作；

## AOP
AOP编程其实是很简单的事情，纵观AOP编程，程序员只需要参与三个部分：
1、定义普通业务组件
2、定义切入点，一个切入点可能横切多个业务组件
3、定义增强处理，增强处理就是在AOP框架为普通业务组件织入的处理动作

所以进行AOP编程的关键就是定义切入点和定义增强处理，一旦定义了合适的切入点和增强处理，AOP框架将自动生成AOP代理，即：代理对象的方法=增强处理+被代理对象的方法。

### 动态代理
Spring创建代理的规则为：
1、默认使用Java动态代理来创建AOP代理，这样就可以为任何接口实例创建代理了
2、当需要代理的类不是代理接口的时候，Spring会切换为使用CGLIB代理，也可强制使用CGLIB

创建 & 调用顺序：
1、生成代理对象，初始化拦截器链(这发生在bean的生命周期initlizeBean中，生成是通过AopProxy接口，有两个实现类Cglib2AopProxy，JdkDynamicAopProxy)
2、代码中调用bean的某个方法的时候，实际上是通过代理对象调用的。调用时会获取拦截器链，逐个进行匹配执行（切面逻辑），最终通过反射的方法调用目标对象方法。

### AOP 在IOC在getBean的BPP过程中 返回 动态代理。
当一个对象被SpringAOP代理，那么当使用getBean获取到的并不是对象本身，而是一个代理对象。
其实发生在initlizeBean，在其中会执行BeanProcessor.postProcessAfterInitialization
具体就是AbstractAutoProxyCreator类的postProcessAfterInitialization 方法

```java
protected Object wrapIfNecessary(Object bean, String beanName, Object cacheKey) {
        if (beanName != null && this.targetSourcedBeans.contains(beanName)) {
            return bean;
        } else if (Boolean.FALSE.equals(this.advisedBeans.get(cacheKey))) {
            return bean;
        } else if (!this.isInfrastructureClass(bean.getClass()) && !this.shouldSkip(bean.getClass(), beanName)) {
            Object[] specificInterceptors = this.getAdvicesAndAdvisorsForBean(bean.getClass(), beanName, (TargetSource)null);
            if (specificInterceptors != DO_NOT_PROXY) {
                this.advisedBeans.put(cacheKey, Boolean.TRUE);
                Object proxy = this.createProxy(bean.getClass(), beanName, specificInterceptors, new SingletonTargetSource(bean));
                this.proxyTypes.put(cacheKey, proxy.getClass());
                return proxy;
            } else {
                this.advisedBeans.put(cacheKey, Boolean.FALSE);
                return bean;
            }
        } else {
            this.advisedBeans.put(cacheKey, Boolean.FALSE);
            return bean;
        }
    }
```

扩展：
Dubbo的动态代理有两种方式，一种是基于Javassist 代理，一种是jdk动态代理
默认使用javassist动态字节码生成，创建代理类
但是可以通过spi扩展机制配置自己的动态代理策略

## Spring 事务
### 事务种类/配置方式
Spring支持编程式事务管理以及声明式事务管理两种方式。

1. 编程式事务管理
编程式事务管理是侵入性事务管理，使用TransactionTemplate或者直接使用PlatformTransactionManager，对于编程式事务管理，Spring推荐使用TransactionTemplate。

2. 声明式事务管理
AOP

### 隔离级别
@Transactional(isolation = Isolation.READ_UNCOMMITTED)

ISOLATION_DEFAULT	使用后端数据库默认的隔离级别

ISOLATION_READ_UNCOMMITTED	允许读取尚未提交的更改。可能导致脏读、幻读或不可重复读。

ISOLATION_READ_COMMITTED	（Oracle 默认级别）允许从已经提交的并发事务读取。可防止脏读，但幻读和不可重复读仍可能会发生。

ISOLATION_REPEATABLE_READ	（MYSQL默认级别）对相同字段的多次读取的结果是一致的，除非数据被当前事务本身改变。可防止脏读和不可重复读，但幻读仍可能发生。MySql 不会有幻读

ISOLATION_SERIALIZABLE	完全服从ACID的隔离级别，确保不发生脏读、不可重复读和幻影读。这在所有隔离级别中也是最慢的，因为它通常是通过完全锁定当前事务所涉及的数据表来完成的。

### 事务传播行为
@Transactional(propagation=Propagation.REQUIRED)


PROPAGATION_REQUIRED
Spring默认的传播机制，能满足绝大部分业务需求，如果外层有事务，则当前事务加入到外层事务，一块提交，一块回滚。如果外层没有事务，新建一个事务执行

PROPAGATION_REQUES_NEW
该事务传播机制是每次都会新开启一个事务，同时把外层事务挂起，当当前事务执行完毕，恢复上层事务的执行。如果外层没有事务，执行当前新开启的事务即可

PROPAGATION_SUPPORT
如果外层有事务，则加入外层事务，如果外层没有事务，则直接使用非事务方式执行。完全依赖外层的事务

PROPAGATION_NOT_SUPPORT
该传播机制不支持事务，如果外层存在事务则挂起，执行完当前代码，则恢复外层事务，无论是否异常都不会回滚当前的代码

PROPAGATION_NEVER
该传播机制不支持外层事务，即如果外层有事务就抛出异常

PROPAGATION_MANDATORY
与NEVER相反，如果外层没有事务，则抛出异常

PROPAGATION_NESTED
该传播机制的特点是可以保存状态保存点，当前事务回滚到某一个点，从而避免所有的嵌套事务都回滚，即各自回滚各自的，如果子事务没有把异常吃掉，基本还是会引起全部回滚的。

### 超时性
@Transactional(timeout=30)

### 回滚规则
指定单一异常类：@Transactional(rollbackFor=RuntimeException.class)
指定多个异常类：@Transactional(rollbackFor={RuntimeException.class, Exception.class})

## SpringMVC
SpringMVC框架是以请求为驱动，围绕Servlet设计，将请求发给控制器，然后通过模型对象，分派器来展示请求结果视图。其中核心类是DispatcherServlet，它是一个Servlet，顶层是实现的Servlet接口。

### 执行流程
1、  用户发送请求至前端控制器DispatcherServlet。

2、  DispatcherServlet收到请求调用HandlerMapping处理器映射器。

3、  处理器映射器找到具体的处理器(可以根据xml配置、注解进行查找)，生成处理器对象及处理器拦截器(如果有则生成)一并返回给DispatcherServlet。

4、  DispatcherServlet调用HandlerAdapter处理器适配器。

5、  HandlerAdapter经过适配调用具体的处理器(Controller，也叫后端控制器)。

6、  Controller执行完成返回ModelAndView。

7、  HandlerAdapter将controller执行结果ModelAndView返回给DispatcherServlet。

8、  DispatcherServlet将ModelAndView传给ViewReslover视图解析器。

9、  ViewReslover解析后返回具体View。

10、DispatcherServlet根据View进行渲染视图（即将模型数据填充至视图中）。

11、 DispatcherServlet响应用户。

### 参数解析
@Requestbody @ResponseBody
mvc:message-conveter 配置 Jackson 转换

## SpringBoot 
约定大于配置 简化配置过程

### 自动装配
`@SpringBootApplication` 包含三个注解
```java
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan(
    excludeFilters = {@Filter(
    type = FilterType.CUSTOM,
    classes = {TypeExcludeFilter.class}
), @Filter(
    type = FilterType.CUSTOM,
    classes = {AutoConfigurationExcludeFilter.class}
)}
)
```

1.@SpringBootConfiguration @Configuration 的一个包装
2.@CommonentScan 定义扫描目录 默认所在包和子包下的类
3.@EnableAutoConfiguration 自动装配流程主要在这

其实SpringBoot是基于Spring基础之上的，通过MAVEN引入SpringBoot也会发现，它传递依赖了Spring。所以配置并没有减少，只是它帮我们自动配置了，这些自动配置的类都在spring-boot-autoconfigure-版本.jar包中。

预定义了一些配置类

@Configuration 可以自定义一些配置

参考 https://yq.aliyun.com/articles/718856

### 配置加载顺序
@ConditionalOnClass({ResourceConfig.class})

