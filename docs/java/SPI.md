# SPI
SPI（Service Provider Interface），是JDK内置的一种**服务提供发现机制**，
Java中SPI机制主要思想是将装配的控制权移到程序之外, 核心思想就是**解耦**。
## 实现
通过在ClassPath路径下的META-INF/services文件夹查找文件，自动加载文件里所定义的类。
利用了[[反射]]机制 ClassLoader.loadClass(), 进行[[类加载]]
## src
### ServiceLoader
```java
public final class ServiceLoader<S> implements Iterable<S>
    //配置文件的路径
    private static final String PREFIX = "META-INF/services/";
    //加载的服务类或接口
    private final Class<S> service;
    //已加载的服务类集合
    private LinkedHashMap<String,S> providers = new LinkedHashMap<>();
    //类加载器
    private final ClassLoader loader;
    //内部类，真正加载服务类
    private LazyIterator lookupIterator;
}
```
load 方法，实例化内部类 LazyIterator，最后实例化ServiceLoader

```java
// LazyIterator 可以跟据配置 找到具体实现类
private boolean hasNextService() {
        //第二次调用的时候，已经解析完成了，直接返回
        if (nextName != null) {
            return true;
        }
        if (configs == null) {
            //META-INF/services/ 加上接口的全限定类名，就是文件服务类的文件
            //META-INF/services/com.viewscenes.netsupervisor.spi.SPIService
            String fullName = PREFIX + service.getName();
            //将文件路径转成URL对象
            configs = loader.getResources(fullName);
        }
        while ((pending == null) || !pending.hasNext()) {
            //解析URL文件对象，读取内容，最后返回
            pending = parse(service, configs.nextElement());
        }
        //拿到第一个实现类的类名
        nextName = pending.next();
        return true;
    }
```
最终再实例化类

## 例子
### java.sql.Driver
比如java.sql.Driver接口，其他不同厂商可以针对同一接口做出不同的实现，MySQL和PostgreSQL都有不同的实现提供给用户，而Java的SPI机制可以为某个接口寻找服务实现。

```java
// 以前 Class.forName("com.mysql.jdbc.Driver")
String url = "jdbc:xxxx://xxxx:xxxx/xxxx";
Connection conn = DriverManager.getConnection(url,username,password);
```
### common-logging