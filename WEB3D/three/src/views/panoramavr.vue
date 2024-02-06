<template>
  <div>
    <div id="container"></div>
   
  </div>
 
  
</template>
 
<script src="../libs/vr/HelioWebXRPolyfill.js"></script>
<script>
import * as THREE from "three";

import { VRButton } from "three/examples/jsm/webxr/VRButton.js";

var camera, scene, renderer, sphere, clock;
export default {
  data() {
    return {};
  },
  mounted() {
    this.init();
    this.animate();
    
  },
  methods: {
    init() {
      var container = document.getElementById("container");
     
  

      clock = new THREE.Clock();

      scene = new THREE.Scene();
      scene.background = new THREE.Color(0x101010);

      var light = new THREE.AmbientLight(0xffffff, 1);
      scene.add(light);

      camera = new THREE.PerspectiveCamera(
        70,
        window.innerWidth / window.innerHeight,
        1,
        200
      );
      scene.add(camera);
 

      // Create the panoramic sphere geometery
      var panoSphereGeo = new THREE.SphereBufferGeometry(6, 256, 256);

      // Create the panoramic sphere material
      var panoSphereMat = new THREE.MeshStandardMaterial({
        side: THREE.BackSide,
        displacementScale: -4.0,
      });

      // Create the panoramic sphere mesh
      sphere = new THREE.Mesh(panoSphereGeo, panoSphereMat);

      // Load and assign the texture and depth map
      var manager = new THREE.LoadingManager();
      var loader = new THREE.TextureLoader(manager);

      loader.load("/static/kandao3.jpg", function (texture) {
        texture.minFilter = THREE.NearestFilter;
        texture.generateMipmaps = false;
        sphere.material.map = texture;
      });
    
      loader.load("/static/kandao3_depthmap.jpg", function (depth) {
        depth.minFilter = THREE.NearestFilter;
        depth.generateMipmaps = false;
        sphere.material.displacementMap = depth;
      });

      // On load complete add the panoramic sphere to the scene
      manager.onLoad = function () {
         scene.add(sphere);
      };

      renderer = new THREE.WebGLRenderer();
      renderer.setPixelRatio(window.devicePixelRatio); // 设置显示比例
      renderer.setSize(window.innerWidth, window.innerHeight); 
      renderer.xr.enabled = true;
      renderer.xr.setReferenceSpaceType("local");
      container.appendChild(renderer.domElement);

      document.body.appendChild(VRButton.createButton(renderer));  // vr button

      //

      window.addEventListener("resize", this.onWindowResize, false);
    },



    onWindowResize() {
      camera.aspect = window.innerWidth / window.innerHeight;
      camera.updateProjectionMatrix();

      renderer.setSize(window.innerWidth, window.innerHeight);
    },

    animate() {
      renderer.setAnimationLoop(this.render);
    },

    render() {
      // If we are not presenting move the camera a little so the effect is visible
      if (renderer.xr.isPresenting === false) {
        var time = clock.getElapsedTime();
        sphere.rotation.y += 0.001;
        sphere.position.x = Math.sin(time) * 0.2;
        sphere.position.z = Math.cos(time) * 0.2;
      }

      renderer.render(scene, camera);
    },
  },
};
</script>

<style>



</style>

