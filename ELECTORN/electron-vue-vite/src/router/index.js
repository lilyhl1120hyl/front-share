import Vue from "vue";
import VueRouter from "vue-router";
import Login from "@/views/Login/index.vue";


Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "root",
    redirect: "/index",
  },
  {
    path: "/login",
    name: "login",
    component: Login,
    meta: {
      requireAuth: false,
    },
  },
];

const router = new VueRouter({ routes });

// router.beforeEach((to, from, next) => {
//   // 1. 不需要登录的页面 || 2. 已登录 --> 直通
//   if (!to.meta.requireAuth || store.getters.isLogin) return next();
//   next({
//     path: "/login",
//     replace: true,
//   });
// });

export default router;
