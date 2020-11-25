## 入口
`src/core/index.js`
``` javascript
documentReady(_ => new Docsify());
```
`src/core/Docsify.js`
主要是向Docsify[[js/JS对象|prototype]]注入方法和属性
``` javascript

export function Docsify() {
  this._init();
}

const proto = Docsify.prototype;

initMixin(proto);
routerMixin(proto);
renderMixin(proto);
fetchMixin(proto);
eventMixin(proto);

/**
 * Global API
 */
initGlobalAPI();
```

### `initMixin(proto)`
``` javascript

export function initMixin(proto) {
  proto._init = function() {
    const vm = this;
    vm.config = config(vm);

    initLifecycle(vm); // Init hooks
    initPlugin(vm); // Install plugins
    callHook(vm, 'init');
    initRouter(vm); // Add router
    initRender(vm); // Render base DOM
    initEvent(vm); // Bind events
    initFetch(vm); // Fetch data
    callHook(vm, 'mounted');
  };
}
```