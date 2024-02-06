<template>
    <div>
      <div id="container"></div>
    </div>
  </template>
  
  <script>
  import * as THREE from 'three'
  import * as TWEEN from "tween.js";
  import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
  import { PLYLoader } from 'three/examples/jsm/loaders/PLYLoader.js'
  
  export default {
    data() {
      return {
        publicPath: process.env.BASE_URL,
        points: null,
        loadedGeometry: null,
        animationMap: {},
        camera: null,
        scene: null,
        renderer: null,
        controls: null
      }
    },
    mounted() {
      this.init()
    },
    methods: {
      // 初始化
      init() {
        this.createScene() // 创建场景
        this.loadPLY() // 加载PLY模型
        this.createLight() // 创建光源
        this.createCamera() // 创建相机
        this.createRender() // 创建渲染器
        this.createControls() // 创建控件对象
        this.render() // 渲染
      },
      // 创建场景
      createScene() {
        this.scene = new THREE.Scene()
      },
      // 加载PLY模型
      loadPLY() {
        const THIS = this
        const loader = new PLYLoader()
        loader.load(`${THIS.publicPath}models/test.ply`, geometry => {
          this.loadedGeometry = geometry.clone()
          // 创建粒子材质
          const material = new THREE.PointsMaterial({
            color: 0xffffff,
            size: 0.4,
            opacity: 0.6,
            transparent: true,
            blending: THREE.AdditiveBlending,
            map: this.generateSprite()
          })
          // 创建粒子系统
          this.points = new THREE.Points(geometry, material)
          // 添加到场景
          this.scene.add(this.points)
          this.initTween()
        })
      },
      //生成纹理
      generateSprite() {
        const canvas = document.createElement('canvas')
        canvas.width = 16
        canvas.height = 16
  
        const context = canvas.getContext('2d')
        const gradient = context.createRadialGradient(
          canvas.width / 2,
          canvas.height / 2,
          0,
          canvas.width / 2,
          canvas.height / 2,
          canvas.width / 2
        )
        gradient.addColorStop(0, 'rgba(255,255,255,1)')
        gradient.addColorStop(0.2, 'rgba(0,255,255,1)')
        gradient.addColorStop(0.4, 'rgba(0,0,64,1)')
        gradient.addColorStop(1, 'rgba(0,0,0,1)')
  
        context.fillStyle = gradient
        context.fillRect(0, 0, canvas.width, canvas.height)
  
        const texture = new THREE.Texture(canvas)
        texture.needsUpdate = true
        return texture
      },
  
      // 创建光源
      createLight() {
        // 环境光
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.1) // 创建环境光
        this.scene.add(ambientLight) // 将环境光添加到场景
  
        const spotLight = new THREE.SpotLight(0xffffff) // 创建聚光灯
        spotLight.position.set(50, 50, 50)
        spotLight.castShadow = true
        this.scene.add(spotLight)
      },
      // 创建相机
      createCamera() {
        const element = document.getElementById('container')
        const width = element.clientWidth // 窗口宽度
        const height = element.clientHeight // 窗口高度
        const k = width / height // 窗口宽高比
        // PerspectiveCamera( fov, aspect, near, far )
        this.camera = new THREE.PerspectiveCamera(35, k, 0.1, 1000)
        this.camera.position.set(20, 20, 20) // 设置相机位置
  
        this.camera.lookAt(new THREE.Vector3(10, 40, 0)) // 设置相机方向
        this.scene.add(this.camera)
      },
      // 创建渲染器
      createRender() {
        const element = document.getElementById('container')
        this.renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true })
        this.renderer.setSize(element.clientWidth, element.clientHeight) // 设置渲染区域尺寸
        this.renderer.shadowMap.enabled = true // 显示阴影
        this.renderer.shadowMap.type = THREE.PCFSoftShadowMap
        this.renderer.setClearColor(0x3f3f3f, 1) // 设置背景颜色
        element.appendChild(this.renderer.domElement)
      },
      initTween() {
        this.animationMap = { yScale: 1 } //动画变量
        //创建一个动画，它的yScale的值在 5000毫秒 内变为 0
        const tween = new TWEEN.Tween(this.animationMap).to({ yScale: 0 }, 5000)
        tween.easing(TWEEN.Easing.Sinusoidal.InOut)
        tween.start()
        //创建另一个动画，它的yScale的值在 5000毫秒 恢复为1
        const tweenBack = new TWEEN.Tween(this.animationMap).to(
          { yScale: 1 },
          5000
        )
        tweenBack.easing(TWEEN.Easing.Sinusoidal.InOut)
        //第一个动画和第二个动画往复调用
        tween.chain(tweenBack)
        tweenBack.chain(tween)
  
        //二个动画更新的回调处理
        tween.onUpdate(this.onUpdate)
        tweenBack.onUpdate(this.onUpdate)
      },
      onUpdate() {
        // const vertices = []
        // 获取导入几何体顶点坐标分量数组
        const loadedGeometryVerticesArray = this.loadedGeometry.attributes
          .position.array
  
        // 每三个分量确定一个顶点
        for (let i = 0; i < loadedGeometryVerticesArray.length; i += 3) {
          //顶点的x坐标不变
          this.points.geometry.attributes.position.array[i] =
            loadedGeometryVerticesArray[i]
          //顶点的y坐标根据pos参数动态变化
          this.points.geometry.attributes.position.array[i + 1] =
            loadedGeometryVerticesArray[i + 1] * this.animationMap.yScale
          //顶点的z坐标不变
          this.points.geometry.attributes.position.array[i + 2] =
            loadedGeometryVerticesArray[i + 2]
        }
  
        this.points.sortParticles = true
      },
      render() {
        TWEEN.update() //更新Tween
        if (this.points) {
          //设置顶点需要更新
          this.points.geometry.attributes.position.needsUpdate = true
          //计算当前几何体的的边界球形
          this.points.geometry.computeBoundingSphere()
        }
        this.renderer.render(this.scene, this.camera)
        requestAnimationFrame(this.render)
      },
      // 创建控件对象
      createControls() {
        this.controls = new OrbitControls(this.camera, this.renderer.domElement)
      }
    }
  }
  </script>
  <style>
  #container {
    position: absolute;
    width: 100%;
    height: 100%;
  }
  </style>
  
  