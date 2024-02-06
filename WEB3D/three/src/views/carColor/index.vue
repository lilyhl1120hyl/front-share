<template>
  <div class="index">
    <div id="d">
      <div id="info">
        <a>多材质汽车</a>
        <span id="car_info">
          <span id="car_name"></span>
        </span>
      </div>

      <div id="buttons_cars" class="bwrap">
        <button size="mini" id="veyron"  style="margin:2px;" >布加迪威龙</button>
        <button size="mini" id="gallardo"  style="margin:2px;" >兰博基尼盖拉多</button>
        <button size="mini" id="f50"  style="margin:2px;" >法拉利F</button>
        <button size="mini" id="camaro"  style="margin:2px;" >雪佛兰卡马罗牌汽车</button>
      </div>

      <div id="buttons_materials" class="bwrap">
         <button v-for="(item,index) in showMaterials" :key="index" style="margin:2px;" @click="changeColor(item)">
           {{ item[0] }}
          </button>
      </div>
    </div>
  </div>
</template>

<script>
import "./index.css";
import { Detector } from "./Detector.js";
import * as THREE from "three";
import { MTLLoader } from "three/examples/jsm/loaders/MTLLoader.js";
import { OBJLoader } from "three/examples/jsm/loaders/OBJLoader.js";


if (!Detector.webgl) Detector.addGetWebGLMessage();


var CARS = {
  veyron: {
    name: "捷达",
    mtlUrl: "/static/obj/jieda/file.mtl",
    objUrl: "/static/obj/jieda/file.obj",
    author: "捷达",
    init_rotation: [ 0, 0, 0],
    scale: 150,
    init_material: 4,
    body_materials: [2],
    object: null,
    buttons: null,
    materials: null,
  },

  gallardo: {
    name: "兰博基尼盖拉多",
    mtlUrl: "/static/models/greenCar/Huracan.mtl",
    objUrl: "/static/models/greenCar/Huracan.obj",
    author: "<a>兰博基尼盖拉多</a>",
    init_rotation: [ -0.5 * Math.PI, 0, 0],
    scale: 5,
    init_material: 9,
    body_materials: [3],

    object: null,
    buttons: null,
    materials: null,
  },

  f50: {
    name: "法拉利F",
    mtlUrl: "/static/models/greenCar/Huracan.mtl",
    objUrl: "/static/models/greenCar/Huracan.obj",
    author: "<a>法拉利F</a>",
    init_rotation: [ -0.5 * Math.PI, 0, 0],
    scale: 6,
    init_material: 2,
    body_materials: [3, 6, 7, 8, 9, 10, 23, 24],

    object: null,
    buttons: null,
    materials: null,
  },

  camaro: {
    name: "雪佛兰卡马罗牌汽车",
     mtlUrl: "/static/obj/jieda/file.mtl",
    objUrl: "/static/obj/jieda/file.obj",
    author: "<a>雪佛兰卡马罗牌汽车</a>",
    init_rotation: [0.0, 0.0, 0.0 /*0, 1, 0*/],
    scale: 175,
    init_material: 0,
    body_materials: [0],

    object: null,
    buttons: null,
    materials: null,
  },
};

var container;

var camera, scene, renderer;
var cameraCube, sceneCube;

var m, mi;

var directionalLight, pointLight;

var  mouseY = 0;

