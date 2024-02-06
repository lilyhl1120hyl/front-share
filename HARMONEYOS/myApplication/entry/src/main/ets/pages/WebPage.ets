
import web_webview from '@ohos.web.webview'
import http from '@ohos.net.http';
import promptAction from '@ohos.promptAction'
import httpGet from '../httpApi/HttpUtil';
import StyleConstant from '../common/constants/StyleConstants';
import CommonConstant from '../common/constants/CommonConstant';

@Entry
@Component
struct WebPage {
  controller: web_webview.WebviewController = new web_webview.WebviewController()
  @State buttonName: Resource = $r('app.string.request_button_name');
  @State webVisibility: Visibility = Visibility.Hidden;
  @State webSrc: string = CommonConstant.SERVER;

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_network_global'))
          .height($r('app.float.image_height'))
          .width($r('app.float.image_width'))
        TextInput({ placeholder: $r('app.string.input_address'), text: this.webSrc })
          .height($r('app.float.text_input_height'))
          .layoutWeight(1)
          .backgroundColor(Color.White)
          .onChange((value: string) => {
            this.webSrc = value;
          })
      }
      .margin({
        top: $r('app.float.default_margin'),
        left: $r('app.float.default_margin'),
        right: $r('app.float.default_margin')
      })
      .height($r('app.float.default_row_height'))
      .backgroundColor(Color.White)
      .borderRadius($r('app.float.border_radius'))
      .padding({
        left: $r('app.float.default_padding'),
        right: $r('app.float.default_padding')
      })
      Row() {
        Web({ src: this.webSrc, controller: this.controller })
          .zoomAccess(true)
          .height(StyleConstant.FULL_HEIGHT)
          .width(StyleConstant.FULL_WIDTH)
      }
      .visibility(this.webVisibility)
      .height(StyleConstant.WEB_HEIGHT)
      .width(StyleConstant.FULL_WIDTH)
      .align(Alignment.Top)
      Row() {
        Button(this.buttonName)
          .fontSize($r('app.float.button_font_size'))
          .width(StyleConstant.BUTTON_WIDTH)
          .height($r('app.float.button_height'))
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.onRequest();
          })
      }
      .height($r('app.float.default_row_height'))
    }
    .width(StyleConstant.FULL_WIDTH)
    .height(StyleConstant.FULL_HEIGHT)
    .backgroundImage($r('app.media.ic_background_image', ImageRepeat.NoRepeat))
    .backgroundImageSize(ImageSize.Cover)
  }

  async onRequest() {
    if (this.webVisibility === Visibility.Hidden) {
      this.webVisibility = Visibility.Visible;
      try {
        let result = await httpGet(this.webSrc);
        if (result && result.responseCode === http.ResponseCode.OK) {
          this.controller.clearHistory();
          this.controller.loadUrl(this.webSrc);
        }
      } catch (error) {
        promptAction.showToast({
          message: $r('app.string.http_response_error')
        })
      }
    } else {
      this.webVisibility = Visibility.Hidden;
    }
  }
}