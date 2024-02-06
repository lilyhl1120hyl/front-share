

import CommonConstants from '../../../common/constants/CommonConstant';
import { swiperImage } from '../../../viewmodel/HomeViewModel';


@Component
export default struct SwiperComponent {
  build() {
    Swiper() {
      ForEach(swiperImage, (item: Resource) => {
        Image(item)
          .width(CommonConstants.FULL_WIDTH)
          .height($r('app.float.swiper_image_height'))
          .borderRadius($r('app.float.swiper_radius'))
          .backgroundColor(Color.White)
      }, (item: Resource) => JSON.stringify(item))
    }
    .indicatorStyle({ selectedColor: $r('app.color.indicator_select') })
    .autoPlay(true)
    .itemSpace(0)
    .width(CommonConstants.FULL_WIDTH)
    .indicator(true)
    .displayCount(1)
    .margin({
      top: $r('app.float.swiper_margin_top'),
      bottom: $r('app.float.swiper_margin_bottom')
    })
  }
}