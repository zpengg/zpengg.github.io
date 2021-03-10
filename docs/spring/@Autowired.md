# @Autowired 按类型
@Autowired默认按类型装配（这个注解是属业spring的），默认情况下必须要求依赖对象必须存在，如果要允许null值，可以设置它的required属性为false，如：@Autowired(required=false) ，
## @Qualifier 按名称
如果我们想使用名称装配可以结合@Qualifier注解进行使用
1.如果没有指定@Qualifier，默认安装类型注入，找不到则抛出异常。
2，如果指定了@Qualifier，则按照名称注入，找不到则抛出异常
## @Autowired与BPP的关系
@Autowired, @Inject, @Value, 和 @Resource 都是由Spring的BeanPostProcessor来处理的。
在你自己定义的BeanPostProcessor或者BeanFactoryPostProcessor里面是不可以使用这些注解的，要么使用xml要么使用@Bean。