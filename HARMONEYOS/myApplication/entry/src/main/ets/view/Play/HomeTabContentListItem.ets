

import { VideoItem } from '../../viewmodel/VideoItem';
import { HomeConstants } from '../../common/constants/HomeConstants';
import CommonConstants  from '../../common/constants/CommonConstant';
import resourceManager from '@ohos.resourceManager';

@Component
export struct HomeTabContentListItem {
  private item: VideoItem = new VideoItem('video1', {} as resourceManager.RawFileDescriptor, 'video1.mp4');

  build() {
    Row() {
      Image(this.item.pixelMap === undefined ? $r('app.media.ic_internet') : this.item.pixelMap)
        .height(HomeConstants.IMAGE_HEIGHT)
        .width(HomeConstants.IMAGE_WIDTH)
        .margin({ left: $r('app.float.item_image_margin_left') })
        .borderRadius($r('app.float.image_border_radius'))
      Column() {
        Column() {
          Text(this.item.name)
            .fontSize($r('app.float.item_font_size'))
            .margin({
              left: $r('app.float.item_text_margin_left'),
              right: $r('app.float.item_text_margin_right')
            })
        }
        .height(CommonConstants.FULL_PERCENT)
        .width(CommonConstants.FULL_PERCENT)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)

        Divider()
          .strokeWidth(HomeConstants.DIVIDER_STROKE_WIDTH)
          .color($r('app.color.divider_color'))
          .margin({
            left: $r('app.float.item_divider_margin_left'),
            right: $r('app.float.item_divider_margin_right')
          })
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(HomeConstants.LIST_ITEM_ROW_COLUMN_WIDTH)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(HomeConstants.LIST_ITEM_ROW_HEIGHT)
  }
}