<template>
  <div class="home">
    <div class="canvas-container" id="canvasDom"></div>
    <div class="choose">
      <div>车身颜色选择：</div>
      <div class="choose-list">
        <div
          class="item"
          v-for="item in colorList"
          :key="item"
          :style="{ background: item }"
          @click="setCarColor(item)"
        ></div>
      </div>
    </div>
    <div class="zy">
      <div>座椅颜色：</div>
      <div class="zy-list">
        <div
          class="zy-item"
          v-for="item in zyList"
          :key="item"
          :style="{ background: item }"
          @click="setCarZy(item)"
        ></div>
      </div>
    </div>
    <div class="move" @click="onDocumentMouseDown">
      切换视角
    </div>
    <div>
      打开车门
    </div>
  </div>
</template>

<script>
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";
import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader";
import { DRACOLoader } from "three/examples/jsm/loaders/DRACOLoader";
import * as TWEEN from "tween.js";

/*****
 * wheel 轮毂 leather 座椅 interior_light 、
 * grills内饰 glass 挡风玻璃 chrome 车标/后视镜 carpet 脚垫 bre_trim控制器
 * brakes 尾灯 body 车衣 tire车胎 , carGlass,carLeather ,
 * **/
let arr = [];
let carBody, carTire, carWheel, carGlass, carChrome;

const carBodyMat = new THREE.MeshPhysicalMaterial({
  color: 0xff0000,
  metalness: 1,
  roughness: 0.5,
  clearcoat: 1,
  clearcoatRoughness: 0,
});
const carTireMat = new THREE.MeshPhysicalMaterial({
  color: 0x000000,
  metalness: 1,
  roughness: 0.5,
  // transimission:1
});
const carOtherMat = new THREE.MeshPhysicalMaterial({
  color: 0x000000,
  metalness: 1,
  roughness: 0.5,
});
const carGlassMat = new THREE.MeshPhysicalMaterial({
  color: 0xffffff,
  metalness: 0,
  roughness: 0,
  transmission: 1,
  transparent: true,
});
const carChromeMat = new THREE.MeshPhysicalMaterial({
  color: 0xffee,
  metalness: 0,
  roughness: 0,
  transmission: 1,
  transparent: true,
});

