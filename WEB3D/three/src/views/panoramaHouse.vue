<template>
  <div>
    <div id="container"></div>
    <div class="change-box">
      <div class="room" @click="change()">客厅</div>
      <div class="room" @click="change('room1')">主卧室</div>
      <div class="room" @click="change('room3')">儿童房</div>
      <div class="room" @click="change('room4')">次卧</div>
      <div class="room" @click="change('room5')">浴室</div>
      <div class="room" @click="change('room6')">次厅</div>
    </div>
  </div>
</template>

<script>
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";

export default {
  data() {
    return {
      camera: null,
      scene: null,
      renderer: null,
      mesh: null,
      controls: null,
    };
  },
  mounted() {
    this.initScene();
    this.initCamera();
    this.CreateGemotrys();
    this.initRender();
    this.initControls();
    this.animate();
  },
  methods: {
    initScene() {
      this.container = document.getElementById("container");
      this.scene = new THREE.Scene();
    },
    initCamera() {
      this.camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        1,
        1100
      );
      this.camera.target = new THREE.Vector3(0, 0, 0);

      this.camera.position.z = 0.01;
    },
    CreateGemotrys(data) {
      var geometry = new THREE.SphereBufferGeometry(500, 60, 40); // 圆球
      geometry.scale(-1, 1, 1);
      let url = data ? "static/"+data+".jpg" :"static/room2.jpg";

      var texture = new THREE.TextureLoader().load(url);
      var material = new THREE.MeshBasicMaterial({ map: texture });
      this.mesh = new THREE.Mesh(geometry, material);
      this.scene.add(this.mesh);
    },
    initRender() {
      this.renderer = new THREE.WebGLRenderer();
      this.renderer.setPixelRatio(window.devicePixelRatio);
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.container.appendChild(this.renderer.domElement);

      window.addEventListener("resize", this.onWindowResize, false);
    },
    initControls() {
      this.controls = new OrbitControls(this.camera, this.container); // 创建控件对象
      this.controls.enableZoom = true;
      this.controls.zoomSpeed=3;
      this.controls.enablePan = true;
      this.controls.autoRotate = true;
      this.controls.enableDamping = true;
      this.controls.rotateSpeed = 0.05;
        //设置相机距离原点的最近距离
        this.controls.minDistance  = 1;
        //设置相机距离原点的最远距离
        this.controls.maxDistance  = 5000;
   
    },
    onWindowResize() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
    },

    animate() {
      requestAnimationFrame(this.animate);
      this.controls.update();
      this.renderer.render(this.scene, this.camera);
    },
    change(data){
        this.CreateGemotrys(data)
    }
  },
};
</script>
<style>
.change-box {
  position: absolute;
  bottom: 10px;
  left: 20%;
  display: flex;
  justify-content: center;
  justify-items: center;
}
.room {
  width: 100px;
  height: 50px;
  line-height: 50px;
  margin:0 20px;
  border-radius: 10px;
  background: rgb(158, 155, 155);
  color: rgb(149, 45, 190);
  font-size: 26px;
}
</style>