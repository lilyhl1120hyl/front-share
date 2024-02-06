<template>
  <div class="home">
   <!-- <div class="rightMain">
      <div class="title">跳转操作</div>
      <div class="cont">
        <ul>
          <li v-for="(item, index) in objList" @click="cameraPos(item)" :key="index">{{ item.name }}</li>
        </ul>
      </div>
      <div class="title">其他操作</div>
      <div class="cont">
        <ul>
          <li @click="rotationChange">{{ rotation }}</li>
          <li @click="columnChange">添加光柱</li>
          <li @click="delAllChange">删除所有</li>
          <li @click="delMarkChange">删除美国标记点</li>
        </ul>
      </div>
      <div class="title">重置操作</div>
      <div class="cont">
        <ul>
          <li @click="reset">初始化数据</li>
        </ul>
      </div>
    </div> -->
    <threeIndex ref="threeMapId"></threeIndex>
  </div>
</template>

<script>
import threeIndex from '../components/three/Index'
export default {
  name: 'HomeView',
  components: {
    threeIndex
  },
  data () {
    return {
      objList: [
        { lon: 116.358976, lat: 39.803282, name: "中国", color: '#1FFBC6' },
        { lon: 139.812263, lat: 35.677294, name: "日本", color: '#A41FE8'},
        { lon: 77.198596, lat: 28.575136, name: "印度", color: '#E8BB1F' },
        { lon: -77.02238, lat: 38.900042, name: "美国", color: '#E81F56' },
        { lon: 31.266092, lat: 30.085626, name: "埃及", color: '#1FFBC6' },
        { lon: 103.813654, lat: 1.291125, name: '新加坡', color: '#E8BB1F' },
        { lon: -47.930912, lat: -15.781949, name: '巴西', color: '#A41FE8' },
        { lon: 149.130214, lat: -35.318235, name: '澳大利亚', color: '#E81F56' }
      ],
      objList_2: [
        { lon: 116.358976, lat: 39.803282, name: "中国column", color: '#1FFBC6' },
        { lon: 139.812263, lat: 35.677294, name: "日本column", color: '#A41FE8'},
        { lon: 77.198596, lat: 28.575136, name: "印度column", color: '#E8BB1F' },
        { lon: -77.02238, lat: 38.900042, name: "美国column", color: '#E81F56' },
        { lon: 31.266092, lat: 30.085626, name: "埃及column", color: '#1FFBC6' },
        { lon: 103.813654, lat: 1.291125, name: '新加坡column', color: '#E8BB1F' },
        { lon: -47.930912, lat: -15.781949, name: '巴西column', color: '#A41FE8' },
        { lon: 149.130214, lat: -35.318235, name: '澳大利亚column', color: '#E81F56' }
      ],
      rotation: '关闭旋转'
    }
  },
  mounted () {
    this.$nextTick(()=>{
      this.infoMap ()
    })
    
  },
  methods: {
    // 重置
    reset () {
      this.infoMap ()
    },

    // 地球添加标记点
    infoMap() {
      for (let i = 0; i < this.objList.length; i++) {
        this.$refs.threeMapId.infoMark(this.objList[i]);
      }
    },

    // 移动相机
    cameraPos(item) {
      this.$refs.threeMapId.cameraPos(item);
    },

    // 开启或关闭地球自动旋转
    rotationChange () {
      this.$refs.threeMapId.rotationY = !this.$refs.threeMapId.rotationY
      this.rotation = this.$refs.threeMapId.rotationY === true?'关闭旋转':'开启旋转'
      this.$refs.threeMapId.frameDivClose()
    },

    // 添加光柱infoColumn
    columnChange () {
      for (let i = 0; i < this.objList_2.length; i++) {
        this.$refs.threeMapId.infoColumn(this.objList_2[i]);
      }
    },

    // 删除所有标记点
    delAllChange () {
      for (let i = 0; i < this.objList.length; i++) {
        this.$refs.threeMapId.delAll(this.objList[i]);
      }
      for (let i = 0; i < this.objList_2.length; i++) {
        this.$refs.threeMapId.delAll(this.objList_2[i]);
      }
    },

    // 删除指定标记点
    delMarkChange () {
      let item = {
        name: '美国'
      }
      this.$refs.threeMapId.delMark(item)
    },
  }
}
</script>

<style>
.home {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background-color: black;
  background-image: url("/static/images/back.png");
  background-size: 100% 130%;
 
}
.rightMain {
    position: absolute;
    right: 0;
    width: 300px;
    height: 100%;
    z-index: 100;
    padding: 10px;
    box-sizing: border-box;
    color: white;
    background-color: rgba(255,255,255, .2);
   
  }
  .title {
      width: 100%;
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
    }
    .cont {
      height: 150px;
    
    }
    ul {
        padding: 0;
        margin-bottom: 0;
      
      }
      li {
          list-style: none;
          float: left;
          width: 33.33%;
          padding: 10px 0;
          text-align: center;
          cursor: pointer;
          font-size: 14px;
          &:hover {
            color: aquamarine;
          }
        }
</style>
