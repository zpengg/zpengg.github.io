# Object
```java 
 public final native Class<?> getClass()

public native int hashCode()

public boolean equals(Object obj)

protected native Object clone() throws CloneNotSupportedException

public String toString()

public final native void notify()

public final native void notifyAll()

public final native void wait(long timeout) throws InterruptedException

public final void wait(long timeout, int nanos) throws InterruptedException

public final void wait() throws InterruptedException

protected void finalize() throws Throwable {}

```

## equals() 通常实现，
### 默认 比较引用
```java
public boolean equals(Object obj) {
return(this== obj);
}
```
### how to Override ? 
 - 检查是否为同一个对象的引用，如果是直接返回 true；
 - 检查是否是同一个类型，如果不是，直接返回 false；
 - 将 Object 对象进行转型；
 - 判断每个关键域是否相等。

### == vs equals()
== 是比较引用
equals() 看具体实现

## hashCode


### !! 重写equals方法后重写hashCode方法
若 == -> equals()，hashcode ==
否则，为了适配一些容器set map， 避免equals 但 hashCode 不同，
