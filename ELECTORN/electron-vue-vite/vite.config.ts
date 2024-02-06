import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'


import electron from "vite-plugin-electron";
import * as path from "path";

// https://vitejs.dev/config/
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
})
