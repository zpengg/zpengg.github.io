# DvaJS
> dva 首先是一个基于 [[redux]] 和 redux-saga 的数据流方案，然后为了简化开发体验，dva 还额外内置了 react-router 和 fetch，所以也可以理解为一个轻量级的应用框架。

## flow
当此类行为会改变数据的时候可以通过 dispatch 发起一个 action，
- 如果是同步行为会直接通过 Reducers 改变 State ，
- 如果是异步行为（副作用）会先触发 Effects 然后流向 Reducers 最终改变 State


## Effects
[[generator]]
[[pure]] 纯函数