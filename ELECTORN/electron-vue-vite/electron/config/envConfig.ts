export default {
  production: {
    VITE_ENV: "production",
    VITE_APP_URL: "./dist/index.html",
    VITE_REQUEST_URL: "请求地址"
  },
  development: {
    VITE_ENV: "development",
    VITE_APP_URL: "http://127.0.0.1:5173",
    VITE_REQUEST_URL: "请求地址"
  }
}