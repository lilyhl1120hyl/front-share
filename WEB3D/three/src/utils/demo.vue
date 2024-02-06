<template>
  <section class="slider-3d c--slider-3d">
    <div
      class="slider-3d-box"
      ref="wrapper"
      :style="{ height: acHeight + 'px' }"
    >
      <canvas id="slider-3d-cv" ref="canvas"></canvas>
    </div>
  </section>
</template>

<script>
import * as THREE from "three";
import * as TWEEN from "tween.js";

// 定义场景，渲染器，相机变量
let [scene, renderer, camera] = Array.of(null, null, null);
// 定义材质，纹理变量
let [material, texture] = Array.of(null, null);
// 定义存放立方体的队列
let meshs = [];
// 定义相机在初始位置确定后在Z轴上的偏移量（为了给视角留空间，值越小，视野范围内的物体看起来越大）
const offsetZ = 25;
// 定义图片发生切换动作时存放上一张图片的变量
let prevImage = null;
// 存放生成的离屏canvas
let drawImages = [];
// 拉远镜头
function farCamera() {
  // 保存初始数据
  let { x, y, z } = camera.position;
  let pos = { x, y, z };
  camera.userData.pos = { ...pos };
  new TWEEN.Tween(pos)
    .to({ ...pos, z: pos.z * 1.4 }, 1500)
    .easing(TWEEN.Easing.Quadratic.Out)
    .onUpdate(() => {
      camera.position.set(pos.x, pos.y, pos.z);
    })
    .start();
}
// 还原镜头
function restoreCamera() {
  let { x, y, z } = camera.position;
  let pos = { x, y, z };
  let target = camera.userData.pos;
  if (!target) return false;
  if (pos.x === target.x && pos.y === target.y && pos.z === target.z)
    return false;
  new TWEEN.Tween(pos)
    .to({ ...target }, 1500)
    .easing(TWEEN.Easing.Quadratic.Out)
    .onUpdate(() => {
      camera.position.set(pos.x, pos.y, pos.z);
    })
    .start();
}
// 存放当前图片切换时的过渡动画类型
const moveType = {
  // 随机
  random(range) {
    return {
      x: -range.x / 2 + Math.random() * range.x,
      y: -range.y / 2 + Math.random() * range.y,
      z: -range.z / 2 + Math.random() * range.z,
      delay: (Math.random() * range.delay) >> 0,
    };
  },
  // 排序延时,左下
  orderDelayLB(range, i, j, size) {
    farCamera();
    let [ox, oy] = size;
    return {
      x: -10 - (ox - i) * 5,
      y: -15 - (oy - j) * 5,
      z: range.z / 10,
      delay: (Math.min(range.delay, 100) / 2) * (i + j),
    };
  },
  // 排序延时，左上
  orderDelayLT(range, i, j, size) {
    farCamera();
    let [ox, oy] = size;
    return {
      x: -10 - (ox - i) * 5,
      y: 15 + j * 5,
      z: range.z / 10,
      delay: (Math.min(range.delay, 100) / 2) * (i + (oy - j)),
    };
  },
  // 排序延时，右下
  orderDelayRB(range, i, j, size) {
    farCamera();
    let [ox, oy] = size;
    return {
      x: 10 + i * 5,
      y: -15 - (oy - j) * 5,
      z: range.z / 10,
      delay: (Math.min(range.delay, 100) / 2) * (ox - i + j),
    };
  },
  // 排序延时, 右上
  orderDelayRT(range, i, j, size) {
    farCamera();
    let [ox, oy] = size;
    return {
      x: 10 + i * 5,
      y: 15 + j * 5,
      z: range.z / 10,
      delay: (Math.min(range.delay, 100) / 2) * (ox - i + (oy - j)),
    };
  },
};
let changeArr = [];
for (let key in moveType) {
  changeArr.push(key);
}
// 类型索引
let changeIndex = 0;
// 过渡动画旋转的随机数, 0代表旋转，其他不进行旋转
let rotationIndex = 0;
// 旋转方向
let rotationDirection = -1;
// 定时器和动画停止变量（用于销毁对象）
let timer = null;
let stoped = false;
// 当前动画运行待完成的小方块数据
let cubeAniComplete = 0;
export default {
  name: "Slider3D",
  props: {
    // // 图片
    // items: {
    //   type: Array,
    //   default: () => ({})
    // },
    // 是否预加载图片
    preload: {
      type: Boolean,
      default: true,
    },
    // 是否自动播放
    auto: {
      type: Boolean,
      default: true,
    },
    // 是否反向
    reverse: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      items: [
        {
          src: "/static/images/spring.jpg", // 链接，必填
          size: [], // 选填， 当前图片对应的在X轴和Y轴上的立方体的数目，默认是[16， 9]（data属性的defaultSize），也是大部分图片的宽高比，当然这两个值并不是一定要写到没有约数，比如[32, 18],或者[24, 10]都是可以的，但我不建议数目写太大，主要是浪费性能，还有就是没有在一个size时候过渡好看
          animate: {
            name: "fade", // 图片过渡动画选择的动画种类，translate(平移)/cover(覆盖)/fade(变淡)
            type: "In", // 在上面name确定动画种类以后，在其内部选择相应的动画小类， 如name是fade，type可以选择In，Out,InOut和OutIn, 具体参数可以在_animateImage方法下面查看
            duration: 3000, // 持续时间,
            delay: 0, // 延时
            easing: TWEEN.Easing.Quadratic.In, // tweenjs 内置的动画曲线类型
          },
        },
        {
          src: "/static/images/winter.jpg", // 链接，必填
          size: [], // 选填， 当前图片对应的在X轴和Y轴上的立方体的数目，默认是[16， 9]（data属性的defaultSize），也是大部分图片的宽高比，当然这两个值并不是一定要写到没有约数，比如[32, 18],或者[24, 10]都是可以的，但我不建议数目写太大，主要是浪费性能，还有就是没有在一个size时候过渡好看
          animate: {
            name: "fade", // 图片过渡动画选择的动画种类，目前我只写了三种translate(平移)/cover(覆盖)/fade(变淡)
            type: "InOut", // 在上面name确定动画种类以后，在其内部选择相应的动画小类， 如name是fade，type可以选择In，Out,InOut和OutIn, 具体参数可以在_animateImage方法下面查看
            duration: 3000, // 持续时间,
            delay: 0, // 延时
            easing: TWEEN.Easing.Quadratic.In, // tweenjs 内置的动画曲线类型
          },
        },
      ],
      // 将canvas的精度放大多少倍，最多不会超过原图片的精度
      canvasScale: 3,
      // webgl canvas
      canvas: null,
      // 绘图canvas
      imageCanvas: null,
      // 容器
      wrapper: null,
      // 是否当前资源正在加载中
      cvLoading: true,
      // 当前是否正在动画中, 防止频繁切换
      isAnimating: false,
      // webGl canvas尺寸
      cWidth: 0,
      cHeight: 0,
      // 当前图片尺寸
      iWidth: 0,
      iHeight: 0,
      // 当前场景的横纵比
      size: [16, 9],
      // 默认横纵比
      defaultSize: [16, 9],
      // 当前图片序号
      currentIndex: 0,
      // 动态计算的容器高度
      acHeight: 0,
      // 内置的物体运动相关的控制参数
      hiddenOption: {
        duration: 2000,
        delay: 0,
        easing() {
          return TWEEN.Easing.Quadratic.InOut;
        },
      },
      changeOption: {
        duration: 2000,
        delay: 0,
        easing() {
          return TWEEN.Easing.Quadratic.Out;
        },
      },
      // 偏移延迟，主要用于进行动画过渡时，由于动画效果需要耗费的额外延时时间将保存到这里，存最大值
      offsetDelay: 0,
      startOption: {
        duration: 1000,
        delay: 0,
        easing() {
          return TWEEN.Easing.Quadratic.Out;
        },
      },
      endOption: {
        duration: 500,
        delay: 0,
        easing() {
          return TWEEN.Easing.Quadratic.In;
        },
      },
      // 一次动作完成后经过多少ms进行下一次动作
      spaceTime: 3000,
      // 立方体之间的间隔, 由于3D视角的原因，实际上cube之间的距离不一定是设定值那么宽
      cubeSpace: 0,
      // 当进行场景切换时，每个立方体进行移动的边界范围(在changeTween方法里有用到)
      cubeChangeRange: {
        useAnimation: true, // 是否进行中间的过渡动画
        delay: 100, // 随机延迟时间范围
        x: 800, // 偏移值基准，下同 (实际使用时不一定会全部用到)
        y: 400,
        z: 100,
      },
    };
  },
  computed: {
    // 当前配置下动画的总持续时间, 自定义每张图片的切换时间不会超过这个时间
    animateDuration() {
      let change = this.changeOption || {};
      let start = this.startOption || {};
      let end = this.endOption || {};
      return (
        (change.duration || 1000) +
        (change.delay || 0) +
        (start.duration || 1000) +
        (start.delay || 0) +
        (end.duration || 1000) +
        (end.delay || 0) +
        this.offsetDelay
      );
    },
  },
  created() {},
  mounted() {
    this.canvas = this.$refs.canvas;
    this.wrapper = this.$refs.wrapper;
    // let [ww, wh] = [window.innerWidth, window.innerHeight]
    let w = this.wrapper.clientWidth;
    this.acHeight = (w * this.defaultSize[1]) / this.defaultSize[0];
    // 进行传入数据检测
    this.items.forEach((item) => {
      if (
        Object.prototype.toString.call(item) !== "[object Object]" &&
        !item.src
      )
        throw new Error("传入数据中存在不合法数据");
    });
    // 初始化部分变量
    stoped = false;
    changeIndex = 0;
    this.currentIndex = 0;
    prevImage = null;
    drawImages = [];
    this.$nextTick(() => {
      this.updateSize();
      this.initCanvas();
      requestAnimationFrame((time) => {
        this.update(time);
      });
      // 图片一次加载完成
      if (this.preload) {
        meshs = [];
        drawImages = [];
        prevImage = null;
        this._loadImages(() => {
          this.cvLoading = false;
          // 切换到第一张图片
          this.changeImage(0);
        });
        return false;
      }
      this.changeImage(0);
    });
  },
  beforeDestroy() {
    stoped = true;
    clearTimeout(timer);
    texture && texture.dispose();
    if (material) {
      material.dispose();
      material.map.dispose();
    }
    meshs.forEach((mesh) => {
      mesh.geometry.dispose();
      mesh.material.dispose();
    });
    texture = null;
    material = null;
    meshs = [];
    scene && scene.dispose();
  },
  methods: {
    initCanvas() {
      // 场景
      scene = new THREE.Scene();
      // 渲染器
      renderer = new THREE.WebGLRenderer({
        canvas: this.canvas,
        alpha: true,
        antialias: true,
        logarithmicDepthBuffer: true,
      });
      renderer.setClearColor(0xffffff);
      renderer.setSize(
        this.cWidth * this.canvasScale,
        this.cHeight * this.canvasScale
      );
      this.canvas.style.width = this.cWidth + "px";
      this.canvas.style.height = this.cHeight + "px";
      // 相机
      camera = new THREE.PerspectiveCamera(
        60,
        this.cWidth / this.cHeight,
        1,
        10000
      );
      let cH = this.cHeight / 2;
      let z = cH * Math.sqrt(3) + offsetZ;
      camera.position.set(0, 0, z);
      camera.lookAt(new THREE.Vector3(0, 0, 0));
    },
    updateSize() {
      if (!this.wrapper) return false;
      this.cWidth = this.wrapper.clientWidth;
      this.acHeight = (this.cWidth * 9) / 16;
      this.cHeight = this.acHeight;
      renderer &&
        renderer.setSize(
          this.cWidth * this.canvasScale,
          this.cHeight * this.canvasScale
        );
      this.canvas.style.width = this.cWidth + "px";
      this.canvas.style.height = this.cHeight + "px";
      if (camera) {
        camera.aspect = this.cWidth / this.cHeight;
        let cH = this.cHeight / 2;
        let z = cH * Math.sqrt(3) + offsetZ;
        camera.position.set(0, 0, z);
        camera.lookAt(new THREE.Vector3(0, 0, 0));
        camera.updateProjectionMatrix();
      }
    },
    changeImage(idx) {

        console.log(idx, "idx======")
      // 当前动画正在运行的情况
      if (this.isAnimating) return false;
      // 当前资源正在加载的情况
      if (this.cvLoading) return false;
      // 传入idx是非数字的时候
      if (Number.isNaN(idx * 1) || idx === null) return false;
      // 不存在相应对象的情况
      let item = this.items[idx];
      if (!item || !item.src) return false;
      this.currentIndex = idx;
      // 如果canvas已存在，且图片链接一致的情况下,直接进行切换操作，无需加载
      let canvas = drawImages[idx];
      this.isAnimating = true;
      if (canvas && canvas._imgElement && item.src === canvas._imgElement.src) {
        this._initImage();
        return false;
      }
      // 否则判断为对应图片未加载或发生变化，需要重新进行加载
      this.cvLoading = true;
      this._loadImage(item, idx, () => {
        this.cvLoading = false;
        this._initImage();
      });
    },
    update(time) {
      if (stoped) return false;
      requestAnimationFrame((time) => {
        this.update(time);
      });
      renderer.render(scene, camera);
      meshs.forEach((item) => {
        let ud = item.userData;
        for (let key in ud) {
          if (!key.includes("group")) continue;
          ud[key].update(time);
        }
      });
      TWEEN.update(time);
    },
    toNext() {
      let idx =
        this.currentIndex + 1 >= this.items.length ? 0 : this.currentIndex + 1;
      this.changeImage(idx);
    },
    toPrev() {
      let idx =
        this.currentIndex - 1 < 0
          ? this.items.length - 1
          : this.currentIndex - 1;
      this.changeImage(idx);
    },
    play() {
      if (!this.auto) return false;
      timer = setTimeout(() => {
        if (stoped) return false;
        this.reverse ? this.toPrev() : this.toNext();
      }, this.spaceTime);
    },
    _getChangeTweenMoveData({ i = 0, j = 0 }) {
      let range = this.cubeChangeRange || {};
      if (!range.useAnimation) return { x: 0, y: 0, z: 0, delay: 0 };
      return moveType[changeArr[changeIndex]](range, i, j, this.size);
    },
    _changeUVs(geometry, ux, uy, ox, oy) {
      if (!geometry || !geometry.attributes || !geometry.attributes.uv)
        return false;
      let uvs = geometry.attributes.uv.array;
      let saveUVs = [...uvs];
      for (let i = 0; i < uvs.length; i += 2) {
        uvs[i] = (uvs[i] + ox) * ux;
        uvs[i + 1] = (uvs[i + 1] + oy) * uy;
      }
      return saveUVs;
    },
    _initCube() {
      let [x, y] = this.size;
      if (x <= 0 || y <= 0) return false;
      // 计算每个立方体的尺寸（注意：用图片尺寸来计算，不是容器尺寸）
      let [xSize, ySize] = [this.iWidth / x, this.iHeight / y];
      // 复用或初始化纹理
      texture = texture || new THREE.CanvasTexture(this.imageCanvas);
      // 复用或初始化材质
      material =
        material ||
        new THREE.MeshBasicMaterial({
          map: texture,
        });
      // 创建cube
      for (let i = 0; i < x; i++) {
        for (let j = 0; j < y; j++) {
          let geometry = new THREE.BoxBufferGeometry(xSize, ySize, xSize);
          // 如果已存在对应序号的对象，则复用已存在的对象，跳过生成
          if (meshs[i * y + j]) {
            let mesh = meshs[i * y + j];
            mesh.userData.i = i;
            mesh.userData.j = j;
            mesh.geometry.attributes.uv.array = new Float32Array([
              ...mesh.userData.uvs,
            ]);
            // 更新uv
            // this._changeUVs(geometry, 1 / x, 1 / y, i, j)
            // mesh.geometry = geometry
            this._changeUVs(mesh.geometry, 1 / x, 1 / y, i, j);
            mesh.geometry.attributes.uv.needsUpdate = true;
            let { width, height } = mesh.geometry.parameters;
            // 动画缩放立方体尺寸
            this._animateCube(mesh, xSize / width, ySize / height);
            continue;
          }
          // 修改每个cube的uv偏移和缩放
          let saveUVs = this._changeUVs(geometry, 1 / x, 1 / y, i, j);
          // 生成新立方体,保存序号信息等并随机调整初始位置
          let mesh = new THREE.Mesh(geometry, material);
          mesh.userData.i = i;
          mesh.userData.j = j;
          mesh.userData.uvs = [...saveUVs];
          // 保存到立方体队列便于操作
          meshs[i * y + j] = mesh;
          let markX = ((Math.random() * 800) >> 0) % 2 === 0 ? -1 : 1;
          let markY = ((Math.random() * 100) >> 0) % 2 === 0 ? -1 : 1;
          mesh.position.set(
            Math.random() * (markX * 200) + markX * this.cWidth,
            Math.random() * (markY * 200) + markY * this.cHeight,
            -50 + Math.random() * 100
          );
          scene.add(mesh);
        }
      }
    },
    _animateCube(mesh, scaleX, scaleY) {
      let { x, y } = mesh.scale;
      let group = new TWEEN.Group();
      mesh.userData.group5 = group;
      let data = { x, y };
      new TWEEN.Tween(data, group)
        .to(
          {
            x: scaleX,
            y: scaleY,
          },
          2000
        )
        .easing(TWEEN.Easing.Quadratic.In)
        .onUpdate(() => {
          mesh.scale.set(data.x, data.y, data.x);
        })
        .start();
    },
    _initPosition() {
      // 获取尺寸用于每个立方体偏移位置的计算
      let [xNum, yNum] = this.size;
      let [xSize, ySize] = [this.iWidth / xNum, this.iHeight / yNum];
      cubeAniComplete = xNum * yNum;
      for (let index = meshs.length - 1; index >= 0; index--) {
        let mesh = meshs[index];
        // 如果出现立方体个数多余的情况，将此次图片显示中多余不用的立方体移到屏幕外并隐藏
        if (index >= xNum * yNum) {
          this._hideenTween(mesh);
          continue;
        }
        // 立方体显示
        mesh.visible = true;
        // 计算位置
        let { i, j } = mesh.userData;
        // 偏移计算单位
        let divideX = xNum / 2 - 0.5;
        let divideY = yNum / 2 - 0.5;
        let offsetX = i - divideX;
        let offsetY = j - divideY;
        // 计算立方体旋转的时候在X轴上占的最大位置
        let rotateXLength = Math.sqrt(2) * xSize;
        // 立方体动画更新
        this._changeTween(mesh, offsetX, offsetY, rotateXLength, xSize, ySize);
      }
    },
    _hideenTween(mesh) {
      let { x, y, z } = mesh.position;
      let data = {
        x,
        y,
        z,
      };
      let group = mesh.userData.group4 || new TWEEN.Group();
      mesh.userData.group4 = group;
      let markX = ((Math.random() * 400) >> 0) % 2 === 0 ? -1 : 1;
      let markY = ((Math.random() * 600) >> 0) % 2 === 0 ? -1 : 1;
      let opt = this.hiddenOption || {};
      let easing =
        typeof opt.easing === "function"
          ? opt.easing()
          : opt.easing || TWEEN.Easing.Quadratic.InOut;
      new TWEEN.Tween(data, group)
        .to(
          {
            x: Math.random() * (markX * 400) + markX * this.cWidth,
            y: Math.random() * (markY * 300) + markY * this.cHeight,
            z: -100 + Math.random() * 50,
          },
          opt.duration || 1000
        )
        .easing(easing)
        .delay(opt.delay || 0)
        .onUpdate(() => {
          mesh.position.set(data.x, data.y, data.z);
        })
        .onComplete(() => {
          group.removeAll();
          mesh.visible = false;
        })
        .start();
    },
    _startTween(mesh, offsetX, offsetY, rotateXLength, xSize, ySize) {
      let { x, y, z } = mesh.position;
      let rotation = mesh.rotation;
      let group = mesh.userData.group || new TWEEN.Group();
      // 绑定动画组到对应的对象上
      mesh.userData.group = group;
      let data = {
        x,
        y,
        z,
        rx: rotation.x,
        ry: rotation.y,
        rz: rotation.z,
      };
      // 随机旋转
      let targetRotation = {
        rx: rotation.x,
        ry: rotation.y,
        rz: rotation.z,
      };
      targetRotation.rx = 0;
      targetRotation.ry = 0;
      targetRotation.rz = 0;
      if (rotationIndex === 0) {
        targetRotation.ry += (rotationDirection * Math.PI) / 2;
      }
      if (rotationIndex === 1) {
        targetRotation.rx += (rotationDirection * Math.PI) / 2;
      }
      let opt = this.startOption || {};
      let easing =
        typeof opt.easing === "function"
          ? opt.easing()
          : opt.easing || TWEEN.Easing.Quadratic.Out;
      new TWEEN.Tween(data, group)
        .to(
          {
            x: offsetX * (rotateXLength + 1),
            y: offsetY * (ySize + 1),
            z: -rotateXLength * 2,
            ...targetRotation,
          },
          opt.duration || 1000
        )
        .easing(easing)
        .delay(opt.delay || 0)
        .onUpdate(() => {
          mesh.position.set(data.x, data.y, data.z);
          mesh.rotation.x = data.rx;
          mesh.rotation.y = data.ry;
          mesh.rotation.z = data.rz;
        })
        .onComplete(() => {
          group.removeAll();
          // 结束动画
          this._endTween(mesh, offsetX, offsetY, xSize, ySize);
        })
        .start();
    },
    _endTween(mesh, offsetX, offsetY, xSize, ySize) {
      let { x, y, z } = mesh.position;
      let group = mesh.userData.group2 || new TWEEN.Group();
      mesh.userData.group2 = group;
      let data = {
        x,
        y,
        z,
      };
      let opt = this.endOption || {};
      let easing =
        typeof opt.easing === "function"
          ? opt.easing()
          : opt.easing || TWEEN.Easing.Quadratic.InOut;
      new TWEEN.Tween(data, group)
        .to(
          {
            x: offsetX * (xSize + this.cubeSpace),
            y: offsetY * (ySize + this.cubeSpace),
            z: 0,
          },
          opt.duration || 1000
        )
        .easing(easing)
        .delay(opt.delay || 0)
        .onUpdate(() => {
          mesh.position.set(data.x, data.y, data.z);
        })
        .onComplete(() => {
          group.removeAll();
          this.isAnimating = false;
          cubeAniComplete--;
          if (cubeAniComplete > 0) return false;
          this.play();
        })
        .start();
    },
    _changeTween(mesh, offsetX, offsetY, rotateXLength, xSize, ySize) {
      // 这里主要是在进行下一次图片切入前，先打乱位置，进行平滑的过渡
      let { x, y, z } = mesh.position;
      let rotaion = mesh.rotation;
      let data = {
        x,
        y,
        z,
        rx: rotaion.x,
        ry: rotaion.y,
        rz: rotaion.z,
        time: 0,
      };
      let group = mesh.userData.group3 || new TWEEN.Group();
      mesh.userData.group3 = group;
      let { i, j } = mesh.userData;
      let moveData = this._getChangeTweenMoveData({ i, j });
      let opt = this.changeOption || {};
      let easing =
        typeof opt.easing === "function"
          ? opt.easing()
          : opt.easing || TWEEN.Easing.Quadratic.Out;
      let duration = opt.duration || 1000;
      let delay = (opt.delay || 0) + (moveData.delay || 0);
      this.offsetDelay = Math.max(moveData.delay || 0, this.offsetDelay);
      // 起始
      let source = { ...data };
      let target = {
        x: x + moveData.x,
        y: y + moveData.y,
        z: z + moveData.z,
        rx: source.rx + (moveData.rx || 0),
        ry: source.ry + (moveData.ry || 0),
        rz: source.rz + (moveData.rz || 0),
        time: duration,
      };
      new TWEEN.Tween(data, group)
        .to(target, duration)
        .easing(easing)
        .delay(delay)
        .onUpdate(() => {
          let res = moveData.count
            ? moveData.count({ ...source, time: data.time }, { ...target })
            : { ...data };
          mesh.position.set(res.x, res.y, res.z);
          mesh.rotation.set(
            res.rx || data.rx,
            res.ry || data.ry,
            res.rz || data.rz
          );
        })
        .onComplete(() => {
          group.removeAll();
          // 还原镜头
          restoreCamera();
          // 这里开始进行下一次图片切入并还原所有立方体的位置
          this._startTween(mesh, offsetX, offsetY, rotateXLength, xSize, ySize);
        })
        .start();
    },
    _initImage() {
      let item = this.items[this.currentIndex] || null;
      console.log(item, "item======")
      if (!item) return false;
      // 获取对应条目的离屏canvas
      let canvas = drawImages[this.currentIndex];
      let context = canvas.getContext("2d");
      this.imageCanvas = canvas;
      console.log(canvas,"canvas===")
      let { width, height } = canvas;
      // 确定过渡类型
      changeIndex = (Math.random() * changeArr.length - 0.1) >> 0;
      // 确定旋转类型
      rotationIndex = (Math.random() * 2 - 0.1) >> 0;
      // 确定旋转方向
      rotationDirection = ((Math.random() * 10) >> 0) % 2 === 0 ? -1 : 1;
      // console.log(rotationDirection, rotationIndex)
      // 为了保证过渡效果，在发生小方块数量变化的时候一律采用随机动画
      if (item.size) {
        if (this.size[0] !== item.size[0] || this.size[1] !== item.size[1])
          changeIndex = 0;
      } else {
        if (
          this.size[0] !== this.defaultSize[0] ||
          this.size[1] !== this.defaultSize[1]
        )
          changeIndex = 0;
      }

      // 获取横纵比
      this.size = item.size || this.defaultSize;
      // 设定在webGL中的图片范围
      this.iHeight = this.cHeight; // 与容器等高
      this.iWidth = (this.iHeight / height) * width; // 宽度进行缩放
      // 进行图片切换的动画
      this._switchImage({ canvas, context, width, height, item });
      // 生成方块
      this._initCube();
      // 方块变化动画
      this._initPosition();
    },
    _switchImage({ canvas, context, width, height, item }) {
      context.clearRect(0, 0, width, height);
      // 当没有前一张图片的时候，不用编写图片切换的过渡效果
      if (!prevImage) {
        context.save();
        // 重新绘制当前canvas保存的图像
        context.drawImage(canvas._imgElement, 0, 0);
        context.restore();
        if (material) {
          material.map.needsUpdate = true;
        }
        prevImage = canvas._imgElement;
        return false;
      }
      // 否则进行图片切换的过渡操作
      let defaultOption = {
        // 动画方式
        name: "translate",
        // 运动类型 (L: 左 T: 顶 R: 右 B: 底 C: 中 X: 水平 Y: 纵向 A: 所有方向 2: To)
        type: "LT2RB",
        // 持续时间
        duration: 3000,
        // 延迟
        delay: 0,
        // 动画曲线(记得要用TWEEN内置的曲线，否则不识别)
        easing: TWEEN.Easing.Quadratic.InOut,
      };
      this._animateImage(
        {
          ...Object.assign({}, defaultOption, item.animate || {}),
        },
        context,
        canvas
      );
    },
    _animateImage(data = {}, context, canvas) {
      if (!context || !canvas || drawImages.length === 0) return false;
      let maxDuaration = this.animateDuration;
      // 定义一组动画
      let animation = {};
      // 定义动画方式
      const tweenAnimate = (start, target, update = function() {}) => {
        let source = { ...start };
        let delay = Math.min(data.delay || 0, maxDuaration - 1000);
        let duration = Math.min(data.duration, maxDuaration - delay);
        new TWEEN.Tween(source)
          .to(
            {
              ...target,
            },
            duration
          )
          .easing(data.easing)
          .delay(delay)
          .onStart(() => {
            // 更新纹理
            texture = new THREE.CanvasTexture(canvas);
            // 释放前材质的纹理
            material.map.dispose();
            // 重新绑定纹理到材质
            material.map = texture;
          })
          .onUpdate(() => {
            let x = source.offsetX / 100;
            let y = source.offsetY / 100;
            if (drawImages.length === 0 || !prevImage) return false;
            update(x, y);
            if (material) {
              material.map.needsUpdate = true;
            }
          })
          .onComplete(() => {
            // 更新上一图片
            prevImage = canvas._imgElement;
          })
          .start();
      };
      // 平移
      animation.translate = (type) => {
        // 前图片的尺寸
        let piWidth = prevImage.naturalWidth;
        let piHeight = prevImage.naturalHeight;
        // 当前图片的尺寸
        let [width, height] = [canvas.width, canvas.height];
        const translate = {
          // 左上到右下
          LT2RB: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                (1 - x) * width,
                (1 - y) * height,
                width * x,
                height * y,
                0,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 右上到左下
          RT2LB: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                (1 - y) * height,
                width * x,
                height * y,
                (1 - x) * width,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 上到下
          T2B: () => {
            let source = { offsetX: 100, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                (1 - y) * height,
                width * x,
                height * y,
                0,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 左到右
          L2R: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                (1 - x) * width,
                0,
                width * x,
                height * y,
                0,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 右到左
          R2L: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width * x,
                height * y,
                (1 - x) * width,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 下到上
          B2T: () => {
            let source = { offsetX: 100, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width * x,
                height * y,
                0,
                (1 - y) * height,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 右下到左上
          RB2LT: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width * x,
                height * y,
                (1 - x) * width,
                (1 - y) * height,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 左下到右上
          LB2RT: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                (1 - x) * width,
                0,
                width * x,
                height * y,
                0,
                (1 - y) * height,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 从中心发散
          C2A: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerX = width / 2;
              let centerY = height / 2;
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width,
                height,
                centerX - (x * width) / 2,
                centerY - (y * height) / 2,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 从中心水平发散
          C2X: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerX = width / 2;
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                centerX * x,
                height * y,
                centerX * (1 - x),
                0,
                centerX * x,
                height * y
              );
              context.drawImage(
                canvas._imgElement,
                width * (1 - x / 2),
                0,
                centerX * x,
                height * y,
                centerX,
                0,
                centerX * x,
                height * y
              );
              context.restore();
            });
          },
          // 从中心纵向发散
          C2Y: () => {
            let source = { offsetX: 100, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerY = height / 2;
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width * x,
                centerY * y,
                0,
                centerY * (1 - y),
                width * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                0,
                height * (1 - y / 2),
                width * x,
                centerY * y,
                0,
                centerY,
                width * x,
                centerY * y
              );
              context.restore();
            });
          },
          // 向中心发散
          A2C: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerX = width / 2;
              let centerY = height / 2;
              context.drawImage(
                canvas._imgElement,
                (1 - x) * centerX,
                (1 - y) * centerY,
                centerX * x,
                centerY * y,
                0,
                0,
                centerX * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                centerX,
                (1 - y) * centerY,
                centerX * x,
                centerY * y,
                (1 - x / 2) * width,
                0,
                centerX * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                centerX,
                centerY,
                centerX * x,
                centerY * y,
                (1 - x / 2) * width,
                (1 - y / 2) * height,
                centerX * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                (1 - x) * centerX,
                centerY,
                centerX * x,
                centerY * y,
                0,
                (1 - y / 2) * height,
                centerX * x,
                centerY * y
              );
              context.restore();
            });
          },
          // 向中心水平发散
          X2C: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerX = width / 2;
              context.drawImage(
                canvas._imgElement,
                centerX * (1 - x),
                0,
                centerX * x,
                height * y,
                0,
                0,
                centerX * x,
                height * y
              );
              context.drawImage(
                canvas._imgElement,
                centerX,
                0,
                centerX * x,
                height * y,
                (1 - x / 2) * width,
                0,
                centerX * x,
                height * y
              );
              context.restore();
            });
          },
          // 向中心纵向发散
          Y2C: () => {
            let source = { offsetX: 100, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerY = height / 2;
              context.drawImage(
                canvas._imgElement,
                0,
                centerY * (1 - y),
                width * x,
                centerY * y,
                0,
                0,
                width * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                0,
                centerY,
                width * x,
                centerY * y,
                0,
                (1 - y / 2) * height,
                width * x,
                centerY * y
              );
              context.restore();
            });
          },
        };
        translate[type]();
      };
      // 覆盖
      animation.cover = (type) => {
        // 前图片的尺寸
        let piWidth = prevImage.naturalWidth;
        let piHeight = prevImage.naturalHeight;
        // 当前图片的尺寸
        let [width, height] = [canvas.width, canvas.height];
        const cover = {
          // 左上到右下
          LT2RB: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width * x,
                height * y,
                0,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 右上到左下
          RT2LB: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                (1 - x) * width,
                0,
                width * x,
                height * y,
                (1 - x) * width,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 上到下
          T2B: () => {
            let source = { offsetX: 100, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width * x,
                height * y,
                0,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 左到右
          L2R: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width * x,
                height * y,
                0,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 右到左
          R2L: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                (1 - x) * width,
                0,
                width * x,
                height * y,
                (1 - x) * width,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 下到上
          B2T: () => {
            let source = { offsetX: 100, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                (1 - y) * height,
                width * x,
                height * y,
                0,
                (1 - y) * height,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 右下到左上
          RB2LT: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                (1 - x) * width,
                (1 - y) * height,
                width * x,
                height * y,
                (1 - x) * width,
                (1 - y) * height,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 左下到右上
          LB2RT: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                (1 - y) * height,
                width * x,
                height * y,
                0,
                (1 - y) * height,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 从中心发散
          C2A: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerX = width / 2;
              let centerY = height / 2;
              context.drawImage(
                canvas._imgElement,
                centerX - (x * width) / 2,
                centerY - (y * height) / 2,
                width * x,
                height * y,
                centerX - (x * width) / 2,
                centerY - (y * height) / 2,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 从中心水平发散
          C2X: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerX = width / 2;
              context.drawImage(
                canvas._imgElement,
                centerX - (x * width) / 2,
                0,
                width * x,
                height * y,
                centerX - (x * width) / 2,
                0,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 从中心纵向发散
          C2Y: () => {
            let source = { offsetX: 100, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerY = height / 2;
              context.drawImage(
                canvas._imgElement,
                0,
                centerY - (y * height) / 2,
                width * x,
                height * y,
                0,
                centerY - (y * height) / 2,
                width * x,
                height * y
              );
              context.restore();
            });
          },
          // 向中心发散
          A2C: () => {
            let source = { offsetX: 0, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerX = width / 2;
              let centerY = height / 2;
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                centerX * x,
                centerY * y,
                0,
                0,
                centerX * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                (1 - x / 2) * width,
                0,
                centerX * x,
                centerY * y,
                (1 - x / 2) * width,
                0,
                centerX * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                0,
                (1 - y / 2) * height,
                centerX * x,
                centerY * y,
                0,
                (1 - y / 2) * height,
                centerX * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                (1 - x / 2) * width,
                (1 - y / 2) * height,
                centerX * x,
                centerY * y,
                (1 - x / 2) * width,
                (1 - y / 2) * height,
                centerX * x,
                centerY * y
              );
              context.restore();
            });
          },
          // 向中心水平发散
          X2C: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerX = width / 2;
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                centerX * x,
                height * y,
                0,
                0,
                centerX * x,
                height * y
              );
              context.drawImage(
                canvas._imgElement,
                (1 - x / 2) * width,
                0,
                centerX * x,
                height * y,
                (1 - x / 2) * width,
                0,
                centerX * x,
                height * y
              );
              context.restore();
            });
          },
          // 向中心纵向发散
          Y2C: () => {
            let source = { offsetX: 100, offsetY: 0 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              // 绘制当前图片
              let centerY = height / 2;
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width * x,
                centerY * y,
                0,
                0,
                width * x,
                centerY * y
              );
              context.drawImage(
                canvas._imgElement,
                0,
                (1 - y / 2) * height,
                width * x,
                centerY * y,
                0,
                (1 - y / 2) * height,
                width * x,
                centerY * y
              );
              context.restore();
            });
          },
        };
        cover[type]();
      };
      // 淡入淡出
      animation.fade = (type) => {
        // 前图片的尺寸
        let piWidth = prevImage.naturalWidth;
        let piHeight = prevImage.naturalHeight;
        // 当前图片的尺寸
        let [width, height] = [canvas.width, canvas.height];
        let fade = {
          // 淡入
          In: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              console.log(x, y);
              context.clearRect(0, 0, width, height);
              context.save();
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              context.restore();
              context.save();
              context.globalAlpha = x;
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height
              );
              context.restore();
            });
          },
          // 淡出
          Out: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              console.log(x, y);
              context.clearRect(0, 0, width, height);
              context.save();
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height
              );
              context.restore();
              context.save();
              context.globalAlpha = 1 - x;
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              context.restore();
            });
          },
          // 淡入淡出
          InOut: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              console.log(x, y);
              context.clearRect(0, 0, width, height);
              context.save();
              context.globalAlpha = x;
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height
              );
              context.restore();
              context.save();
              context.globalAlpha = 1 - x;
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              context.restore();
            });
          },
          // 淡出淡入
          OutIn: () => {
            let source = { offsetX: 0, offsetY: 100 };
            let target = { offsetX: 100, offsetY: 100 };
            tweenAnimate(source, target, (x, y) => {
              console.log(x, y);
              context.clearRect(0, 0, width, height);
              context.save();
              context.globalAlpha = 1 - x;
              // 绘制前图片
              context.drawImage(
                prevImage,
                0,
                0,
                piWidth,
                piHeight,
                0,
                0,
                piWidth,
                piHeight
              );
              context.restore();
              context.save();
              context.globalAlpha = x;
              // 绘制当前图片
              context.drawImage(
                canvas._imgElement,
                0,
                0,
                width,
                height,
                0,
                0,
                width,
                height
              );
              context.restore();
            });
          },
        };
        fade[type]();
      };
      animation[data.name](data.type);
    },
    // 组图片加载
    _loadImages(callback = function() {}) {
      let items = this.items || [];
      let len = items.length;
      // 统计图片加载动作反馈数
      let num = 0;
      if (len === 0) {
        callback();
        return false;
      }
      items.forEach((item, index) => {
        this._loadImage(item, index, () => {
          num++;
          if (num === len) {
            // 图片全部加载完成
            callback();
          }
        });
      });
    },
    // 图片加载主方法
    _loadImage(item, index, callback = function() {}) {
      if (!item) return false;
      // 创建对应条目的离屏canvas
      let canvas = drawImages[index] || document.createElement("canvas");
      drawImages[index] = canvas;
      let context = canvas.getContext("2d");
      context.clearRect(0, 0, canvas.width, canvas.height);
      // 图片加载处理
      let img = new Image();
      img.crossOrigin = "anonymous";
      img.onload = () => {
        let width = img.naturalWidth;
        let height = img.naturalHeight;
        canvas.width = width;
        canvas.height = height;
        context.save();
        context.drawImage(img, 0, 0);
        // 将img挂载到对应的canvas下
        canvas._imgElement = img;
        context.restore();
        this.cvLoading = false;
        callback();
      };
      img.onerror = function() {
        // 加载失败也进行操作完成的反馈
        callback();
      };
      img.src = item.src;
      console.log(img,"img====")
    },
  },
};
</script>

<style scoped>
.slider-3d {
  position: relative;
  height: auto;
}

.slider-3d-box {
  position: relative;
  height: auto;
}
</style>
