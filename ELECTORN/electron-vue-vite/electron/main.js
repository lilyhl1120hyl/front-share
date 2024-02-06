import { app, BrowserWindow } from "electron";
const path = require('path');
import installExtension, { VUEJS3_DEVTOOLS } from "electron-devtools-installer";


const isDevelopment = !import.meta.env.PROD; // 环境

const createWindow = () => {
  const win = new BrowserWindow({
    webPreferences: {
      contextIsolation: false, // 是否开启隔离上下文
      nodeIntegration: true, // 渲染进程使用Node API
      preload: path.join(__dirname, "./preload/index.js"), // 需要引用js文件
    },
  });


  // 如果打包了，渲染index.html
  if (app.isPackaged) {
    win.loadFile(path.join(__dirname, "../dist/index.html"));
  } else {
    win.loadURL("http://127.0.0.1:5173");
  }
};


app.whenReady().then(async() => {
  createWindow(); // 创建窗口

  if (isDevelopment) {
    // Install Vue Devtools
    try {
      await installExtension(VUEJS3_DEVTOOLS);
    } catch (e) {
      console.error("Vue Devtools failed to install:", e.toString());
    }
  
  win.webContents.openDevTools({ mode: "right", activate: true }); // 默认在右侧打开开发工具
  }
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




