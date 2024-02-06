import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import routers from './router';

const App = () => {
  return (
    <Router>
      <Routes>
        {routers.map((item, index) => {
          return (
            <Route
              key={index}
              exact
              path={item.path}
              element={<item.component />} // 不是老版本的：component 或 render
              // onEnter、onBeforeMount、onMounted事件，会在组件初始化时执行一次，切换路由不执行
            />
          );
        })}
      </Routes>
    </Router>
  );
};

export default App;
