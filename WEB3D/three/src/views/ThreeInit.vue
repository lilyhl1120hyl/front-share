<template>
  <div>
    <div id="container"></div>
    <button @click="drawLine">画一条线</button>
    <div id="line"></div>
    <div id="line3"></div>
  </div>
</template>

<script>
import * as THREE from "three";

export default {
  name: "ThreeTest",
  data() {
    return {
      camera: null,
      scene: null,
      renderer: null,
      mesh: null,
      line: null,
      geometry: null,
    };
  },
  methods: {
    init() {
      let container = document.getElementById("container");
      // Threejs三大组件（场景-scene，相机-camera，渲染器-renderer）
      
      // PerspectiveCamera（透视摄像机）第一个参数是视野角度（FOV）第二个参数是长宽比（aspect ratio）两个参数是近截面（near）和远截面（far）
      this.camera = new THREE.PerspectiveCamera(
        60,
        container.clientWidth / container.clientHeight,
        0.01,
        10
      );
      this.camera.position.z = 3;

      this.scene = new THREE.Scene();

      let geometry = new THREE.BoxGeometry(0.2, 0.2, 0.2);
      let geometry1 = new THREE.SphereGeometry(0.3, 0.2, 0.2); // 创建一个球体
      let material = new THREE.MeshNormalMaterial(); // MeshBasicMaterial材质

      this.mesh = new THREE.Mesh(geometry, material); // mesh网格
      this.mesh1 = new THREE.Mesh(geometry1, material); // mesh网格
      this.mesh1.translateX(0.4);

      var group = new THREE.Group();
      //把mesh1型插入到组group中，mesh1作为group的子对象
      group.add(this.mesh1);
      //把mesh型插入到组group中，mesh作为group的子对象
      group.add(this.mesh);
      // 把层级模型放进场景
      this.scene.add(group);

      //沿着Y轴平移mesh1和mesh的父对象，mesh1和mesh跟着平移
      // group.translateY(1);
      //父对象缩放，子对象跟着缩放
      group.scale.set(2, 2, 2);
      console.log("查看group的子对象", group.children);
      console.log("查看Scene的子对象", this.scene.children);

      // 渲染器
      this.renderer = new THREE.WebGLRenderer({
        antialias: true,
      });
      this.renderer.setSize(container.clientWidth, container.clientHeight);
      container.appendChild(this.renderer.domElement);
    },
    animate() {
      // 循环动画 1/24
      // 让浏览器自行根据当前cpu负载等情况决定何时重绘，达到最佳帧率。
      requestAnimationFrame(this.animate);
      this.mesh.rotation.x += 0.01;
      this.mesh.rotation.y += 0.05;
      this.renderer.render(this.scene, this.camera);
    },
    drawLine() {
      let lineBox = document.getElementById("line");
      console.log(lineBox, "123");
      this.renderer = new THREE.WebGLRenderer();
      this.renderer.setSize(lineBox.clientWidth, lineBox.clientHeight);
      lineBox.appendChild(this.renderer.domElement);

      this.camera = new THREE.PerspectiveCamera(
        45,
        lineBox.clientWidth / lineBox.clientHeight,
        1,
        500
      );
      this.camera.position.set(0, 0, 100);
      this.camera.lookAt(0, 0, 0);

      this.scene = new THREE.Scene();
      //线条来说，能使用的材质只有LineBasicMaterial 或者 LineDashedMaterial。
      this.material = new THREE.LineBasicMaterial({
        vertexColors: true,
      });
      // Geometry 利用 Vector3 或 Color 存储了几何体的相关 attributes（如顶点位置，面信息，颜色等）比起 BufferGeometry 更容易读写，但是运行效率不如有类型的队列。
      // BufferGeometry是面片、线或点几何体的有效表述。包括顶点位置，面片索引、法相量、颜色值、UV 坐标和自定义缓存属性值。使用 BufferGeometry 可以有效减少向 GPU 传输上述数据所需的开销。对于大型工程或正式工程，推荐采用 BufferGeometry。
      this.geometry = new THREE.BufferGeometry();
      this.geometry.vertices.push(new THREE.Vector3(-100, 0, 0));
      this.geometry.vertices.push(new THREE.Vector3(0, 20, 0));
      this.geometry.vertices.push(new THREE.Vector3(100, 0, 0));
      // 颜色
      let color1 = new THREE.Color(0x444444),
          color2 = new THREE.Color(0xff0000),
          color3 = new THREE.Color(0x32cd32);
      this.geometry.colors.push(color1, color2, color3);

      this.line = new THREE.Line(this.geometry, this.material);

      this.scene.add(this.line);
      this.renderer.render(this.scene, this.camera);
    },
  },
  mounted() {
    this.init();
    this.animate();
  },
};
</script>
<style scoped>
#container {
  height: 500px;
}

#line,
#line3 {
  height: 200px;
  border: solid 1px #ccc;
}
</style>