export default {
  data() {
    return {
      msg: "",
      showMesh:null, // 当前显示的模型
      showMaterials:[],  //当前汽车显示的材质颜色
    };
  },
  mounted() {
    this.init();
    this.animate();
 
  },
  methods: {
    init() {
      container = document.createElement("div");
      document.body.appendChild(container);

      // CAMERAS

      camera = new THREE.PerspectiveCamera(
        70,
        window.innerWidth / window.innerHeight,
        1,
        100000
      );
      cameraCube = new THREE.PerspectiveCamera(
        70,
        window.innerWidth / window.innerHeight,
        1,
        100000
      );

      // SCENE

      scene = new THREE.Scene();
      sceneCube = new THREE.Scene();

      // LIGHTS

      var ambient = new THREE.AmbientLight(/*0x050505*/ 0xaaaaaa);
      scene.add(ambient);

      directionalLight = new THREE.DirectionalLight(0xffffff, 2);
      directionalLight.position.set(2, 1.2, 10).normalize();
      scene.add(directionalLight);

      directionalLight = new THREE.DirectionalLight(0xffffff, 1);
      directionalLight.position.set(-2, 1.2, -10).normalize();
      scene.add(directionalLight);

      pointLight = new THREE.PointLight( 0xffaa00, 2 );
			pointLight.position.set( 2000, 1200, 10000 );
			scene.add( pointLight );

      sceneCube.background = new THREE.CubeTextureLoader().load([
        "/static/textures/posx.jpg",
        "/static/textures/negx.jpg",
        "/static/textures/posy.jpg",
        "/static/textures/negy.jpg",
        "/static/textures/posz.jpg",
        "/static/textures/negz.jpg",
      ]);

      //

      renderer = new THREE.WebGLRenderer();
      renderer.setSize(window.innerWidth, window.innerHeight);

      container.appendChild(renderer.domElement);

      document.addEventListener("mousemove", this.onDocumentMouseMove, false);

// map为默认材质色，添加normalMap法线贴图产生凹凸视觉， 配合roughness数值产生高光。
// 材质代码：
// let map_d=new THREE.TextureLoader().load("常规贴图.jpg");
// let map_n=new THREE.TextureLoader().load("法线贴图.jpg");
// let material=new THREE.MeshStandardMaterial({
// map:map_d,
// normalMap:map_n,
// roughness:0.1
// });

      // common materials

      var mlib = {
        Orange: new THREE.MeshLambertMaterial({
          color: 0xff6600,
          ambient: 0xff2200,
          combine: THREE.MixOperation,
          reflectivity: 0.3,
        }),
        Blue: new THREE.MeshLambertMaterial({
          color: 0x001133,
          ambient: 0x001133,
          combine: THREE.MixOperation,
          reflectivity: 0.3,
        }),
        Red: new THREE.MeshLambertMaterial({
          color: 0x660000,
          ambient: 0x330000,
          combine: THREE.MixOperation,
          reflectivity: 0.25,
        }),
        Black: new THREE.MeshLambertMaterial({
          color: 0x000000,
          ambient: 0x000000,
          combine: THREE.MixOperation,
          reflectivity: 0.15,
        }),
        White: new THREE.MeshLambertMaterial({
          color: 0xffffff,
          ambient: 0x666666,
          combine: THREE.MixOperation,
          reflectivity: 0.25,
        }),

        Carmine: new THREE.MeshPhongMaterial({
          color: 0x770000,
          specular: 0xffaaaa,
          combine: THREE.MultiplyOperation,
        }),
        Gold: new THREE.MeshPhongMaterial({
          color: 0xaa9944,
          specular: 0xbbaa99,
          shininess: 50,
          combine: THREE.MultiplyOperation,
        }),
        Bronze: new THREE.MeshPhongMaterial({
          color: 0x150505,
          specular: 0xee6600,
          shininess: 10,
          combine: THREE.MixOperation,
          reflectivity: 0.25,
        }),
        Chrome: new THREE.MeshPhongMaterial({  //高光
          color: 0xffffff,
          specular: 0xffffff,
          combine: THREE.MultiplyOperation,
        }),

        "Orange metal": new THREE.MeshStandardMaterial({ // 凹凸贴图
          color: 0xaa9944,
          roughness:1,
        }),
        "Blue metal": new THREE.MeshStandardMaterial({
          color: 0x001133,
          roughness:0.5,
        }),
        "Red metal": new THREE.MeshStandardMaterial({
          color: 0x770000,
          roughness:1,
        }),
        "Green metal": new THREE.MeshStandardMaterial({
          color: 0x007711,
          roughness:1,
        }),
        "Black metal": new THREE.MeshStandardMaterial({
          color: 0x222222,
          roughness:1,
        }),

        "Pure chrome": new THREE.MeshLambertMaterial({ color: 0xffffff }),
        "Dark chrome": new THREE.MeshLambertMaterial({ color: 0x444444 }),
        "Darker chrome": new THREE.MeshLambertMaterial({ color: 0x222222 }),

        "Black glass": new THREE.MeshLambertMaterial({
          color: 0x101016,
          opacity: 0.975,
          transparent: true,
        }),
        "Dark glass": new THREE.MeshLambertMaterial({
          color: 0x101046,
          opacity: 0.25,
          transparent: true,
        }),
        "Blue glass": new THREE.MeshLambertMaterial({
          color: 0x668899,
          opacity: 0.75,
          transparent: true,
        }),
        "Light glass": new THREE.MeshBasicMaterial({
          color: 0x223344,
          opacity: 0.25,
          transparent: true,
          combine: THREE.MixOperation,
          reflectivity: 0.25,
        }),

        "Red glass": new THREE.MeshLambertMaterial({
          color: 0xff0000,
          opacity: 0.75,
          transparent: true,
        }),
        "Yellow glass": new THREE.MeshLambertMaterial({
          color: 0xffffaa,
          opacity: 0.75,
          transparent: true,
        }),
        "Orange glass": new THREE.MeshLambertMaterial({
          color: 0x995500,
          opacity: 0.75,
          transparent: true,
        }),

        "Orange glass 50": new THREE.MeshLambertMaterial({
          color: 0xffbb00,
          opacity: 0.5,
          transparent: true,
        }),
        "Red glass 50": new THREE.MeshLambertMaterial({
          color: 0xff0000,
          opacity: 0.5,
          transparent: true,
        }),

        "Fullblack rough": new THREE.MeshStandardMaterial({  // 凹凸度
          color: 0x000000 ,
          roughness:0.5
          }),
        "Black rough": new THREE.MeshStandardMaterial({ 
          color: 0x050505,
          roughness:0.5 
          }),
        "Darkgray rough": new THREE.MeshStandardMaterial({ 
          color: 0x090909 ,
          roughness:0.5
          }),
        "Red rough": new THREE.MeshStandardMaterial({ 
          color: 0x330500 ,
          roughness:0.5
          }),

        "Darkgray shiny": new THREE.MeshPhongMaterial({
          color: 0x000000,
          specular: 0x050505,
        }),
        "Gray shiny": new THREE.MeshPhongMaterial({
          color: 0x050505,
          shininess: 20,
        }),
      };

      // Gallardo materials

      CARS["gallardo"].materials = {
        body: [
          ["Orange", mlib["Orange"]],
          ["Blue", mlib["Blue"]],
          ["Red", mlib["Red"]],
          ["Black", mlib["Black"]],
          ["White", mlib["White"]],

          ["Orange metal", mlib["Orange metal"]],
          ["Blue metal", mlib["Blue metal"]],
          ["Green metal", mlib["Green metal"]],
          ["Black metal", mlib["Black metal"]],

          ["Carmine", mlib["Carmine"]],
          ["Gold", mlib["Gold"]],
          ["Bronze", mlib["Bronze"]],
          ["Chrome", mlib["Chrome"]],
        ],
      };

      m = CARS["gallardo"].materials;
      mi = CARS["gallardo"].init_material;

      CARS["gallardo"].mmap = {
        0: mlib["Pure chrome"], // wheels chrome
        1: mlib["Black rough"], // tire
        2: mlib["Black glass"], // windshield
        3: m.body[mi][1], // body
        4: mlib["Red glass"], // back lights
        5: mlib["Yellow glass"], // front lights
        6: mlib["Dark chrome"], // windshield rim
      };

      // Veyron materials

      CARS["veyron"].materials = {
        body: [
          ["Orange metal", mlib["Orange metal"]],
          ["Blue metal", mlib["Blue metal"]],
          ["Red metal", mlib["Red metal"]],
          ["Green metal", mlib["Green metal"]],
          ["Black metal", mlib["Black metal"]],

          ["Gold", mlib["Gold"]],
          ["Bronze", mlib["Bronze"]],
          ["Chrome", mlib["Chrome"]],
        ],
      };

      m = CARS["veyron"].materials;
      mi = CARS["veyron"].init_material;

      CARS["veyron"].mmap = {
        0: mlib["Black rough"], // tires + inside
        1: mlib["Pure chrome"], // wheels + extras chrome
        2: m.body[mi][1], // back / top / front torso
        3: mlib["Dark glass"], // glass
        4: mlib["Pure chrome"], // sides torso
        5: mlib["Pure chrome"], // engine
        6: mlib["Red glass 50"], // backlights
        7: mlib["Orange glass 50"], // backsignals
      };

      // F50 materials

      CARS["f50"].materials = {
        body: [
          ["Orange", mlib["Orange"]],
          ["Blue", mlib["Blue"]],
          ["Red", mlib["Red"]],
          ["Black", mlib["Black"]],
          ["White", mlib["White"]],

          ["Orange metal", mlib["Orange metal"]],
          ["Blue metal", mlib["Blue metal"]],
          ["Black metal", mlib["Black metal"]],

          ["Carmine", mlib["Carmine"]],
          ["Gold", mlib["Gold"]],
          ["Bronze", mlib["Bronze"]],
          ["Chrome", mlib["Chrome"]],
        ],
      };

      m = CARS["f50"].materials;
      mi = CARS["f50"].init_material;

      CARS["f50"].mmap = {
        0: mlib["Dark chrome"], // interior + rim
        1: mlib["Pure chrome"], // wheels + gears chrome
        2: mlib["Blue glass"], // glass
        3: m.body[mi][1], // torso mid + front spoiler
        4: mlib["Darkgray shiny"], // interior + behind seats
        5: mlib["Darkgray shiny"], // tiny dots in interior
        6: m.body[mi][1], // back torso
        7: m.body[mi][1], // right mirror decal
        8: m.body[mi][1], // front decal
        9: m.body[mi][1], // front torso
        10: m.body[mi][1], // left mirror decal
        11: mlib["Pure chrome"], // engine
        12: mlib["Darkgray rough"], // tires side
        13: mlib["Darkgray rough"], // tires bottom
        14: mlib["Darkgray shiny"], // bottom
        15: mlib["Black rough"], // ???
        16: mlib["Orange glass"], // front signals
        17: mlib["Dark chrome"], // wheels center
        18: mlib["Red glass"], // back lights
        19: mlib["Black rough"], // ???
        20: mlib["Red rough"], // seats
        21: mlib["Black rough"], // back plate
        22: mlib["Black rough"], // front light dots
        23: m.body[mi][1], // back torso
        24: m.body[mi][1], // back torso center
      };

      // Camero materials

      CARS["camaro"].materials = {
        body: [
          ["Orange", mlib["Orange"]],
          ["Blue", mlib["Blue"]],
          ["Red", mlib["Red"]],
          ["Black", mlib["Black"]],
          ["White", mlib["White"]],

          ["Orange metal", mlib["Orange metal"]],
          ["Blue metal", mlib["Blue metal"]],
          ["Red metal", mlib["Red metal"]],
          ["Green metal", mlib["Green metal"]],
          ["Black metal", mlib["Black metal"]],

          ["Gold", mlib["Gold"]],
          ["Bronze", mlib["Bronze"]],
          ["Chrome", mlib["Chrome"]],
        ],
      };

      m = CARS["camaro"].materials;
      mi = CARS["camaro"].init_material;

      CARS["camaro"].mmap = {
        0: m.body[mi][1], // car body
        1: mlib["Pure chrome"], // wheels chrome
        2: mlib["Pure chrome"], // grille chrome
        3: mlib["Dark chrome"], // door lines
        4: mlib["Light glass"], // windshield
        5: mlib["Gray shiny"], // interior
        6: mlib["Black rough"], // tire
        7: mlib["Fullblack rough"], // tireling
        8: mlib["Fullblack rough"], // behind grille
      };

      console.log(CARS["veyron"].mtlUrl, ' CARS[ "veyron" ].url----');
      // loader.load(CARS["veyron"].url, (geometry) => {
      //   this.createScene(geometry, "veyron");
      // });

      this.carModel(CARS["veyron"].mtlUrl,CARS["veyron"].objUrl);


      for (var c in CARS) this.initCarButton(c);

      //

      window.addEventListener("resize", this.onWindowResize, false);
    },

    onWindowResize() {
      // var windowHalfX = window.innerWidth / 2;
      // var windowHalfY = window.innerHeight / 2;

      camera.aspect = window.innerWidth / window.innerHeight;
      camera.updateProjectionMatrix();

      cameraCube.aspect = window.innerWidth / window.innerHeight;
      cameraCube.updateProjectionMatrix();

      renderer.setSize(window.innerWidth, window.innerHeight);
    },

    initCarButton(car) {
      this.getElementByIds(car).addEventListener(
        "click",
        () => {
        
            console.log(CARS[car].object,car,  "点击--车型----");
            this.carModel(CARS[car].mtlUrl,CARS[car].objUrl,car);
            this.switchCar(car);
          
        },
        false
      );
    },

    getElementByIds(id) {
      return document.getElementById(id);
    },

    button_name(car, index) {
      return "m_" + car + "_" + index;
    },

    switchCar(car) {

      this.getElementByIds("car_name").innerHTML = CARS[car].name + " model";
    },

    createScene(geometry, car) {
      if(this.showMesh){     
       scene.remove(this.showMesh)
      // 递归遍历组对象group释放所有后代网格模型绑定几何体占用内存
      scene.traverse((obj)=> {
      if (obj.type === 'Mesh') {
         obj.geometry.dispose();
         obj.material.dispose();
        }
      })
      // 删除场景对象scene的子对象group
      scene.remove(scene.group)
    }


        var m = [], 
        s = CARS[car].scale * 1, 
        materials = CARS[car].materials,
        r = CARS[car].init_rotation;
       
      for (var i in CARS[car].mmap) {
        m.push({ materials: CARS[car].mmap[i] });
      }

      this.showMaterials= materials.body
     
     console.log(scene, 'this.scene------')
  
      var mesh = geometry 

      mesh.rotation.x = r[0];
      mesh.rotation.y = r[1];
      mesh.rotation.z = r[2];

      mesh.scale.x = mesh.scale.y = mesh.scale.z = s;

      scene.add(mesh);

      CARS[car].object = mesh;

      this.showMesh = mesh;

    },

    changeColor(item){
     console.log(item ,'item----')
     console.log(this.showMesh, 'showMesh------')
     this.showMesh.traverse( ( child )=> {
        if ( child instanceof THREE.Mesh ) {
          if( child.name.indexOf("WHITE_BODY")==0 || child.name.indexOf("b")==0 || child.name.indexOf("c")==0 ||  child.name.indexOf("C")==0){  //b c
            //每个储位单独赋予一个基础材质                                   
              child.material= item[1];
              // child.material.map = texture;
            }
        }
     })

    },

    onDocumentMouseMove(event) {
      mouseY = event.clientY - window.innerHeight;
    },

    carModel(mtlUrl , objUrl, car) {
      console.log(mtlUrl,objUrl,car, 'url-car---')
      let manager = new THREE.LoadingManager();
      new MTLLoader(manager).load(
        mtlUrl,
        (materials) => {
          materials.preload();
          console.log(materials, "materials---");
          new OBJLoader(manager)
            .setMaterials(materials)
            .load(objUrl, (object) => {
            // console.log(object, "obj---");
            // object.position.set(0, -60, 0);
            // object.scale.set(150,150,150);
            // scene.add(object);
            // console.log(object, scene, "obj---scene---");

             this.createScene(object, car||"veyron");
          },
        );
      });
    },

    //

    animate() {
      requestAnimationFrame(this.animate);

      this.render();
    },

    render() {
      var timer = -0.0002 * Date.now();

      camera.position.x = 1000 * Math.cos(timer);
      camera.position.y += (-mouseY - camera.position.y) * 0.05;
      camera.position.z = 1000 * Math.sin(timer);

      camera.lookAt(scene.position);
      cameraCube.rotation.copy(camera.rotation);

      renderer.render(sceneCube, cameraCube);
      renderer.autoClear = false;
      renderer.render( scene, camera );

      // if (STATS_ENABLED) stats.update();
    },
  },
};
</script>
