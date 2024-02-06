<template>
  <div class="car-container">
    <div id="container"></div>
    <div id="info-btn" class="box" @click="changeShua">切换手柄</div>
  </div>
</template>


<script>
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader.js";
import { DRACOLoader } from "three/examples/jsm/loaders/DRACOLoader.js";

export default {
  data() {
    return {
      camera: null,
      scene: null,
      renderer: null,
      grid: null,
      controls: null,
      showModel: null,
      count: 0,
    };
  },
  mounted() {
    this.init();
    this.initMesh();
    this.initShua();
  },
  methods: {
    init() {
      const container = document.getElementById("container");
      this.renderer = new THREE.WebGLRenderer({ antialias: true });
      this.renderer.setPixelRatio(window.devicePixelRatio);
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.renderer.setAnimationLoop(this.render);
      this.renderer.outputEncoding = THREE.sRGBEncoding;
      this.renderer.toneMapping = THREE.ACESFilmicToneMapping;
      this.renderer.toneMappingExposure = 0.85;
      container.appendChild(this.renderer.domElement);

      window.addEventListener("resize", this.onWindowResize);

      this.camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        1,
        1000
      );
      this.camera.position.set(2, -15, 10);
      this.camera.lookAt(0, 0, 0);
      this.camera.up.set(0, 0, 1);

      this.controls = new OrbitControls(this.camera, container);
      this.controls.target.set(0, 0.5, 0);
      this.controls.update();

      this.scene = new THREE.Scene();
      this.scene.background = new THREE.Color(0xeeeeee);

      this.scene.fog = new THREE.Fog(0xeeeeee, 1, 500);

      const light = new THREE.DirectionalLight(0xffffff, 2);
      light.position.set(25, 25, 25);
      this.scene.add(light);

      this.grid = new THREE.GridHelper(100, 40, 0x000000, 0x000000);
      this.grid.material.opacity = 0.1;
      this.grid.material.depthWrite = false;
      this.grid.material.transparent = true;
      this.grid.rotation.x = -Math.PI / 2;
      this.scene.add(this.grid);
    },

    initMesh() {
      const dracoLoader = new DRACOLoader();
      // 设置解压库文件路径的补充
      dracoLoader.setDecoderPath("/static/libs/gltf/");
      const loader = new GLTFLoader();
      loader.setDRACOLoader(dracoLoader);

      loader.load("/static/3dtest/mao.glb", (gltf) => {
        this.scene.add(gltf.scene);
      });
    },

    initShua(data) {
      // 先清除
      this.clearScene();
      const dracoLoader = new DRACOLoader();
      // 设置解压库文件路径的补充
      dracoLoader.setDecoderPath("/static/libs/gltf/");

      const loader = new GLTFLoader();
      loader.setDRACOLoader(dracoLoader);

      let path = data || "/static/3dtest/shoubing1.glb";

      // 再加载
      loader.load(path, (gltf) => {
        this.showModel = gltf;
        var group = new THREE.Group();
        group.name = "showModel";
        //把mesh1型插入到组group中，mesh1作为group的子对象
        group.add(this.showModel.scene);
        // 把层级模型放进场景
        this.scene.add(group);
      });

      console.log(this.scene, "场景中的数据");
    },

    changeShua() {
      let pathArray = [
        "/static/3dtest/shoubing1.glb",
        "/static/3dtest/shoubing2.glb",
        "/static/3dtest/shoubing3.glb",
      ];
      this.count += 1;
      if (this.count > 2) this.count = 0;
      let path = pathArray[this.count];
      this.initShua(path);
    },

    clearScene() {
      if (this.showModel) {
        this.scene.remove(this.showModel);
        this.scene.traverse((obj) => {
          if (obj.type === "Mesh") {
            obj.geometry.dispose();
            obj.material.dispose();
          }
        });
        // 根据name, 删除场景对象scene的子对象group
        this.scene.children.forEach((child) =>
          child.name == "showModel" ? this.scene.remove(child) : null
        );
        // 删除场景对象scene的子对象group ,不起作用
        this.scene.remove(this.scene.children.group);
      }
    },

    render() {
      this.renderer.render(this.scene, this.camera);
    },
    onWindowResize() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
    },
  },

  beforeDestroy() {
    this.renderer.forceContextLoss();
    this.renderer = null;
    this.scene = null;
    this.camera = null;
    this.controls = null;
  },
};
</script>

<style scoped>
.box {
  width: 200px;
  position: absolute;
  top: 10%;
  left: 40%;
  display: flex;
  justify-content: center;
  cursor: pointer;
  font-size: 26px;
  color: #2ac2d4;
}
.colorPicker {
  margin: 0 10px;
}
</style>