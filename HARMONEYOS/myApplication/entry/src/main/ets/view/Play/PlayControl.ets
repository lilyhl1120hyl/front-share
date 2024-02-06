

import { VideoController } from '../../controller/VideoController';
import CommonConstants from '../../common/constants/CommonConstant';
import { PlayConstants } from '../../common/constants/PlayConstants';

@Component
export struct PlayControl {
  private playVideoModel: VideoController | null = null;
  @Consume status: number;

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_previous'))
          .width($r('app.float.control_image_width'))
          .aspectRatio(CommonConstants.ASPECT_RATIO)
          .onClick(async () => {
            if (this.playVideoModel !== null) {
              this.playVideoModel.previousVideo();
            }
            this.status = CommonConstants.STATUS_START;
          })
        Column() {
          Image(this.status === CommonConstants.STATUS_START ?
          $r('app.media.ic_pause') : $r('app.media.ic_play'))
            .width($r('app.float.control_image_width'))
            .aspectRatio(CommonConstants.ASPECT_RATIO)
            .onClick(async () => {
              if (this.playVideoModel !== null) {
                let curStatus = (this.playVideoModel.getStatus() === CommonConstants.STATUS_START);
                this.status = curStatus ? CommonConstants.STATUS_PAUSE : CommonConstants.STATUS_START;
                this.playVideoModel.switchPlayOrPause();
              }
            })
        }
        .layoutWeight(1)

        Image($r('app.media.ic_next'))
          .width($r('app.float.control_image_width'))
          .aspectRatio(CommonConstants.ASPECT_RATIO)
          .onClick(() => {
            if (this.playVideoModel !== null) {
              this.playVideoModel.nextVideo();
            }
            this.status = CommonConstants.STATUS_START;
          })
      }
      .width(PlayConstants.CONTROL_ROW_WIDTH)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }
}