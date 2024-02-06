<template>
   <div id="container"> </div>
</template>


<script>
import * as THREE from "three";
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';  

export default {
 name: 'Panoramacube',
 data () {
   return {
     camera: null,
     scene: null,
     renderer: null,
     mesh: null,
     controls: null,
     crossOrigin: ''
   }
 },
 methods: {
   init() {
     this.scene = new THREE.Scene();

     var path = '/static/skybox/Daylight_'
     var format = '.jpg'
     var urls = [
       path + 'px' + format, path + 'nx' + format,
       path + 'py' + format, path + 'ny' + format,
       path + 'pz' + format, path + 'nz' + format
     ]
     var materials = []
     for (var i = 0; i < urls.length; ++i) {
       var loader = new THREE.TextureLoader()
       // loader.setCrossOrigin( this.crossOrigin );
       var texture = loader.load(urls[i], function () { console.log('q') }, undefined, function (e) { console.log(e) })
       materials.push(new THREE.MeshBasicMaterial({
         map: texture,
         side: THREE.BackSide
         // transparent: true,
         // needsUpdate:true
       })
       )
     }
     var cube = new THREE.Mesh(new THREE.BufferGeometry(9000, 9000, 9000), materials)
     cube.name = 'sky'
     this.scene.add(cube)

     var ambient = new THREE.AmbientLight(0xcccccc) // 光源
     this.scene.add(ambient)

     var axes = new THREE.AxesHelper(100000)  // 辅助线
     this.scene.add(axes)

     var width = window.innerWidth // 窗口宽度
     var height = window.innerHeight // 窗口高度
     var k = width / height// 窗口宽高比
     // 创建相机对象
     this.camera = new THREE.PerspectiveCamera(45, k, 1, 1000000)
     this.camera.position.set(1000, 0, 1000)// 设置相机位置
     this.camera.lookAt(new THREE.Vector3(0, 0, 0))// 设置相机方向(指向的场景对象)
     /**
        * 创建渲染器对象
        */
     this.renderer = new THREE.WebGLRenderer({antialias: true})
     this.renderer.setSize(width, height)
     this.renderer.setClearColor(0xb9d3ff, 1)// 设置背景颜色
     document.getElementById('container').appendChild(this.renderer.domElement)// body元素中插入canvas对象
     // 执行渲染操作
     this.renderer.render(this.scene, this.camera)
     this.controls = new OrbitControls(this.camera, document.getElementById('container'))// 创建控件对象
     // 控制缩放 透视相机
     this.controls.minDistance = 2;
     this.controls.maxDistance = 20000;
     
     this.controls.addEventListener('change', this.animate())
   },
   animate() {
     requestAnimationFrame(this.animate)
     this.renderer.render(this.scene, this.camera)
   }
 },
 mounted () {
   this.init()
   // this.animate()
 }
}
</script>