export default {
  data() {
    return {
      camera: null,
      scene: null,
      renderer: null,
      controls: null,
      gridHelper: null,
      fll: null,
      colorList: ["green", "gray", "orange", "purple"],
      zyList: ["black", "darkred"],
    };
  },
  mounted() {
    this.init();
    this.initMesh();
    document.addEventListener("click", this.onDocumentMouseDown, false);
  },
  methods: {
    init() {
      this.scene = new THREE.Scene();
      this.camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
      );
      this.camera.position.set(0, 2, 6);
      this.renderer = new THREE.WebGLRenderer({
        antialias: true,
      });
      this.renderer.setSize(window.innerWidth, window.innerHeight);
    },

    initMesh() {
      const canvasDom = document.getElementById("canvasDom");
      canvasDom.appendChild(this.renderer.domElement);

      this.renderer.setClearColor("#000");
      this.scene.background = new THREE.Color("#ccc");
      this.scene.environment = new THREE.Color("#ccc");

      // 添加网格
      this.gridHelper = new THREE.GridHelper(20, 20);
      this.gridHelper.material.opacity = 0.2;
      this.gridHelper.material.transparent = true;
      this.scene.add(this.gridHelper);

      this.controls = new OrbitControls(this.camera, this.renderer.domElement);
      this.controls.update();

      // 添加汽车模型
      const loader = new GLTFLoader();
      const dracoLoader = new DRACOLoader();
      // 设置解压库文件路径的补充
      dracoLoader.setDecoderPath("/static/libs/gltf/");
      loader.setDRACOLoader(dracoLoader);
      loader.load("/static/models/car/ferrari.glb", (glft) => {
        this.fll = glft.scene;
        this.fll.rotation.y = Math.PI - 12;
        this.fll.traverse((child) => {
          if (child.isMesh) {
            console.log(child.name, "name====");
          }
          // wheel 轮毂 leather 座椅 interior_light 、grills内饰 glass 挡风玻璃 chrome 车标/后视镜 carpet 脚垫 bre_trim控制器
          // brakes 尾灯 body 车衣 tire车胎
          // child.name.includes('trim')
          if (child.isMesh && child.name.includes("body")) {
            // body
            carBody = child;
            carBody.material = carBodyMat;
          }
          if (child.isMesh && child.name.includes("tire")) {
            carTire = child;
            carTire.material = carTireMat;
            arr.push(child);
          }
          if (child.isMesh && child.name.includes("wheel")) {
            carWheel = child;
            carWheel.material = carTireMat;
            arr.push(child);
          }
          if (
            (child.isMesh && child.name.includes("glass")) ||
            child.name.includes("brakes") ||
            child.name.includes("bre_trim")
          ) {
            child.material = carGlassMat;
            carGlass = child;
            carGlass.material = carGlassMat;
          }
          if (child.isMesh && child.name.includes("chrome")) {
            carChrome = child;
            carChrome.material = carChromeMat;
          }
          if (
            (child.isMesh && child.name.includes("leather")) ||
            child.name.includes("interior_light") ||
            child.name.includes("lights_red") ||
            child.name.includes("grills") ||
            child.name.includes("carpet") ||
            child.name.includes("bre_trim")
          ) {
            child.material = carOtherMat;
          }
        });
        this.scene.add(this.fll);
      });

      // 添加灯光
      const light1 = new THREE.DirectionalLight(0xffffff, 1);
      light1.position.set(0, 0, 10);
      this.scene.add(light1);
      const light2 = new THREE.DirectionalLight(0xffffff, 1);
      light2.position.set(0, 0, -10);
      this.scene.add(light2);
      const light3 = new THREE.DirectionalLight(0xffffff, 1);
      light3.position.set(10, 0, 0);
      this.scene.add(light3);
      const light4 = new THREE.DirectionalLight(0xffffff, 1);
      light4.position.set(-10, 0, 0);
      this.scene.add(light4);
      const light5 = new THREE.DirectionalLight(0xffffff, 1);
      light5.position.set(0, 10, 0);
      this.scene.add(light5);
      this.render();
    },

    render() {
      // 车轮模拟滚动
      const time = -performance.now() / 1000;
      for (let i = 0; i < arr.length; i++) {
        arr[i].rotation.x = time * Math.PI * 2;
      }

      // 网格移动 与 车轮模拟滚动 ，从而制造车子向前移动的效果
      this.gridHelper.position.z = time % 1;

      this.renderer.render(this.scene, this.camera);
      this.controls && this.controls.update();
      requestAnimationFrame(this.render);
    },
    onWindowResize() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
    },

    setCarColor(e) {
      carBodyMat.color.set(e);
    },
    setCarZy(e) {
      carOtherMat.color.set(e);
    },
    // 切换视角
    onDocumentMouseDown(event) {
      // 点击屏幕创建一个向量
      var vector = new THREE.Vector3(
        (event.clientX / window.innerWidth) * 2 - 1,
        -(event.clientY / window.innerHeight) * 2 + 1,
        0.5
      );
      vector = vector.unproject(this.camera); // 将屏幕的坐标转换成三维场景中的坐标
      var raycaster = new THREE.Raycaster(
        this.camera.position,
        vector.sub(this.camera.position).normalize()
      );
      var intersects = raycaster.intersectObjects(this.scene.children, true);

      console.log(intersects, "intersects点击对象");
      if (intersects.length > 0) {
        // 随机坐标
        var x = Math.round(Math.random() * 100);
        var y = Math.round(Math.random() * 100);
        var z = 50;

        var x2 = Math.round(Math.random() * 50);
        var y2 = Math.round(Math.random() * 50);
        var z2 = 5;

        var pos = new THREE.Vector3(x, y, z);
        var pos2 = new THREE.Vector3(x2, y2, z2);
        intersects[0].object.material.color.set("#00aa00");
        this.animateCamera(
          this.camera.position,
          pos,
          this.controls.target,
          pos2
        );
      }
    },
    // 补间动画
    // current1 相机当前的位置
    // target1 相机的目标位置
    // current2 当前的controls的target
    // target2 新的controls的target
    animateCamera(current1, target1, current2, target2) {
      console.log(current1, "current1====");
      var tween = new TWEEN.Tween({
        x1: current1.x, // 相机当前位置x
        y1: current1.y, // 相机当前位置y
        z1: current1.z, // 相机当前位置z
        x2: current2.x, // 控制当前的中心点x
        y2: current2.y, // 控制当前的中心点y
        z2: current2.z, // 控制当前的中心点z
      });
      tween.to(
        {
          x1: target1.x, // 新的相机位置x
          y1: target1.y, // 新的相机位置y
          z1: target1.z, // 新的相机位置z
          x2: target2.x, // 新的控制中心点位置x
          y2: target2.y, // 新的控制中心点位置x
          z2: target2.z, // 新的控制中心点位置x
        },
        1000
      );
      tween.onUpdate(() => {
        this.camera.position.x = this.x1;
        this.camera.position.y = this.y1;
        this.camera.position.z = this.z1;
        this.controls.target.x = this.x2;
        this.controls.target.y = this.y2;
        this.controls.target.z = this.z2;
        this.controls.update();
      });
      tween.easing(TWEEN.Easing.Cubic.InOut);
      tween.start();
    },

    // 获取与射线相交的对象数组
    onChangeDoor(event) {
      event.preventDefault();
      //1、先基于我们在屏幕上点击的位置创建一个向量
      var vector = new THREE.Vector3(
        (event.clientX / window.innerWidth) * 2 - 1,
        -(event.clientY / window.innerHeight) * 2 + 1,
        0.5
      );
      //2、然后用unproject函数将点击位置转换成Thres.js场景中的坐标
      vector = vector.unproject(this.camera);
      //3、用THREE.Raycaster对象向点击位置发射光线
      var raycaster = new THREE.Raycaster(
        this.camera.position,
        vector.sub(this.camera.position).normalize()
      );
      var intersects = raycaster.intersectObjects(this.scene.children, true);

      var currObj = intersects[0].object; //currObj为点击到的第一个对象

      console.log(currObj, "点击到的第一个对象");
      if (currObj.parent.rotation.y == 0) {
        new TWEEN.Tween(currObj.parent.rotation)
          .to(
            {
              y: 1.5,
            },
            1500
          )
          .start();
      } else {
        new TWEEN.Tween(currObj.parent.rotation)
          .to(
            {
              y: 0,
            },
            300
          )
          .start();
      }
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
.choose {
  color: black;
  position: absolute;
  top: 20px;
  width: 200px;
  left: 20px;
  font-size: 18px;
  font-weight: 600;
}
.choose-list {
  display: flex;
  justify-content: space-evenly;
  margin-left: 60px;
  margin-top: 10px;
}
.item {
  width: 30px;
  height: 30px;
  margin-left: 5px;
  border-radius: 5px;
}
.zy {
  color: black;
  position: absolute;
  top: 100px;
  width: 200px;
  left: 20px;
  font-size: 18px;
  font-weight: 600;
}
.zy-list {
  display: flex;
  justify-content: space-evenly;
  margin-left: 60px;
  margin-top: 10px;
}
.zy-item {
  width: 30px;
  height: 30px;
  margin-left: 5px;
  border-radius: 5px;
}

.move {
  color: black;
  position: absolute;
  top: 200px;
  width: 200px;
  left: 20px;
  font-size: 18px;
  font-weight: 600;
}
</style>
