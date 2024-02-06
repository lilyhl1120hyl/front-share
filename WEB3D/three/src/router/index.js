import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/threeInit',
    name: 'ThreeTest',
    component: () => import(/* webpackChunkName: "about" */ '../views/ThreeInit.vue')
  },
  {
    path: '/panorama',
    name: 'Panorama',
    component: () => import(/* webpackChunkName: "about" */ '../views/Panorama.vue')
  }, 
  {
    path: '/panoramacube',
    name: 'Panoramacube',
    component: () => import(/* webpackChunkName: "about" */ '../views/panoramacube.vue')
  }, {
    path: '/panoramapath',
    name: 'Panoramapath',
    component: () => import(/* webpackChunkName: "about" */ '../views/panaramapath.vue')
  }, {
    path:"/panoramavr",
    name:"panoramavr",
    component:()=>import(/* webpackChunkName: "about" */ '../views/panoramavr.vue')
  },{
    path:"/panoramaHouse",
    name:"panoramaHouse",
    component:()=>import(/* webpackChunkName: "about" */ '../views/panoramaHouse.vue')
  },{
    path:"/smartPark",
    name:"smartPark",
    component:()=>import(/* webpackChunkName: "about" */ '../views/smartPark.vue')
  },{
    path:"/carColor",
    name:"carColor",
    component:()=>import(/* webpackChunkName: "car" */ '../views/carColor/index.vue')
  },{
    path:"/carMove",
    name:"carMove",
    component:()=>import(/* webpackChunkName: "car" */ '../views/carMove.vue')
  },{
    path:"/carCannon",
    name:"carCannon",
    component:()=>import(/* webpackChunkName: "car" */ '../views/carCannon/index.vue')
  },{
    path:"/changeModel",
    name:"changeModel",
    component:()=>import(/* webpackChunkName: "car" */ '../views/changeModel.vue')
  },{
    path:"/earthModel",
    name:"earthModel",
    component:()=>import(/* webpackChunkName: "earth" */ '../views/HomeView.vue')
  },{
    path:"/pictureChange",
    name:"pictureChange",
    component:()=>import(/* webpackChunkName: "earth" */ '../views/changePictures.vue')
  }
  
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
