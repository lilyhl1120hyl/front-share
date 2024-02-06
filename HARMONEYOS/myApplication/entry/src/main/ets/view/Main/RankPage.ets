
import CommonConstants from '../../common/constants/CommonConstant';
import ClassifyComponent from '../Rank/view/ClassifyComponent';
import SearchComponent from '../Rank/view/SearchComponent';
import SwiperComponent from '../Rank/view/SwiperComponent';
import WaterFlowComponent from '../Rank/view/WaterFlowComponent';

@Component
export default struct RankPage {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Image($r('app.media.ic_app_background'))
        .width(CommonConstants.FULL_WIDTH)
        .height($r('app.float.image_background_height'))
        .objectFit(ImageFit.Cover)
      Column() {
        SearchComponent()
        ClassifyComponent()
        SwiperComponent()
        WaterFlowComponent()
      }
      .padding({
        left: $r('app.float.home_margin_left'),
        right: $r('app.float.home_margin_right')
      })
    }
    .backgroundColor($r('app.color.home_background_color'))
  }
}