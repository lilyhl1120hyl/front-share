<template>
  <div class="about">
    <div id="container"></div>
    <div class="moon">
      <img class="moonImg" src="../assets/moon.png" />
    </div>
    <div id="moonAnimation"></div>
  </div>
</template>

<script>
import * as THREE from "three";
// tips: 路径问题
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';  

export default {
  name: "Panorama",
  data() {
    return {
      camera: null,
      scene: null,
      renderer: null,
      mesh: null,
      controls: null,
      geometry: null,
    };
  },
  mounted() {
    this.init();
    this.animate();
    this.loadImgs();
  },
  methods: {
    init() {
      // 初始化渲染器
      var container = document.getElementById("container");
      var axes = new THREE.AxesHelper(50);//添加辅助坐标系

      this.renderer = new THREE.WebGLRenderer();
      this.renderer.setPixelRatio(window.devicePixelRatio);
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      container.appendChild(this.renderer.domElement);

      // 初始化场景
      this.scene = new THREE.Scene();

      // 初始化相机
      this.camera = new THREE.PerspectiveCamera(
        90,
        window.innerWidth / window.innerHeight,
        0.1,
        100
      );
      this.camera.position.z = 0.01;

      //  初始化控制器
      this.controls = new OrbitControls(this.camera, this.renderer.domElement);
      this.controls.enableZoom = false;
      this.controls.enablePan = true;
      this.controls.autoRotate = true;
      this.controls.enableDamping = true;
      this.controls.rotateSpeed = 0.05;
      
      // tips: 绝对路径，或者require('./相对路径')
      var textures = this.getTexturesFromAtlasFile(
        "/static/sun_temple_stripe.jpg",
        6
      );

      var materials = [];

      for (var i = 0; i < 6; i++) {
        materials.push(new THREE.MeshBasicMaterial({ map: textures[i] }));
      }

      var skyBox = new THREE.Mesh(
        new THREE.BoxBufferGeometry(1, 1, 1),
        materials
      );
      skyBox.geometry.scale(1, 1, -1);
      this.scene.add(skyBox);
      this.scene.add(axes);

      window.addEventListener("resize", this.onWindowResize, false);
    },
    loadImgs(){
            // 创建纹理加载器
      let sprite = new THREE.Sprite(new THREE.SpriteMaterial({ 
        map: new THREE.TextureLoader().load("/static/images/canvas0.png"),
        sizeAttenuation:false // false的话 不随着相机拉远而变小
      }))
      sprite.position.set(-1.06,-1.05,-1.05)//精灵图添加的位置
      sprite.scale.set(2, 2, 1)//精灵图大小
      sprite.name = "jinglingtu"//精灵图名称
      // 将精灵添加到场景中
      this.scene.add(sprite)
console.log(this.scene, "scene===")
    
      //给精灵图添加脉冲效果
      // spriteAnimateFn(sprite);

    },
    // 将获得的图片进行裁剪
    getTexturesFromAtlasFile(atlasImgUrl, tilesNum) {
      var textures = [];

      for (var i = 0; i < tilesNum; i++) {
        textures[i] = new THREE.Texture();
      }

      var imageObj = new Image();

      imageObj.onload = function () {
        var canvas, context;
        var tileWidth = imageObj.height;  // 获取高度

        for (var i = 0; i < textures.length; i++) {
          canvas = document.createElement("canvas"); // 初始化canvas
          context = canvas.getContext("2d");
          canvas.height = tileWidth;
          canvas.width = tileWidth;
          // 剪切图像，并在画布上定位被剪切的部分：
          // context.drawImage(img,sx,sy,swidth,sheight,x,y,width,height);
          
          context.drawImage(
            imageObj,
            tileWidth * i,
            0,
            tileWidth,
            tileWidth,
            0,
            0,
            tileWidth,
            tileWidth
          );
          textures[i].image = canvas;
          textures[i].needsUpdate = true;
        }
      };

      imageObj.src = atlasImgUrl; 

      return textures;
    },

    onWindowResize() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();

      this.renderer.setSize(window.innerWidth, window.innerHeight);
    },

    animate() {
      requestAnimationFrame(this.animate);

      this.controls.update(); // required when damping is enabled

      this.renderer.render(this.scene, this.camera);
    },
  },
}
</script>

<style scoped>
#container {
  height: 500px;
}

.moon{
  position: absolute;;
  top:0;
  left:54%;
  width: 160px;
  height: 160px;
  z-index:999;
}
.moonImg{
  width: 160px;
  height: 160px;
}

</style>