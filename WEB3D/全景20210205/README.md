## 主题： 基于three.js的VR全景漫游

## 什么是VR，全景？ 两者的区别。
http://www.360doc.com/content/16/1218/17/38211756_615772872.shtml

## 先来看一下three.js能做什么？
http://www.3dnest.cn/index.html  

https://sketchfab.com/
## 需要用到的基础知识

### 1，纹理（Texture）
创建一个纹理贴图，将其应用到一个表面，或者作为反射/折射贴图。

构造函数
Texture( image, mapping, wrapS, wrapT, magFilter, minFilter, format, type, anisotropy, encoding )

源代码
// load a texture, set wrap mode to repeat
var texture = new THREE.TextureLoader().load( "textures/water.jpg" );
texture.wrapS = THREE.RepeatWrapping;
texture.wrapT = THREE.RepeatWrapping;
texture.repeat.set( 4, 4 );

### 2, 纹理对象Texture是其他纹理对象的基类。

canvas纹理CanvasTexture
压缩纹理CompressedTexture
立方体纹理CubeTexture
数据纹理DataTexture
深度纹理DepthTexture
视频纹理VideoTexture



## 需要用到的插件

### 1. OrbitControls.js  控制器

- 1，初始化
```
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 10000 );
var controls = new THREE.OrbitControls( camera );
camera.position.set( 0, 20, 100 );
controls.update();
function animate() {
	requestAnimationFrame( animate );

	// required if controls.enableDamping or controls.autoRotate are set to true
	controls.update();
	renderer.render( scene, camera );
}
```
- 2，构造函数

OrbitControls(object: Camera,domElement: HTMLDOMElement)
object: 控制的相机
domElement： 默认是整个文档上。可选的，指定在特定的元素(例如画布)上工作
特性

- 3，属性
autoRotate: Boolean 默认false。设定为true时，相机自动围绕目标旋转但 
   **必须调用update()在你的animation循环中**
autoRotateSpeed: Float 当前者为true时默认2.0，代表每轮60fps用时30s,值越小转动越慢
rotateSpeed: Float 旋转速度(ORBIT的旋转速度，鼠标左键)，默认1
domElement: HTMLDOMElement 侦听鼠标/触摸事件，必须在构造函数中传递，用作特性值更改后不会重新设置事件侦听器 默认是整个文档
enableDamping: Boolean 默认false。设置为true则启用阻尼(惯性)，用来给控制相机一个重量，必须调用update()在你的animation循环中
dampingFactor: Float 前者为true时使用阻尼惯性(可理解为阻止向一个方向移动)
enabled: Boolean 是否启用控件，默认true
enableKeys: Boolean 能否用键盘控制，默认true ←↑→↓四个键控制物体的移动
keys: Object 控制相机平移的四个键。默认四个箭头键{LEFT: 37,UP: 38,RIGHT: 39,DOWM:40} 所有的键值
enablePan: Boolean 相机移动，默认true
panSpeed: Float 移动的速度，默认1
keyPanSpeed: Float 相机平移的速度，默认每按一次控制方向键移动7.0像素
enableRotate: Boolean 水平垂直旋转相机，默认true。只想控制单轴，通过PolarAngle/AzimuthAngle的最小值和最大值设置为相同的值，这将导致垂直或水平旋转固定在该值
enableZoom: Boolean 相机的缩放
maxAzimuthAngle: Float 水平旋转，范围-Math.PI~Math.PI 或者Infinity 默认Infinity
minAzimuthAngle: Float 水平旋转，范围-Math.PI~Math.PI 或者-Infinity 默认-Infinity
maxPolarAngle: Float 垂直旋转，范围0~Math.PI 默认Math.PI
minPolarAngle: Float 垂直旋转，范围0~Math.PI 默认0
maxDistance: Float 拉远镜头(只能用在PerspectiveCamera),默认Infinity
minDistance: Float 拉近镜头，默认0
maxZoom: Float 拉远镜头(只能用在OthorgraphicCamera),默认Infinity
minZoom: Float拉近镜头，默认0
mouseButton: Object {ORBIT: THREE.MOUSE.LEFT,ZOOM: THREE.MOUSE.MIDDLE,PAN: THREE.MOUSE.RIGHT} 鼠标控制缩放移动和旋转
object: Camera 正在控制的相机
position0: Vector3 在reset()和saveState()内部使用
screenSpacePaning: Boolean 平移时摄像机位置的转换。true，相机的平移在屏幕空间；false,摄像机在与摄像机向上方向正交的平面上平移，默认false
target0: Vector3在reset()和saveState()内部使用
target 空间围绕旋转的点
zoom0: Vector3 在reset()和saveState()内部使用
zoomSpeed: Float zoom(变焦)的速度，默认1

- 4，方法
dispose(): null 移除所有的事件监听
getAzimuthAngle(): radians 获得用弧度表示的当前水平旋转角度
getPolarAngle(): radians获得用弧度表示的当前垂直旋转角度
reset(): null 通过最近一次调用saveState()或者初始状态来重置为当前的状态
saveState(): null 保存当前控制的状态，可以稍后通过reset()来恢复
update(): false 更新控件，在手动改变了摄像机的转换后必须调用。在设置了autoRotate或enableDamping时也要在循环中调用 


### 代码运行




