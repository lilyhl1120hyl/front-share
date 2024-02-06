

import { VideoController } from '../../controller/VideoController';
import CommonConstants  from '../../common/constants/CommonConstant';
import { PlayConstants } from '../../common/constants/PlayConstants';

@Component
export struct PlayProgress {
  private playVideoModel: VideoController = new VideoController();
  @State currentTime: string = PlayConstants.PROGRESS_CURRENT_TIME;
  @State totalTime: string = PlayConstants.PROGRESS_TOTAL_TIME;
  @State progressVal: number = PlayConstants.PROGRESS_PROGRESS_VAL;

  aboutToAppear() {
    if (this.playVideoModel !== null) {
      this.playVideoModel.initProgressThis(this);
    }
  }

  build() {
    Column() {
      Row() {
        Text(this.currentTime)
          .fontSize($r('app.float.slider_font_size'))
          .fontColor(Color.White)
        Slider({
          value: this.progressVal,
          step: PlayConstants.PROGRESS_STEP,
          style: SliderStyle.OutSet
        })
          .blockColor(Color.White)
          .trackColor($r('app.color.track_color'))
          .selectedColor(Color.White)
          .trackThickness(PlayConstants.PROGRESS_TRACK_THICKNESS)
          .layoutWeight(1)
          .margin({ left: PlayConstants.PROGRESS_MARGIN_LEFT })
          .onChange((value: number, mode: SliderChangeMode) => {
            this.playVideoModel.setSeekTime(value, mode);
          })
        Text(this.totalTime)
          .fontSize($r('app.float.slider_font_size'))
          .fontColor(Color.White)
          .margin({ left: PlayConstants.PROGRESS_MARGIN_LEFT })
      }
      .width(PlayConstants.PROGRESS_ROW_WIDTH)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }
}