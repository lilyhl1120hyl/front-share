<template>
  <div class="home-container">
    <div v-for="(item, index) in list" :key="index" class="card">
      <router-link :to="item.path" class="card-link">
        <img src="../assets/logo.png" alt="" />
        {{ item.name }}
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: "Home",
  data() {
    return {
      list: [
        { name: "three 初始化", path: "/threeInit" },
        { name: "three 全景-一张图", path: "/panorama" },
        { name: "three 全景-六张图", path: "/panoramacube" },
        { name: "three 全景-全景图", path: "/panoramapath" },
        { name: "three VR全景", path: "/panoramavr" },
        { name: "three 全景看房", path: "/panoramaHouse" },
        { name: "three 智慧园区", path: "/smartPark" },
        { name: "three 汽车换彩", path: "/carColor" },
        { name: "three 汽车展厅", path: "/carMove" },
        { name: "three 汽车物理动画", path: "/carCannon" },
        { name: "three 切换零部件Model", path: "/changeModel" },
        { name: "three 地球", path: "/earthModel" },
        { name: "three 图片动效", path: "/pictureChange" },
      ],
    };
  },
  methods: {},
  mounted() {},
};
</script>
<style scoped>
.home-container {
  width: 100%;
  height: 100vh;
  background: #333232;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  justify-items: center;
}

.card {
  width: 120px;
  height: 160px;
  margin: 20px;
  background: #7c7979;
  color: #fff;
  border-radius: 6px;
}
.card-link {
  color: #fff;
  text-decoration: none;
}
img {
  width: 100%;
  height: 160px;
}
</style>
