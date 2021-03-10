# Spring MVC
## 组件
Spring MVC的核心组件：

- DispatcherServlet：中央控制器，把请求给转发到具体的控制类
- Controller：具体处理请求的控制器
- HandlerMapping：映射处理器，负责映射中央处理器转发给controller时的映射策略
- HandlerAdapter: HttpMessageConverter,DataBinder,Handler 解析处理数据
- ModelAndView：服务层返回的数据和视图层的封装类 
- ViewResolver：视图解析器，解析具体的视图  
- Interceptors ：拦截器，负责拦截我们定义的请求然后做处理工作

## flow
![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9RQ3U4NDlZVGFJTzZqaWI4WFAzcjhoOHNpYjA4MGljaWJIdnVYZjZOODFvYVdSQlRKTjN0WUVIQlBpYjhlSENHTzZNbWx2a25TdWliRW1sUk90ejRJY2ZyeFg5dy82NDA?x-oss-process=image/format,png)