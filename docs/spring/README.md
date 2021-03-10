# Spring 知识点
[[spring-context]] 关键包

## IOC
[[ApplicationContext]]
[[BeanFactory]]
[[SpringMVC]]
[[IOC]]
[[Bean]]
[[单例]]
[[三级缓存]]

## AOP
[[BeanPostProcessor]] IOC - AOP 桥梁
[[AOP]]
## 注解
[[@RequestMapping]]
[[@Autowired]]
[[@Resource]]

## 支持事务
[[Spring 事务]]


## 参考
[API](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/beans/factory/ObjectFactory.html)

[[面试突击]]







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

