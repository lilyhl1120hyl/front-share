<template>
  <div id="container"></div>
</template>

<script>
import * as THREE from "three";

var isUserInteracting = false,
  onMouseDownMouseX = 0,
  onMouseDownMouseY = 0,
  lon = 0,
  onMouseDownLon = 0,
  lat = 0,
  onMouseDownLat = 0,
  phi = 0,
  theta = 0;

export default {
  data() {
    return {
      camera: null,
      scene: null,
      renderer: null,
      mesh: null,
      material:null,

    };
  },
  mounted() {
      this.initScene()
      this.initCamera()
      this.CreateGemotrys()
      this.initRender()
      this.addListener()
      this.animate()
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
    },
    initLight() {},
    CreateGemotrys() {
      var geometry = new THREE.SphereBufferGeometry(500, 60, 40);
      geometry.scale(-1, 1, 1);

      var texture = new THREE.TextureLoader().load(
        "static/2294472375_24a3b8ef46_o.jpg"
      );
      this.material = new THREE.MeshBasicMaterial({ map: texture });

      this.mesh = new THREE.Mesh(geometry, this.material);

      this.scene.add(this.mesh);
    },
    initRender() {
      this.renderer = new THREE.WebGLRenderer();
      this.renderer.setPixelRatio(window.devicePixelRatio);
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.container.appendChild(this.renderer.domElement);
    },
    addListener() {
      document.addEventListener("mousedown", this.onPointerStart, false);
      document.addEventListener("mousemove", this.onPointerMove, false);
      document.addEventListener("mouseup", this.onPointerUp, false);

      document.addEventListener("wheel", this.onDocumentMouseWheel, false);

      document.addEventListener("touchstart", this.onPointerStart, false);
      document.addEventListener("touchmove", this.onPointerMove, false);
      document.addEventListener("touchend", this.onPointerUp, false);
      document.addEventListener(
        "dragover",
        function (event) {
          event.preventDefault();
          event.dataTransfer.dropEffect = "copy";
        },
        false
      );

      document.addEventListener(
        "dragenter",
        function () {
          document.body.style.opacity = 0.5;
        },
        false
      );

      document.addEventListener(
        "dragleave",
        function () {
          document.body.style.opacity = 1;
        },
        false
      );
      // 把全景图拖拽进入场景进行切换
      document.addEventListener(
        "drop",
         (event)=> {
          event.preventDefault();

          var reader = new FileReader();
          reader.addEventListener(
            "load",
             (event) =>{
              this.material.map.image.src = event.target.result;
              this.material.map.needsUpdate = true;
            },
            false
          );
          reader.readAsDataURL(event.dataTransfer.files[0]);

          document.body.style.opacity = 1;
        },
        false
      );

      window.addEventListener("resize", this.onWindowResize, false);
    },

    onWindowResize() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.renderer.setSize(window.innerWidth, window.innerHeight);
    },

    onPointerStart(event) {
      this.isUserInteracting = true;

      var clientX = event.clientX || event.touches[0].clientX;
      var clientY = event.clientY || event.touches[0].clientY;

      onMouseDownMouseX = clientX;
      onMouseDownMouseY = clientY;

      onMouseDownLon = lon;
      onMouseDownLat = lat;
    },

    onPointerMove(event) {
      if (isUserInteracting === true) {
        var clientX = event.clientX || event.touches[0].clientX;
        var clientY = event.clientY || event.touches[0].clientY;

        lon = (onMouseDownMouseX - clientX) * 0.1 + onMouseDownLon;
        lat = (clientY - onMouseDownMouseY) * 0.1 + onMouseDownLat;
      }
    },
    onPointerUp() {
      this.isUserInteracting = false;
    },
    onDocumentMouseWheel(event) {
      var fov = this.camera.fov + event.deltaY * 0.05;

      this.camera.fov = THREE.MathUtils.clamp(fov, 10, 75);

      this.camera.updateProjectionMatrix();
    },

    animate() {
      requestAnimationFrame(this.animate);
      this.update();
    },

    update() {
      if (this.isUserInteracting === false) {
        lon += 0.1;
      }

      lat = Math.max(-85, Math.min(85, lat));
      phi = THREE.MathUtils.degToRad(90 - lat);  // 度数
      theta = THREE.MathUtils.degToRad(lon);

      this.camera.target.x = 500 * Math.sin(phi) * Math.cos(theta);
      this.camera.target.y = 500 * Math.cos(phi);
      this.camera.target.z = 500 * Math.sin(phi) * Math.sin(theta);
      
      console.log(this.camera.target,'this.camera.target')
      this.camera.lookAt(this.camera.target);

      /*
				// distortion
				camera.position.copy( camera.target ).negate();
				*/

      this.renderer.render(this.scene, this.camera);
    },
  },
};
</script>

<style>
</style>
