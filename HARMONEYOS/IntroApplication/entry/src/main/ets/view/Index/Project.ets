
// 使用web组件加载网页
import webview from '@ohos.web.webview'

@Component
export struct Project {
  controll:WebviewController = new webview.WebviewController()

  build() {
    Row() {
      Column() {
        Web({
          src:'https://www.bilibili.com/video/BV16X4y1g7wT/?spm_id_from=333.934.0.0',
          controller:this.controll
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
