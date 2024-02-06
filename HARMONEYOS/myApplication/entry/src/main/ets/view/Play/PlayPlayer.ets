

import { VideoController } from '../../controller/VideoController';
import  CommonConstants  from '../../common/constants/CommonConstant';
import { PlayConstants } from '../../common/constants/PlayConstants';
import resourceManager from '@ohos.resourceManager';

@Component
export struct PlayPlayer {
  private playVideoModel: VideoController = new VideoController();
  @Consume src: resourceManager.RawFileDescriptor;
  @Consume iSrc: string;
  @Consume index: number;
  @State volume: number = PlayConstants.VOLUME;
  @State volumeShow: boolean = PlayConstants.VOLUME_SHOW;
  @State bright: number = PlayConstants.BRIGHT;
  @State brightShow: boolean = PlayConstants.BRIGHT_SHOW;
  private xComponentController = new XComponentController();
  private surfaceID: string = '';

  aboutToAppear() {
    if (this.playVideoModel !== null) {
      this.playVideoModel.initPlayerThis(this);
    }
  }

  build() {
    Stack() {
      XComponent({
        id: PlayConstants.PLAYER_ID,
        type: PlayConstants.PLAYER_TYPE,
        libraryname: PlayConstants.PLAYER_LIBRARY_NAME,
        controller: this.xComponentController
      })
        .onLoad(async () => {
          this.xComponentController.setXComponentSurfaceSize({
            surfaceWidth: PlayConstants.PLAYER_SURFACE_WIDTH,
            surfaceHeight: PlayConstants.PLAYER_SURFACE_HEIGHT
          });
          this.surfaceID = this.xComponentController.getXComponentSurfaceId();
          this.playVideoModel.firstPlay(this.index, this.src, this.iSrc, this.surfaceID);
        })
        .width(CommonConstants.FULL_PERCENT)
        .height(CommonConstants.FULL_PERCENT)

      Stack() {
        Progress({
          value: Math.floor(this.volume * CommonConstants.ONE_HUNDRED),
          type: ProgressType.Ring
        })
          .width(CommonConstants.FULL_PERCENT)
          .aspectRatio(CommonConstants.ASPECT_RATIO)
        Image($r('app.media.ic_volume'))
          .width(PlayConstants.PLAYER_IMAGE_WIDTH)
          .aspectRatio(CommonConstants.ASPECT_RATIO)
      }
      .width(PlayConstants.PLAYER_STACK_WIDTH)
      .aspectRatio(CommonConstants.ASPECT_RATIO)
      .visibility(this.volumeShow ? Visibility.Visible : Visibility.Hidden)

      Stack() {
        Progress({
          value: Math.floor(this.bright * CommonConstants.ONE_HUNDRED),
          type: ProgressType.Ring
        })
          .width(CommonConstants.FULL_PERCENT)
          .aspectRatio(CommonConstants.ASPECT_RATIO)
        Image($r('app.media.ic_brightness'))
          .width(PlayConstants.PLAYER_IMAGE_WIDTH)
          .aspectRatio(CommonConstants.ASPECT_RATIO)
      }
      .width(PlayConstants.PLAYER_STACK_WIDTH)
      .aspectRatio(CommonConstants.ASPECT_RATIO)
      .visibility(this.brightShow ? Visibility.Visible : Visibility.Hidden)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
  }
}