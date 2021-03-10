# BeanFactory
[[Bean]] 容器 + 生命周期管理 + 钩子
## 作用：管理Bean生命周期 并暴露接口
beanFactory会在bean的生命周期的各个阶段中对bean进行各种管理，
并且spring将这些阶段通过各种接口暴露给我们，让我们可以对bean进行各种处理，
我们只要让bean实现对应的接口，那么spring就会在bean的生命周期调用我们实现的接口来处理该bean