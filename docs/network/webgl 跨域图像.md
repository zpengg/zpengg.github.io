# webGl
### WebGL 跨域图像
小游戏开发 使用浏览器调试过程中遇到 

要实现这个我们需要设置 crossOrigin 属性然后浏览器会试图从服务器获取图像，如果不是相同的域名， 浏览器会请求 CORS 许可。

### dom 方法获取
直接使用 <img src="private.jpg"> 是没什么问题的，因为图像尽管被浏览器显示， 便签对象并不能获取图像的内部数据

### canvas方法获取
Canvas2D API 有一个方式可以读取图像信息，首先需要将图像绘制到画布
但是如果绘制的图像来自不同的域名，浏览器就会将画布标记为被污染， 然后当你调用 ctx.getImageData 时就会得到一个安全错误。 WebGL 跨域图像

## 参考
[WebGL 跨域图像](https://webglfundamentals.org/webgl/lessons/zh_cn/webgl-cors-permission.html)