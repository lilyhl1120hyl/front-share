

import { classifyTitle } from '../../../viewmodel/HomeViewModel';
import CommonConstants from '../../../common/constants/CommonConstant';


@Component
export default struct ClassifyComponent {
  @State titleIndex: number = 0;

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      ForEach(classifyTitle, (item: Resource, index: number | undefined) => {
        if (index !== undefined) {
          Text(item)
            .fontSize($r('app.float.middle_font_size'))
            .opacity(this.titleIndex === index ? CommonConstants.FULL_OPACITY : CommonConstants.EIGHTY_OPACITY)
            .fontWeight(this.titleIndex === index ? CommonConstants.FONT_WEIGHT_FIVE : FontWeight.Normal)
            .fontColor(Color.White)
            .onClick(() => {
              this.titleIndex = index;
            })
        }
      }, (item: Resource) => JSON.stringify(item))

      Row() {
        Image($r('app.media.ic_split_line'))
          .width($r('app.float.split_line_width'))
          .height($r('app.float.split_line_height'))
        Image($r('app.media.ic_more'))
          .width($r('app.float.more_width'))
          .height($r('app.float.more_height'))
          .margin({
            left: $r('app.float.more_margin_left'),
            right: $r('app.float.more_margin_right')
          })
        Text($r('app.string.title_bar_classification'))
          .fontSize($r('app.float.middle_font_size'))
          .fontColor(Color.White)
          .opacity(this.titleIndex === CommonConstants.INVALID_INDEX ? CommonConstants.FULL_OPACITY : CommonConstants.EIGHTY_OPACITY)
          .fontWeight(this.titleIndex === CommonConstants.INVALID_INDEX ? CommonConstants.FONT_WEIGHT_FIVE : FontWeight.Normal)
      }
      .onClick(() => {
        this.titleIndex = CommonConstants.INVALID_INDEX;
      })
    }
    .width(CommonConstants.FULL_WIDTH)
    .margin({ top: $r('app.float.classify_title_margin') })
  }
}