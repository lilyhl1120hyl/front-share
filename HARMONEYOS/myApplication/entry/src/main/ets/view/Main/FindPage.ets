

import TabBar from '../../view/Find/TabBarsComponent';
import CommonConstants from '../../common/constants/CommonConstant';

const {LAYOUT_WIDTH_OR_HEIGHT, STORE} = CommonConstants;

@Component
export default struct FindPage {
  build() {
    Row() {
      Navigation() {
        Column() {
          TabBar()
        }
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .justifyContent(FlexAlign.Center)
      }
      .size({ width: LAYOUT_WIDTH_OR_HEIGHT, height: LAYOUT_WIDTH_OR_HEIGHT })
      .title(STORE)
      .titleMode(NavigationTitleMode.Mini)
    }
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor($r('app.color.primaryBgColor'))
  }
}