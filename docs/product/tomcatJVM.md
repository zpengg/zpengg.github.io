# tomcat JVM
```
CATALINA_OPTS="
-server 
-Xms6000M 
-Xmx6000M 
-Xss512k 
-XX:NewSize=2250M 
-XX:MaxNewSize=2250M 
-XX:PermSize=128M
-XX:MaxPermSize=256M  
-XX:+AggressiveOpts 
-XX:+UseBiasedLocking 
-XX:+DisableExplicitGC 
-XX:+UseParNewGC 
-XX:+UseConcMarkSweepGC 
-XX:MaxTenuringThreshold=31 
-XX:+CMSParallelRemarkEnabled 
-XX:+UseCMSCompactAtFullCollection 
-XX:LargePageSizeInBytes=128m 
-XX:+UseFastAccessorMethods 
-XX:+UseCMSInitiatingOccupancyOnly
-Duser.timezone=Asia /Shanghai 
-Djava.awt.headless= true "
```