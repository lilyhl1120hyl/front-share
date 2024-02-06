<template>
  <div>
    <div id="container"></div>
  </div>
</template>

<script>
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
import { ImprovedNoise } from "three/examples/jsm/math/ImprovedNoise.js";
// import ThreeBSP from "../libs/ThreeBSP.js";
// import { ColladaLoader } from "three/examples/jsm/loaders/ColladaLoader.js";
// import { TDSLoader } from "three/examples/jsm/loaders/TDSLoader.js";
import { MTLLoader } from "three/examples/jsm/loaders/MTLLoader.js";
import { OBJLoader } from "three/examples/jsm/loaders/OBJLoader.js";
import { FBXLoader } from "three/examples/jsm/loaders/FBXLoader.js";

import {
  CSS3DObject,
  CSS3DRenderer,
} from "three/examples/jsm/renderers/CSS3DRenderer.js";

import * as TWEEN from "tween.js";

const zoom = 2;
const vechicleColors = [0xa52523, 0xbdb638, 0x78b14b];

const carFrontTexture = new Texture(40, 80, [{ x: 0, y: 10, w: 30, h: 60 }]);
const carBackTexture = new Texture(40, 80, [{ x: 10, y: 10, w: 30, h: 60 }]);
const carRightSideTexture = new Texture(110, 40, [
  { x: 10, y: 0, w: 50, h: 30 },
  { x: 70, y: 0, w: 30, h: 30 },
]);
const carLeftSideTexture = new Texture(110, 40, [
  { x: 10, y: 10, w: 50, h: 30 },
  { x: 70, y: 10, w: 30, h: 30 },
]);

const truckFrontTexture = new Texture(30, 30, [{ x: 15, y: 0, w: 10, h: 30 }]);
const truckRightSideTexture = new Texture(25, 30, [
  { x: 0, y: 15, w: 10, h: 10 },
]);
const truckLeftSideTexture = new Texture(25, 30, [
  { x: 0, y: 5, w: 10, h: 10 },
]);

// 生成canvas的贴图
function Texture(width, height, rects) {
  const canvas = document.createElement("canvas");
  canvas.width = width;
  canvas.height = height;
  const context = canvas.getContext("2d");
  context.fillStyle = "#ffffff";
  context.fillRect(0, 0, width, height);
  context.fillStyle = "rgba(0,0,0,0.6)";
  rects.forEach((rect) => {
    context.fillRect(rect.x, rect.y, rect.w, rect.h);
  });
  return new THREE.CanvasTexture(canvas);
}

