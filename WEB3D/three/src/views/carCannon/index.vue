<template>
  <div class="car-container">
    <div id="info" class="colorbox">
      <div class="colorPicker">
        <input id="body-color" type="color" value="#ff0000" /><br />Body
      </div>
      <div class="colorPicker">
        <input id="details-color" type="color" value="#ffffff" /><br />Details
      </div>
      <div class="colorPicker">
        <input id="glass-color" type="color" value="#ffffff" /><br />Glass
      </div>
    </div>

    <div id="container"></div>
  </div>
</template>


<script>
import * as THREE from "three";
import Stats from "three/examples/jsm/libs/stats.module.js";
import * as CANNON from "cannon";

import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
import { GUI } from "three/examples/jsm/libs/dat.gui.module";

import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader.js";
import { DRACOLoader } from "three/examples/jsm/loaders/DRACOLoader.js";

var vehicle;

export default {
  data() {
    return {
      camera: null,
      scene: null,
      renderer: null,
      stats: null,
      grid: null,
      controls: null,
      carMesh: null,
      wheels: [],
      meshes: [],
      bodies: [],
      size: 100,
      world: null,
      carBodySize: null,
      wheelRadius: 0.5,
      timeStep: 1 / 60,
      params: {
        maxForce: 1000,
        mass: 150,
        customSlidingRotationalSpeed: -30,
        dampingCompression: 4.4,
        dampingRelaxation: 2.3,
        engineForce: 0,
        forwardImpulse: 0,
        frictionSlip: 5,
        maxSuspensionForce: 100000,
        maxSuspensionTravel: 0.3,
        rollInfluence: 0.01,
        sideImpulse: 0,
        suspensionForce: 0,
        suspensionLength: 0,
        suspensionMaxLength: 1,
        suspensionRelativeVelocity: 1,
        suspensionRestLength: 0.3,
        suspensionStiffness: 30,
      },
    };
  },
  mounted() {
    this.init();
    this.initCannon();
    this.initGui();
    this.initShape();
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

      this.stats = new Stats();
      container.appendChild(this.stats.dom);

      this.camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        1,
        10000
      );
      this.camera.position.set(30, -15, 10);
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

      // materials
      const bodyMaterial = new THREE.MeshPhysicalMaterial({
        color: 0xff0000,
        metalness: 0.6, // 金属度属性
        roughness: 0.4, // 粗糙度
        clearcoat: 0.05,
        clearcoatRoughness: 0.05,
      });

      const detailsMaterial = new THREE.MeshStandardMaterial({
        color: 0xffffff,
        metalness: 1.0,
        roughness: 0.5,
      });

      const glassMaterial = new THREE.MeshPhysicalMaterial({
        color: 0xffffff,
        metalness: 0,
        roughness: 0.1,
        transmission: 0.9,
        transparent: true,
      });

      const bodyColorInput = document.getElementById("body-color");
      bodyColorInput.addEventListener("input", function () {
        bodyMaterial.color.set(this.value);
      });

      const detailsColorInput = document.getElementById("details-color");
      detailsColorInput.addEventListener("input", function () {
        detailsMaterial.color.set(this.value);
      });

      const glassColorInput = document.getElementById("glass-color");
      glassColorInput.addEventListener("input", function () {
        glassMaterial.color.set(this.value);
      });

      // Car model

      const dracoLoader = new DRACOLoader();
      // 设置解压库文件路径的补充
      dracoLoader.setDecoderPath("/static/libs/gltf/");

      const loader = new GLTFLoader();
      loader.setDRACOLoader(dracoLoader);

      loader.load("/static/models/car/ferrari.glb", (gltf) => {
        const carModel = gltf.scene.children[0];

        var bbox = new THREE.Box3().setFromObject(carModel);

        // const size = new THREE.Box3().setFromObject(model).getSize(new THREE.Vector3());
        var size = bbox.getSize(new THREE.Vector3());

        // ???  size 与 this.carBodySize
        console.log(size, "size----"); // Vector3{x: 2.25709247589112, y: 1.236010696714791, z: 4.533591027837245, isVector3: true}
        console.log(gltf, "gltf----");
        console.log(carModel, "carModel----");

        carModel.getObjectByName("body").material = bodyMaterial;

        carModel.getObjectByName("rim_fl").material = detailsMaterial;
        carModel.getObjectByName("rim_fr").material = detailsMaterial;
        carModel.getObjectByName("rim_rr").material = detailsMaterial;
        carModel.getObjectByName("rim_rl").material = detailsMaterial;
        carModel.getObjectByName("trim").material = detailsMaterial;

        carModel.getObjectByName("glass").material = glassMaterial;

        let main = carModel.getObjectByName("main").clone();
        let wheel_fr = carModel.getObjectByName("wheel_fr").clone();
        let wheel_fl = carModel.getObjectByName("wheel_fl").clone();
        let wheel_rr = carModel.getObjectByName("wheel_rr").clone();
        let wheel_rl = carModel.getObjectByName("wheel_rl").clone();

        this.carMesh = new THREE.Object3D();
        let frMesh = new THREE.Object3D();
        let flMesh = new THREE.Object3D();
        let rrMesh = new THREE.Object3D();
        let rlMesh = new THREE.Object3D();

        main.rotation.set(0, 0, Math.PI);
        main.position.y = -0;
        this.carMesh.add(main);

        wheel_fr.position.set(0, 0, 0);
        wheel_fr.rotation.set(0, 0, Math.PI / 2);
        frMesh.add(wheel_fr);

        wheel_fl.position.set(0, 0, 0);
        wheel_fl.rotation.set(0, 0, Math.PI / 2);
        flMesh.add(wheel_fl);

        wheel_rr.position.set(0, 0, 0);
        wheel_rr.rotation.set(0, 0, Math.PI / 2);
        rrMesh.add(wheel_rr);

        wheel_rl.position.set(0, 0, 0);
        wheel_rl.rotation.set(0, 0, Math.PI / 2);
        rlMesh.add(wheel_rl);

        this.scene.add(this.carMesh);
        this.scene.add(frMesh);
        this.scene.add(flMesh);
        this.scene.add(rrMesh);
        this.scene.add(rlMesh);

        this.wheels.push(frMesh, flMesh, rrMesh, rlMesh);
      });
    },
    initCannon() {
      //初始物理世界
      this.world = new CANNON.World(); //该方法初始化物理世界，里面包含着物理世界的相关数据（如刚体数据，世界中所受外力等等）
      this.world.quatNormalizeSkip = 0;
      this.world.quatNormalizeFast = false;
      this.world.gravity.set(0, 0, -9.8); //设置物理世界的重力为沿y轴向上-9.8米每二次方秒
      this.world.broadphase = new CANNON.NaiveBroadphase(); //NaiveBroadphase是默认的碰撞检测方式，该碰撞检测速度比较高
      this.world.solver.iterations = 10; //解算器的迭代次数，更高的迭代次数意味着更加精确同时性能将会降低
      this.world.defaultContactMaterial.friction = 0;

      this.carBodySize = new THREE.Vector3(4.52, 2.26, 1.08);  // ???
      //定义车体形状
      var chassisShape;
      //车体为一个矩形，立方体的参数是一个包含半长、半宽、半高的三维向量
      chassisShape = new CANNON.Box(
        new CANNON.Vec3(
          this.carBodySize.x / 2,
          this.carBodySize.y / 2,
          this.carBodySize.z / 2
        )
      );
      //定义车体刚体
      var chassisBody = new CANNON.Body({
        mass: 150, //刚体的质量，这里单位为kg
        material: new CANNON.Material({ friction: 0, restitution: 0 }), // 材质数据，里面规定了摩擦系数和弹性系数
      });
      //刚体中添加形状
      chassisBody.addShape(chassisShape);
      //初始化刚体的位置, 单位是米
      chassisBody.position.set(0, 0, 5);
      //设置一个初始的角速度
      chassisBody.angularVelocity.set(0, 0, 0.5);
      //初始化车辆引擎
      vehicle = new CANNON.RaycastVehicle({
        chassisBody: chassisBody,
        indexForwardAxis: 0,  
        indexRightAxis: 1,
        indexUpAxis: 2,    // 前轴索引0 = x，1 = y，2 = z
      });

      var options = {   // 参考源码 demos 下的文件
        radius: this.wheelRadius,
        directionLocal: new CANNON.Vec3(0, 0, -this.wheelRadius * 2),
        suspensionStiffness: 30,
        suspensionRestLength: 0.3,
        frictionSlip: 5,
        dampingRelaxation: 2.3,
        dampingCompression: 4.4,
        maxSuspensionForce: 100000,
        rollInfluence: 0.01,
        axleLocal: new CANNON.Vec3(0, 1, 0),
        chassisConnectionPointLocal: new CANNON.Vec3(1, 1, 0),
        maxSuspensionTravel: 0.3,
        customSlidingRotationalSpeed: -30,
        useCustomSlidingRotationalSpeed: true,
      };
      //设置第一个轮的位置，并将轮子信息添加到车辆类中
      options.chassisConnectionPointLocal.set(1.13, 0.95, -0.1);
      vehicle.addWheel(options);
      //设置第二个轮的位置，并将轮子信息添加到车辆类中
      options.chassisConnectionPointLocal.set(1.13, -0.95, -0.1);
      vehicle.addWheel(options);
      //设置第三个轮的位置，并将轮子信息添加到车辆类中
      options.chassisConnectionPointLocal.set(-1.47, 0.95, -0.05);
      vehicle.addWheel(options);
      //设置第四个轮的位置，并将轮子信息添加到车辆类中
      options.chassisConnectionPointLocal.set(-1.47, -0.95, -0.05);
      vehicle.addWheel(options);
      //通过addToWorld方法将将车辆及其约束添加到世界上。
      vehicle.addToWorld(this.world);

      document.onkeydown = this.handler;
      document.onkeyup = this.handler;

      setTimeout(() => {
        this.createMesh();
      }, 500);
    },

    createMesh() {
      // 创建刚性立方体
      for (let i = 0; i < 5; i++) {
        for (let j = 0; j < 3; j++) {
          let x = j * 8 - 8;
          let y = 10;
          let z = i * 3 + 1;
          let meshbox = new THREE.Mesh(
            new THREE.BoxBufferGeometry(8, 4, 2),
            new THREE.MeshPhongMaterial({ color: 0x6666666, flatShading: true })
          );
          let body = new CANNON.Body({
            mass: 5,
            position: new CANNON.Vec3(x, y, z),
            shape: new CANNON.Box(new CANNON.Vec3(4, 2, 1)),
            material: new CANNON.Material({ friction: 0.5, restitution: 0 }),
          });
          this.world.addBody(body);
          this.bodies.push(body);
          this.scene.add(meshbox);
          this.meshes.push(meshbox);
        }
      }
    },
    initShape() {
      //高度场的方法
      var matrix = [];
      for (var i = 0; i < this.size; i++) {
        matrix.push([]);
        for (var j = 0; j < this.size; j++) {
          var height =
            (Math.cos((i / this.size) * Math.PI * (this.size / 10)) *
              Math.cos((j / this.size) * Math.PI * (this.size / 10))) /
            2; //高度由两个余弦函数叠加形成
          matrix[i].push(height);
        }
      }
      console.log(matrix, "matrix-------");

      var hfShape = new CANNON.Heightfield(matrix, {
        elementSize: 1,
      });
      var hfBody = new CANNON.Body({
        mass: 0,
        material: new CANNON.Material({ friction: 0.5, restitution: 0 }),
      });
      //由于这个高度场是XOY平面第一象限上，所以需要旋转和平移，addShape方法为我们提供了这个功能。
      hfBody.addShape(
        hfShape,
        new CANNON.Vec3(-this.size / 2, -this.size / 2, 0), // offset Vec3
        new CANNON.Quaternion() // 四元数
      );

      this.world.addBody(hfBody);

      //使用ParametricBufferGeometry配合Heightfield形成网格
      var groundGeom = new THREE.ParametricBufferGeometry( // 参数化几何体 ,function :它接收0和1之间的u和v值，并修改第三个Vector3参
        (u, v, target) => {
          var height =
            (Math.cos(u * Math.PI * (this.size / 10)) *
              Math.cos(v * Math.PI * (this.size / 10))) /
            2;
          target.set(
            u * this.size - this.size / 2,
            v * this.size - this.size / 2,
            height
          );
        },
        this.size,
        this.size
      );
      let groundMate = new THREE.MeshPhongMaterial({
        color: 0x666666,
        side: THREE.DoubleSide,
      });
      const groundMesh = new THREE.Mesh(groundGeom, groundMate);
      this.scene.add(groundMesh);
    },
    initGui() {
      var gui = new GUI();

      gui.add(this.params, "maxForce", 0, 1000);
      gui
        .add(this.params, "customSlidingRotationalSpeed", -100, 100) // 旋转速度
        .onChange((e) => {
          for (let i = 0; i < vehicle.wheelInfos.length; i++) {
            vehicle.wheelInfos[i].customSlidingRotationalSpeed = e;
          }
        });
      gui.add(this.params, "dampingCompression", 0, 100).onChange((e) => {
        // 阻尼压缩
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].dampingCompression = e;
        }
      });
      gui.add(this.params, "dampingRelaxation", 0, 100).onChange((e) => {
        // 阻尼松弛
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].dampingRelaxation = e;
        }
      });
      gui.add(this.params, "engineForce", 0, 100).onChange((e) => {
        // 工程力
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].engineForce = e;
        }
      });
      gui.add(this.params, "frictionSlip", 0, 100).onChange((e) => {
        // 摩擦滑移
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].frictionSlip = e;
        }
      });
      gui.add(this.params, "maxSuspensionForce", 0, 10000).onChange((e) => {
        // 最大阻力
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].maxSuspensionForce = e;
        }
      });
      gui.add(this.params, "maxSuspensionTravel", 0, 10).onChange((e) => {
        // 最大悬浮阻力
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].maxSuspensionTravel = e;
        }
      });
      gui.add(this.params, "rollInfluence", 0, 10).onChange((e) => {
        //滚动影响
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].rollInfluence = e;
        }
      });
      gui.add(this.params, "sideImpulse", 0, 10).onChange((e) => {
        // 侧冲
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].sideImpulse = e;
        }
      });
      gui.add(this.params, "suspensionForce", 0, 10).onChange((e) => {
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].suspensionForce = e;
        }
      });
      gui.add(this.params, "suspensionLength", 0, 10).onChange((e) => {
        // 悬架长度
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].suspensionLength = e;
        }
      });
      gui.add(this.params, "suspensionMaxLength", 0, 10).onChange((e) => {
        //
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].suspensionMaxLength = e;
        }
      });
      gui
        .add(this.params, "suspensionRelativeVelocity", 0, 10) // 相对速度
        .onChange((e) => {
          for (let i = 0; i < vehicle.wheelInfos.length; i++) {
            vehicle.wheelInfos[i].suspensionRelativeVelocity = e;
          }
        });
      gui.add(this.params, "suspensionRestLength", 0, 10).onChange((e) => {
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].suspensionRestLength = e;
        }
      });
      gui.add(this.params, "suspensionStiffness", 0, 100).onChange((e) => {
        // 悬架刚度
        for (let i = 0; i < vehicle.wheelInfos.length; i++) {
          vehicle.wheelInfos[i].suspensionStiffness = e;
        }
      });
      // 自定义方法中 不支持 this
      gui.add(
        new (function () {
          this.reset = function () {
            vehicle.chassisBody.quaternion.set(0, 0, 0, 1);
            vehicle.chassisBody.velocity.setZero();
            vehicle.chassisBody.position.set(0, 0, 5);
            vehicle.chassisBody.angularVelocity.set(0, 0, 0.5);
          };
        })(),
        "reset"
      );
    },

    handler(event) {
      var up = event.type == "keyup";
      if (!up && event.type !== "keydown") {
        return;
      }

      vehicle.setBrake(0, 0);
      vehicle.setBrake(0, 1);
      vehicle.setBrake(0, 2);
      vehicle.setBrake(0, 3);

      var brakeForce = 1000000,
        maxSteerVal = 0.5;

      console.log("按键----", up, vehicle);

      switch (event.keyCode) {
        case 38: // 按下向前键时，通过applyEngineForce方法，设置车轮力以在每个步骤中施加在后车轮上
          vehicle.applyEngineForce(up ? 0 : -this.params.maxForce, 2);
          vehicle.applyEngineForce(up ? 0 : -this.params.maxForce, 3);
          break;

        case 40: // 同上
          vehicle.applyEngineForce(up ? 0 : this.params.maxForce, 2);
          vehicle.applyEngineForce(up ? 0 : this.params.maxForce, 3);
          break;

        case 66: // 刹车键b，通过setBrake方法，设置四个车轮的制动力
          vehicle.setBrake(brakeForce, 0);
          vehicle.setBrake(brakeForce, 1);
          vehicle.setBrake(brakeForce, 2);
          vehicle.setBrake(brakeForce, 3);
          break;

        case 39: // 按下右键，通过setSteeringValue方法，设置前轮转向值
          vehicle.setSteeringValue(up ? 0 : -maxSteerVal, 0);
          vehicle.setSteeringValue(up ? 0 : -maxSteerVal, 1);
          break;

        case 37: // 同上
          vehicle.setSteeringValue(up ? 0 : maxSteerVal, 0);
          vehicle.setSteeringValue(up ? 0 : maxSteerVal, 1);
          break;
      }
    },
    onWindowResize() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
    },

    render() {
      this.renderer.render(this.scene, this.camera);

      this.updatePhysics();

      this.stats.update();
    },
    updatePhysics() {
      this.world.step(this.timeStep);
      if (this.carMesh) {
        this.carMesh.position.copy(vehicle.chassisBody.position);
        this.carMesh.quaternion.copy(vehicle.chassisBody.quaternion);

        for (let i = 0; i < this.wheels.length; i++) {
          this.wheels[i].position.copy(
            vehicle.wheelInfos[i].worldTransform.position
          );
          this.wheels[i].quaternion.copy(
            vehicle.wheelInfos[i].worldTransform.quaternion
          );
        }
      }
      for (let i = 0; i < this.meshes.length; i++) {
        this.meshes[i].position.copy(this.bodies[i].position);
        this.meshes[i].quaternion.copy(this.bodies[i].quaternion);
      }
    },
  },

  beforeDestroy() {
    this.renderer.forceContextLoss();
    this.renderer = null;
    this.scene = null;
    this.camera = null;
    this.world = null;
    this.controls = null;
  },
};
</script>

<style scoped>
.colorbox {
  width: 200px;
  position: absolute;
  top: 0;
  left: 40%;
  display: flex;
  justify-content: center;
}
.colorPicker {
  margin: 0 10px;
}
</style>