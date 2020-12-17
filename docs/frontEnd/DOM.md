# DOM
## element.childnodes
不一定同种类

## document获取元素
建议：缓存起来，尽少调用这几个，会搜索整个dom树
### getElementById,即唯一一个<div id=xxx>
### getElementsByTagName,获得一列表满足标签<aa>,<bb>的元素
### getElementsByClassName，获得一列表满足<div class=xxx>的元素

## document更新元素属性
### getAttribute 
### setAttribute

## nodeValue 与 innerhtml
1. nodeValue 方法返回的是该节点的值，在 DOM 中主要有三种节点，分别是元素节点、属性节点、文档节点，其中元素节点是没有值得，而属性节点和文档节点是有值的。
2. innerHTML 返回该节点内的所有子节点及其值

