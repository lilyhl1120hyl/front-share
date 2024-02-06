

# 1, npm(yarn | pnpm) create vite


# 2, npm install -D typescript vue-tsc


```
// tsconfig.json
{
  "compilerOptions": {
    "target": "esnext",
    "module": "esnext",
    "strict": true,
    "jsx": "preserve",
    "moduleResolution": "node",
    "isolatedModules": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "useDefineForClassFields": true,
    "sourceMap": true,
    "baseUrl": ".",
    "types": [
      "webpack-env"
    ],
    "paths": {
      "@/*": [
        "src/*"
      ]
    },
    "lib": [
      "esnext",
      "dom",
      "dom.iterable",
      "scripthost"
    ]
  },
  "include": [
    "src/**/*.ts",
    "src/**/*.tsx",
    "src/**/*.vue",
    "tests/**/*.ts",
    "tests/**/*.tsx"
  ],
  "exclude": [
    "node_modules"
  ]
}

```

// package.json
{
    ...
    "scripts": {
      "dev": "vite --host",
      "build": "vue-tsc && vite build",
    }
}


# 3,npm install vue-router vuex(or pinia)

   ###  npm i pinia-plugin-persist --save
```
// src/main.ts
import { createApp } from "vue";
import router from "./router";
import store from "./store";
import "./style.css";
import App from "./App.vue";

createApp(App).use(router).use(store).mount("#app");

// or

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router'
import App from './App.vue'

import "./style.css";

const app = createApp(App)

app.use(createPinia())
app.use(router)

app.mount('#app')


```

# 4, # use npm or yarn or pnpm
npm install -D eslint prettier eslint-config-prettier eslint-plugin-prettier eslint-plugin-vue @typescript-eslint/parser vue-eslint-parser

```
// .eslintrc.js
module.exports = {
  root: true,
  env: {
    node: true,
    // The Follow config only works with eslint-plugin-vue v8.0.0+
    "vue/setup-compiler-macros": true,
  },
  extends: [
    "plugin:vue/vue3-essential",
    "eslint:recommended",
    "@vue/typescript/recommended",
    "plugin:prettier/recommended",
  ],
  plugins: ["vue"],
  parser: "vue-eslint-parser",
  parserOptions: {
    parser: "@typescript-eslint/parser",
    ecmaVersion: 2020, 
    sourceType: "module",
  },
  rules: {
    "no-console": import.meta.env.NODE_ENV === "production" ? "warn" : "off",
    "no-debugger": import.meta.env.NODE_ENV === "production" ? "warn" : "off",
    "prettier/prettier": ["error", { endOfLine: "auto" }],
    "no-unreachable": "warn",
    "vue/no-unused-vars": "warn",
    "@typescript-eslint/no-var-requires": "off",
  },
  globals: {},
};

```

# 5, npm install -D less


# 6, # use npm or yarn or pnpm
npm install -g nrm

nrm use taobao
# use npm or yarn or pnpm
npm install -D electron

```
// electron/main.js
import { app, BrowserWindow } from "electron";
const path = require('path');

const createWindow = () => {
  const win = new BrowserWindow({
    webPreferences: {
      contextIsolation: false, // 是否开启隔离上下文
      nodeIntegration: true, // 渲染进程使用Node API
      preload: path.join(__dirname, "./preload.ts"), // 需要引用js文件
    },
  });


  // 如果打包了，渲染index.html
  if (app.isPackaged) {
    win.loadFile(path.join(__dirname, "../dist/index.html"));
  } else {
    win.loadURL("http://127.0.0.1:5173");
  }
};


app.whenReady().then(() => {
  createWindow(); // 创建窗口
  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});


// 关闭窗口
app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});


```

// package.json
{
  "name": "electron-vue-demo",
  "private": true,
  "version": "0.0.0",
  "type": "commonjs", // 注意，这里必须被指定为commonjs，否则打包时无法解析node的commonjs模块
  "author": "cyanAir",
  "main": "./electron/main.js", // 主进程入口
    "scripts": {
    "dev": "vite --host",
    "build": "vue-tsc && vite build",
    "dev:electron": "./electron/main.js"
  },
  ...
}


先运行npm run dev然后运行npm run dev:electron


# 7, # use npm or yarn or pnpm
npm install -D vite-plugin-electron

import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

import electron from "vite-plugin-electron";
import * as path from "path";

export default defineConfig({
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "src"),
      "#": path.resolve(__dirname, "electron"),
    }
  },
  plugins: [
    vue(),
    electron({
      entry: ["electron/main.js"], // electron主进程调用入口文件
      vite: {
        build: {
          rollupOptions: {
            // c/c++链接库
            external: [],
          },
        },
      },
    }),
  ],
  build: {
    emptyOutDir: true, // 默认情况下，若 outDir 在 root 目录下，则 Vite 会在构建时清空该目录
  },
});


// package.json
{
    ...
    "main": "./dist-electron/main.js", // 主进程入口
    ...
}


#8, # use npm or yarn or pnpm
# 取决于生产环境是否需要使用，安装在dep还是devDep下需要自己决定
npm install -D electron-devtools-installer

```
// electron/main.js
import installExtension, { VUEJS3_DEVTOOLS } from "electron-devtools-installer";
const isDevelopment = !import.meta.env.PROD; // 环境
electron应用中ctrl + shift + i

...

app.whenReady().then(() => {
  createWindow(); // 创建窗口
  if (isDevelopment) {
    // Install Vue Devtools
    try {
      await installExtension(VUEJS3_DEVTOOLS);
    } catch (e: any) {
      console.error("Vue Devtools failed to install:", e.toString());
    }
  }
  win.webContents.openDevTools({ mode: "right", activate: true }); // 默认在右侧打开开发工具
  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});
```

# use npm or yarn or pnpm
npm install -D electron-builder

```
// package.json
{
  ...
  "build": {
    "appId": "com.my-website.my-app", // 应用id，两个如果相同的话，安装会覆盖
    "productName": "MyApp", // 应用名，打包后的应用名称
    "copyright": "Copyright © 2022 ${author}", // 商标
    "asar": true, // 是否使用asar归档文件，详情可以看https://www.electronjs.org/zh/docs/latest/tutorial/asar-archives
    "npmRebuild": false, // 是否每次打包时都用npm rebuild重新构建node模块生成对应的动态链接库
    "directories": {
      "buildResources": "assets", // 静态资源路径
      "output": "release/${version}" // 输出地址
    },
    "files": [	// 需要进行打包的文件/目录
      "dist/**/*",
      "dist-electron/**/*"
    ],
    "win": { // windows打包相关配置
      "target": [ // 打包产物
        {
          "target": "nsis", // 使用的安装包程序
          "arch": [ // 架构
            "x64"
          ]
        }
      ],
      "artifactName": "${productName}_${version}.${ext}" // 安装包名称
    },
    "nsis": { // nsis安装包程序配置
      "oneClick": false, // 是否一键安装
      "language": "2052", // 默认语言，2052-简体中文
      "perMachine": false, // 是否默认为PC上的每一个用户安装
      "allowToChangeInstallationDirectory": true, // 是否允许自定义安装目录
      "deleteAppDataOnUninstall": false // 卸载时是否删除AppData目录下的文件
    }
  },
}

```


```
{
  ...
  "script": {
      ...
      "electron:build": "vue-tsc && vite build && electron-builder",
  },
  ...
}


```

```
// tsconfig.json
{
  "compilerOptions": {
    ...
    "noEmit": true,
  },
  ...
}


```