export default {
  data() {
    return {
      camera: null,
      scene: null,
      renderer: null,
      mesh: null,
      controls: null,
      objectModal: null,
      Option: null,
      css3DRenderer: null,
    };
  },
  mounted() {
    this.initScene();
    this.initCamera();
    this.initLight();
    this.CreateGemotrys();

    this.initRender();
    this.initControls();
    this.animate();
  },
  methods: {
    initScene() {
      this.container = document.getElementById("container");
      this.scene = new THREE.Scene();
      this.scene.background = new THREE.Color(0xffffff); // 背景色
      // this.scene.fog = new THREE.Fog(0xffffff, 0.015, 300); //雾化效果
    },
    initCamera() {
      this.camera = new THREE.PerspectiveCamera(
        45,
        window.innerWidth / window.innerHeight,
        1,
        1100
      );
      this.camera.position.set(0, 100, 500);
      this.camera.lookAt(this.scene.position);
    },
    initLight() {
      //添加灯光
      const pointLight = new THREE.PointLight(0xffffff, 2, 0);
      pointLight.position.set(0, 170, 200);
      this.scene.add(pointLight);
      //灯光辅助
      const sphereSize = 1;
      const pointLightHelper = new THREE.PointLightHelper(
        pointLight,
        sphereSize
      );
      this.scene.add(pointLightHelper);
    },
    CreateGemotrys() {
      this.createPlane();
      this.createRold();
      this.createMounten();
      this.createTrees();
      this.createpalmTree();
      this.createFloat();
    },

    // 创建平面
    createPlane() {
      const planeGeometry = new THREE.PlaneGeometry(500, 500);
      const planeMaterial = new THREE.MeshLambertMaterial({ color: 0x008844 });
      const plane = new THREE.Mesh(planeGeometry, planeMaterial);
      //水平面旋转并且设置位置
      plane.rotation.x = -0.5 * Math.PI;
      plane.position.set(0, 0, 0);
      this.scene.add(plane);
    },

    // 创建道路,路灯
    createRold() {
      /**
       * 道路
       */
      var shape = new THREE.Shape();
      /**四条直线绘制一个矩形轮廓*/
      shape.moveTo(0, 0); //起点
      shape.lineTo(0, 14); //第2点
      shape.lineTo(1, 14); //第3点
      shape.lineTo(1, 0); //第4点
      shape.lineTo(0, 0); //第5点

      /**创建轮廓的扫描轨迹(3D样条曲线)*/
      var curve = new THREE.CatmullRomCurve3([
        new THREE.Vector3(200, 1, -250),
        new THREE.Vector3(10, 1, 0),
        new THREE.Vector3(8, 2, 50),
        new THREE.Vector3(20, 1, 250),
      ]);
      var geometry = new THREE.ExtrudeGeometry( //拉伸造型
        shape, //二维轮廓
        //拉伸参数
        {
          bevelEnabled: false, //无倒角
          extrudePath: curve, //选择扫描轨迹
          steps: 50, //扫描方向细分数
        }
      );
      var material = new THREE.MeshPhongMaterial({ color: 0x454a59 }); //材质对象
      var mesh = new THREE.Mesh(geometry, material); //扫描网格模型对象
      this.scene.add(mesh); //扫描网格模型添加到场景中

      /***路灯 */
      const roadLight = new THREE.Group();
      var radius = 1; // 管子的半径
      const shape2 = new THREE.Shape();
      shape2.absarc(0, 0, radius, 0, Math.PI * 2, false);
      var material2 = new THREE.MeshBasicMaterial({ color: 0xcccccc });

      var path = new THREE.CatmullRomCurve3([
        new THREE.Vector3(8, 0, 0),
        new THREE.Vector3(8, 50, 0),
        new THREE.Vector3(13, 55, 0),
        new THREE.Vector3(18, 50, 0),
      ]);

      var extrudeSettings = {
        bevelEnabled: false,
        steps: 50,
        extrudePath: path,
      };

      var geometry2 = new THREE.ExtrudeGeometry(shape2, extrudeSettings);
      var mesh2 = new THREE.Mesh(geometry2, material2);

      roadLight.add(mesh2);

      var sunMesh = new THREE.Mesh(
        new THREE.SphereGeometry(4, 10, 20),
        new THREE.MeshLambertMaterial({
          //加载太阳纹理
          emissiveMap: new THREE.TextureLoader().load("/static/sun.jpg"),
          //球体亮度，颜色越灰，球体越暗
          emissive: 0xffffff,
        })
      );
      sunMesh.position.set(18, 50, 0);
      roadLight.add(sunMesh);
      this.scene.add(roadLight);

      var roadLight2 = roadLight.clone();
      roadLight2.position.set(66, 0, -100);
      this.scene.add(roadLight2);

      var roadLight3 = roadLight.clone();
      roadLight3.position.set(150, 0, -200);
      this.scene.add(roadLight3);

      var roadLight4 = roadLight.clone();
      roadLight4.position.set(-1, 0, 100);
      this.scene.add(roadLight4);

      var roadLight5 = roadLight.clone();
      roadLight5.position.set(7, 0, 200);
      this.scene.add(roadLight5);
    },

    // 创建树， 小湖
    createTrees() {
      let treeList = [];
      for (let i = 1; i < 20; i++) {
        const rCode = i + Math.floor(Math.random() * 10);
        const hCode = i + Math.floor(Math.random() * 30);
        const tree = this.createTree(rCode, hCode);
        treeList.push(tree);
        this.scene.add(tree);
      }
      if (treeList.length > 0) {
        treeList[0].position.set(-100, 4, -200);
        treeList[1].position.set(-1, 0, -200);
        treeList[2].position.set(-45, 0, -20);
        treeList[3].position.set(-100, 0, -60);
        treeList[4].position.set(-16, 0, -23);
        treeList[5].position.set(-67, 2, -244);
        treeList[6].position.set(-123, 3, -200);
        treeList[7].position.set(-21, 0, -45);
        treeList[8].position.set(-89, 3, -67);
        treeList[9].position.set(-23, 0, -200);
        treeList[10].position.set(-126, 0, -45);
        treeList[11].position.set(-234, 4, -223);
        treeList[12].position.set(-230, 4, -132);
        treeList[13].position.set(-5, 0, -144);
        treeList[14].position.set(-78, 0, -156);
        treeList[15].position.set(-98, 0, -99);
        treeList[16].position.set(-188, 4, -88);
        treeList[17].position.set(-68, 4, -199);
        treeList[18].position.set(-196, 6, -186);
      }
    },
    createTree(r, h) {
      const tree = new THREE.Group();
      var cylinder = new THREE.Mesh(
        new THREE.CylinderGeometry(0, r, h, 50, 50, false),
        new THREE.MeshNormalMaterial()
      );
      cylinder.overdraw = true;
      cylinder.position.y = h;
      tree.add(cylinder);
      var cylinder1 = new THREE.Mesh(
        new THREE.CylinderGeometry(1, 2, h, 32),
        new THREE.MeshBasicMaterial({ color: 0x886600 })
      );
      cylinder1.position.y = h / 2;
      tree.add(cylinder1);

      return tree;
    },
    // 创建山
    createMounten() {
      // width，height两个变量用控制平面几何体顶点数量
      // 行列两个方向顶点数量不同  显示效果不同   分别为100和250显示不同的效果
      var width = 80,
        height = 50;
      // 生成地形顶点高度数据
      var data = this.funZ(width, height);
      //创建一个平面地形，行列两个方向顶点数据分别为width，height
      var Mgeometry = new THREE.PlaneBufferGeometry(
        150,
        150,
        width - 1,
        height - 1
      );
      Mgeometry.rotateX(-Math.PI / 2);
      // 访问几何体的顶点位置坐标数据
      var vertices = Mgeometry.attributes.position.array;
      // 改变顶点高度值
      for (var i = 0, j = 0, l = vertices.length; i < l; i++, j += 3) {
        vertices[j + 1] = data[i] * 0.8;
      }
      // 不执行computeVertexNormals，没有顶点法向量数据
      Mgeometry.computeVertexNormals();
      var Mmaterial = new THREE.MeshLambertMaterial({
        color: 0x227700,
        side: THREE.DoubleSide,
      });
      var M_mesh = new THREE.Mesh(Mgeometry, Mmaterial);
      var B_mesh = new THREE.BoxGeometry(150, 20, 150);
      var B_cube = new THREE.Mesh(B_mesh, Mmaterial);
      M_mesh.position.set(-160, 0, -160);
      B_cube.position.set(-160, 0, -160);

      this.scene.add(M_mesh);
      this.scene.add(B_cube);
    },

    // 总的顶点数据量width * height
    funZ(width, height) {
      var size = width * height;
      var data = new Uint8Array(size);
      var perlin = new ImprovedNoise(); // 数学库
      // 控制地面显示效果  可以尝试0.01  0.1  1等不值
      // 0.1凹凸不平的地面效果  1山脉地形效果
      var quality = 0.3;
      // z值不同每次执行随机出来的地形效果不同
      var z = Math.random() * 100;
      for (var j = 0; j < 4; j++) {
        for (var i = 0; i < size; i++) {
          // x的值0 1 2 3 4 5 6...
          var x = i % width;
          // ~表示按位取反 两个~就是按位取反后再取反
          // ~~相当于Math.floor(),效率高一点
          // y重复若干个值
          var y = ~~(i / width);
          // 通过噪声生成数据
          data[i] += Math.abs(
            perlin.noise(x / quality, y / quality, z) * quality * 1.75
          );
          console.log(y);
        }
        // 循环执行的时候，quality累乘  乘的系数是1  显示效果平面
        quality *= 5;
      }

      return data;
    },

    createpalmTree() {
      var geometry1 = new THREE.BoxGeometry(0.35, 1.5, 0.25);
      geometry1.translate(0, 0.5, 0);
      var material1 = new THREE.MeshBasicMaterial({
        color: 0xffff00,
        transparent: true,
        opacity: 0,
      });
      var palmTree = new THREE.Mesh(geometry1, material1);

      var geometry2 = new THREE.CylinderGeometry(0.35, 0.45, 0.5, 6);
      var material2 = new THREE.MeshNormalMaterial({
        color: 0x948c75,
      });
      var palmBase2 = new THREE.Mesh(geometry2, material2);
      palmTree.add(palmBase2);

      var geometry3 = new THREE.CylinderGeometry(0.2, 0.3, 0.5, 6);
      var palmBase3 = new THREE.Mesh(geometry3, material2);
      palmBase3.position.set(-0.025, 0.45, 0.0);
      palmBase3.rotation.set(0, 0, 0.15);
      palmTree.add(palmBase3);

      var geometry4 = new THREE.CylinderGeometry(0.05, 0.2, 0.5, 6);
      var palmBase4 = new THREE.Mesh(geometry4, material2);
      palmBase4.position.set(-0.15, 0.85, 0.0);
      palmBase4.rotation.set(0, 0, 0.35);
      palmTree.add(palmBase4);

      var geometry5 = new THREE.CylinderGeometry(0.015, 0.04, 0.25, 6);
      var palmTrunkTop = new THREE.Mesh(geometry5, material2);
      palmTrunkTop.position.set(-0.28, 1.15, 0.025);
      palmTrunkTop.rotation.set(0.25, 0.5, 0.5);
      palmTree.add(palmTrunkTop);

      //LEAVES
      var leafShape = new THREE.Shape();
      leafShape.quadraticCurveTo(0, 5.5, 10, 5.5);
      leafShape.quadraticCurveTo(0, -5.5, 0, 2);

      var extrudeSettings = {
        steps: 1,
        amount: 0.005,
        bevelEnabled: true,
        bevelThickness: 0.025,
        bevelSize: 0.5,
        bevelSegments: 0.5,
      };

      var geometry6 = new THREE.ExtrudeGeometry(leafShape, extrudeSettings);

      var material6 = new THREE.MeshToonMaterial({
        color: 0x0ca4a5,
      });
      var Leaf = new THREE.Mesh(geometry6, material6);
      Leaf.scale.set(0.085, 0.085, 1);
      Leaf.position.set(-1.05, 0.5, 0);
      Leaf.rotation.set(18.5, 2.5, 2);
      palmTree.add(Leaf);

      var pL = Leaf.clone();
      pL.position.set(0.3, 1.9, 0.15);
      pL.rotation.set(8.8, 0.5, 2);
      palmTree.add(pL);

      var pL1 = Leaf.clone();
      pL1.position.set(0.1, 0.8, 1.05);
      pL1.rotation.set(-0.85, -3.5, 0.5);
      palmTree.add(pL1);
      palmTree.scale.set(15, 25, 15);

      const palmTreeGroup = new THREE.Group();
      palmTreeGroup.add(palmTree);
      palmTreeGroup.position.set(35, 0, 0);
      this.scene.add(palmTreeGroup);

      let palmTree1 = palmTreeGroup.clone();
      palmTree1.position.set(30, 0, 70);
      this.scene.add(palmTree1);

      let palmTree2 = palmTreeGroup.clone();
      palmTree2.position.set(33, 0, 140);
      this.scene.add(palmTree2);

      let palmTree3 = palmTreeGroup.clone();
      palmTree3.position.set(40, 0, 220);
      this.scene.add(palmTree3);

      let palmTree4 = palmTreeGroup.clone();
      palmTree4.position.set(80, 0, -70);
      this.scene.add(palmTree4);

      let palmTree5 = palmTreeGroup.clone();
      palmTree5.position.set(140, 0, -140);
      this.scene.add(palmTree5);

      let palmTree6 = palmTreeGroup.clone();
      palmTree6.position.set(206, 0, -220);
      this.scene.add(palmTree6);
    },

    // 模型加载汽车， 办公楼
    createFloat() {
      this.loadObj(); // 小车模型
      this.createTip();
      this.loadFBX();
      // this.loadBuilding();
      this.carPlane(); // 停车场
      this.createBuilding();
     
    },

    // 加载模型obj+mtl
    loadObj() {
      let manager = new THREE.LoadingManager();
      new MTLLoader(manager).load(
        "/static/models/greenCar/Huracan.mtl",
        (materials) => {
          materials.preload();
          console.log(materials,' 材质------')
          new OBJLoader(manager)
            .setMaterials(materials)
            .load("/static/models/greenCar/Huracan.obj", (obj) => {
              //初始展示的模型的缩放比例
                console.log(obj,'obj模型------')
              obj.scale.set(0.1, 0.1, 0.1);
              obj.rotation.x = -0.5 * Math.PI;
              obj.position.set(15, 1, 5);
              this.scene.add(obj);
              // this.transForm(obj, 100);
            });
        }
      );
    },

    // fbx静态模型
    loadFBX() {
      let manager = new THREE.LoadingManager();
      var fbx_loader = new FBXLoader(manager);

      fbx_loader.load("/static/models/miku/miku.fbx", (object) => {
        object.scale.multiplyScalar(0.02);
        object.position.set(15, 1, 15);
        console.log(object, "fbx000--------------");
        this.scene.add(object);
        // this.transForm(object, 100);
      });
    },

    // 加载模型obj+mtl
    loadBuilding() {
      let manager = new THREE.LoadingManager();
      new MTLLoader(manager).load(
        "/static/models/building/building_01.mtl",
        (materials) => {
          materials.preload();
          new OBJLoader(manager)
            .setMaterials(materials)
            .load("/static/models/building/building_01.obj", (obj) => {
              obj.position.set(125, 1, 25);
              this.objectModal = obj;
              this.scene.add(obj);

              let building1 = this.objectModal.clone();
              building1.position.set(125, 1, 115);
              this.scene.add(building1);

              let building2 = this.objectModal.clone();
              building2.position.set(125, 1, 205);
              this.scene.add(building2);

              let building3 = this.objectModal.clone();
              building3.position.set(-115, 1, 205);
              this.scene.add(building3);

              let building4 = this.objectModal.clone();
              building4.position.set(-115, 1, 115);
              this.scene.add(building4);

              let building5 = this.objectModal.clone();
              building5.position.set(-115, 1, 25);
              this.scene.add(building5);
            });
        }
      );
    },
    // 办公楼
    createBuilding() {
      const buildingGroup = new THREE.Group();
      const B_building_geometry = new THREE.BoxGeometry(80, 7, 35);
      const mapTrue = new THREE.TextureLoader().load("/static/window.jpg");
      var material = new THREE.MeshBasicMaterial({
        map: mapTrue,
        transparent: true,
        opacity: 0.9,
      });
      var material1 = new THREE.MeshBasicMaterial({
        color: 0x483d8b,
        transparent: true,
        opacity: 0.9,
      });
      var B_building = new THREE.Mesh(B_building_geometry, material1);

      buildingGroup.add(B_building);

      const L_building_geometry = new THREE.BoxGeometry(30, 100, 35);
      const L_building = new THREE.Mesh(L_building_geometry, material);

      L_building.position.set(-20, 54, 0);
      const R_building = L_building.clone();
      L_building.position.set(20, 54, 0);

      buildingGroup.add(L_building);
      buildingGroup.add(R_building);

      buildingGroup.position.set(125, 2, 30);

      const building1 = buildingGroup.clone();
      building1.position.set(125, 2, 110);

      const building2 = buildingGroup.clone();
      building2.position.set(125, 2, 180);

      const building3 = buildingGroup.clone();
      building3.position.set(-100, 2, 30);

      const building4 = buildingGroup.clone();
      building4.position.set(-100, 2, 110);

      const building5 = buildingGroup.clone();
      building5.position.set(-100, 2, 180);

      this.scene.add(buildingGroup);
      this.scene.add(building1);
      this.scene.add(building2);
      this.scene.add(building3);
      this.scene.add(building4);
      this.scene.add(building5);
    },
    transForm(obj, delay) {
      console.log(obj.position, "obj.position----");
      this.Option = obj.position;
      this.objectModal = obj;
      new TWEEN.Tween(this.Option)
        .to(
          {
            x: Math.random() * 140 - 20,
            y: 0,
            z: Math.random() * 140 - 20,
          },
          1000
        )
        .onUpdate(() => {
          console.log(this.Option, "this.position----");
          this.objectModal.position.set(this.Option);
        })
        .onComplete(() => {
          console.log(
            this.objectModal.position,
            "this.objectModal.position---"
          );
          this.scene.add(this.objectModal);
        })
        .delay(delay)
        .start();
    },
    //  停车场
    carPlane() {
      [1, 2, 3, 4, 5, 6].map((item) => {
        const car = this.Car();
        const truck = this.Truck();
        car.position.set(-210, 0, -10 * item);
        truck.position.set(-180, 0, -10 * item);
        this.scene.add(car);
        this.scene.add(truck);
      });

      [1, 2, 3, 4, 5, 6].map((item) => {
        const car = this.Car();
        const truck = this.Truck();
        car.position.set(-230, 0, -10 * item);
        truck.position.set(-150, 0, -10 * item);
        this.scene.add(car);
        this.scene.add(truck);
      });
    },

    // 轮胎
    Wheel() {
      const wheel = new THREE.Mesh(
        new THREE.BoxBufferGeometry(12 * zoom, 33 * zoom, 12 * zoom),
        new THREE.MeshLambertMaterial({ color: 0x333333, flatShading: true })
      );
      wheel.position.z = 6 * zoom;
      return wheel;
    },
    // 小汽车
    Car() {
      const car = new THREE.Group();
      const color =
        vechicleColors[Math.floor(Math.random() * vechicleColors.length)];

      const main = new THREE.Mesh(
        new THREE.BoxBufferGeometry(60 * zoom, 30 * zoom, 15 * zoom),
        new THREE.MeshPhongMaterial({ color, flatShading: true })
      );
      main.position.z = 12 * zoom;
      main.castShadow = true;
      main.receiveShadow = true;
      car.add(main);

      const cabin = new THREE.Mesh(
        new THREE.BoxBufferGeometry(33 * zoom, 24 * zoom, 12 * zoom),
        [
          new THREE.MeshPhongMaterial({
            color: 0xcccccc,
            flatShading: true,
            map: carBackTexture,
          }),
          new THREE.MeshPhongMaterial({
            color: 0xcccccc,
            flatShading: true,
            map: carFrontTexture,
          }),
          new THREE.MeshPhongMaterial({
            color: 0xcccccc,
            flatShading: true,
            map: carRightSideTexture,
          }),
          new THREE.MeshPhongMaterial({
            color: 0xcccccc,
            flatShading: true,
            map: carLeftSideTexture,
          }),
          new THREE.MeshPhongMaterial({ color: 0xcccccc, flatShading: true }), // top
          new THREE.MeshPhongMaterial({ color: 0xcccccc, flatShading: true }), // bottom
        ]
      );
      cabin.position.x = 6 * zoom;
      cabin.position.z = 25.5 * zoom;
      cabin.castShadow = true;
      cabin.receiveShadow = true;
      car.add(cabin);

      const frontWheel = this.Wheel();
      frontWheel.position.x = -18 * zoom;
      car.add(frontWheel);

      const backWheel = this.Wheel();
      backWheel.position.x = 18 * zoom;
      car.add(backWheel);

      car.castShadow = true;
      car.receiveShadow = false;

      car.rotation.x = -0.5 * Math.PI;
      car.scale.multiplyScalar(0.1);

      return car;
    },
    // 小卡车
    Truck() {
      const truck = new THREE.Group();
      const color =
        vechicleColors[Math.floor(Math.random() * vechicleColors.length)];
      const base = new THREE.Mesh(
        new THREE.BoxBufferGeometry(100 * zoom, 25 * zoom, 5 * zoom),
        new THREE.MeshLambertMaterial({ color: 0xb4c6fc, flatShading: true })
      );
      base.position.z = 10 * zoom;
      truck.add(base);

      const cargo = new THREE.Mesh(
        new THREE.BoxBufferGeometry(75 * zoom, 35 * zoom, 40 * zoom),
        new THREE.MeshPhongMaterial({ color: 0xb4c6fc, flatShading: true })
      );
      cargo.position.x = 15 * zoom;
      cargo.position.z = 30 * zoom;
      cargo.castShadow = true;
      cargo.receiveShadow = true;
      truck.add(cargo);

      const cabin = new THREE.Mesh(
        new THREE.BoxBufferGeometry(25 * zoom, 30 * zoom, 30 * zoom),
        [
          new THREE.MeshPhongMaterial({ color, flatShading: true }), // back
          new THREE.MeshPhongMaterial({
            color,
            flatShading: true,
            map: truckFrontTexture,
          }),
          new THREE.MeshPhongMaterial({
            color,
            flatShading: true,
            map: truckRightSideTexture,
          }),
          new THREE.MeshPhongMaterial({
            color,
            flatShading: true,
            map: truckLeftSideTexture,
          }),
          new THREE.MeshPhongMaterial({ color, flatShading: true }), // top
          new THREE.MeshPhongMaterial({ color, flatShading: true }), // bottom
        ]
      );
      cabin.position.x = -40 * zoom;
      cabin.position.z = 20 * zoom;
      cabin.castShadow = true;
      cabin.receiveShadow = true;
      truck.add(cabin);

      const frontWheel = this.Wheel();
      frontWheel.position.x = -38 * zoom;
      truck.add(frontWheel);

      const middleWheel = this.Wheel();
      middleWheel.position.x = -10 * zoom;
      truck.add(middleWheel);

      const backWheel = this.Wheel();
      backWheel.position.x = 30 * zoom;
      truck.add(backWheel);

      truck.rotation.x = -0.5 * Math.PI;
      truck.scale.multiplyScalar(0.1);

      return truck;
    },

    // 添加办公楼标签，并可以点击切换
    createTip() {
      this.addLabel("数据中心A").position.set(0, 50, 0);
      this.addLabel("数据中心B").position.set(-150, 50, -155);
      this.addLabel("融合通信大楼").position.set(150, 50, 155);
      this.addLabel("咪咕大楼").position.set(100, 50, -100);
      this.addLabel("A座").position.set(-100, 50, 100);
      this.addLabel("B座").position.set(-5, 70, 40);
      this.addLabel("停车场").position.set(180, 70, -180);
      console.log('标签---')

      this.css3DRenderer = new CSS3DRenderer();

      this.css3DRenderer.setSize(
        this.container.clientWidth,
        this.container.clientHeight
      );
      this.css3DRenderer.domElement.style.position = "absolute";
      this.css3DRenderer.domElement.style.top = 0;
      this.css3DRenderer.domElement.style.pointerEvents = "none";
      this.container.appendChild(this.css3DRenderer.domElement);
    },

    /** 创建一个 3d  -- 其大小会随镜头改变而改变  */
    addLabel(label) {
      var boxContainer = document.createElement("div");
      boxContainer.className = "element";
      boxContainer.style.backgroundColor =
        "rgba(0,127,127," + (Math.random() * 0.5 + 0.25) + ")";

      console.log(boxContainer, "boxContainer------");
      var details = document.createElement("div");
      details.className = "details";
      details.innerHTML = label;

      boxContainer.appendChild(details);

      const box = new THREE.Mesh(
        new THREE.BoxGeometry(1, 1, 1,),
        new THREE.MeshBasicMaterial({ transparent: true })
      );
      this.scene.add(box);
      const label3d = new CSS3DObject(boxContainer);
      box.add(label3d);
      box.scale.set(0.2, 0.2, 0.2); //我们可以通过控制box的大小来控制label3d的大小
      return box;
    },

    initRender() {
      this.renderer = new THREE.WebGLRenderer();
      this.renderer.setPixelRatio(window.devicePixelRatio);
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.container.appendChild(this.renderer.domElement);

      //坐标轴辅助
      const axes = new THREE.AxesHelper(100); //红x 绿y 蓝z
      this.scene.add(axes);

      window.addEventListener("resize", this.onWindowResize, false);
    },
    initControls() {
      this.controls = new OrbitControls(this.camera, this.container); // 创建控件对象
      this.controls.enableZoom = true;
      this.controls.zoomSpeed = 3;
      this.controls.enablePan = true;
      // this.controls.autoRotate = true;
      this.controls.enableDamping = true;
      this.controls.rotateSpeed = 0.05;
      //设置相机距离原点的最近距离
      this.controls.minDistance = 1;
      //设置相机距离原点的最远距离
      this.controls.maxDistance = 5000;
    },
    onWindowResize() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.css3DRenderer.setSize(window.innerWidth, window.innerHeight);
    },

    animate() {
      requestAnimationFrame(this.animate);
      this.controls.update();
      TWEEN.update();

      // webglRenderer
      this.renderer.render(this.scene, this.camera);

      //3dLabel
      this.css3DRenderer.render(this.scene, this.camera);
    },
  },
};
</script>
<style>
#container {
  width: 100%;
  height: 100%;
}
.room {
  width: 100px;
  height: 50px;
  line-height: 50px;
  margin: 0 20px;
  border-radius: 10px;
  background: rgb(158, 155, 155);
  color: rgb(149, 45, 190);
  font-size: 26px;
}
</style>