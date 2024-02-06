

import CommonConstants from '../../common/constants/CommonConstant';

@Component
export default struct PutDownRefresh {
  @Link refreshText: Resource;

  build() {
    Row() {
      Image($r('app.media.refreshing'))
        .width(CommonConstants.ICON_WIDTH)
        .height(CommonConstants.ICON_HEIGHT)
      Text(this.refreshText).fontSize(CommonConstants.NORMAL_FONT_SIZE)
    }
    .justifyContent(FlexAlign.Center)
    .width(CommonConstants.GOODS_LIST_WIDTH)
    .height(CommonConstants.GOODS_LIST_HEIGHT)
  }
}