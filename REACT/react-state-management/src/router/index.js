

import Home from "../pages/home";
import ContextPage from "../pages/contextStatePage";
import ReduxPage from "../pages/reduxStatePage";
import MobxPage from "../pages/mobxStatePage";
import FluxPage from "../pages/fluxStatePage";

const routers = [
  {
    title: '首页',
    path: '/',
    component: Home,
  },
  {
    title: 'context状态管理',
    path: '/contextPage',
    component: ContextPage,
  },
  {
    title: 'redux章台管理',
    path: '/reduxPage',
    component: ReduxPage,
  },
  {
    title: 'mobx状态管理',
    path: '/mobxPage',
    component: MobxPage,
  },
  {
    title: 'flux状态管理',
    path: '/fluxPage',
    component: FluxPage,
  },
];

export default routers;
