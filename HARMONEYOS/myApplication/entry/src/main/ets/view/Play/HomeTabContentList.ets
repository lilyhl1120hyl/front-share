

import router from '@ohos.router';
import Logger from '../../common/utils/Logger';
import { VideoItem } from '../../viewmodel/VideoItem';
import HomeVideoListModel from '../../viewmodel/HomeVideoListModel';
import { HomeConstants } from '../../common/constants/HomeConstants';
import  CommonConstants  from '../../common/constants/CommonConstant';
import { HomeTabContentListItem } from './HomeTabContentListItem';
import { GlobalContext } from '../../common/utils/GlobalContext';
import resourceManager from '@ohos.resourceManager';

@Component
export struct HomeTabContentList {
  private currIndex: number = 0;
  @Consume videoList: Array<VideoItem>;
  @State item: VideoItem = new VideoItem('video1', {} as resourceManager.RawFileDescriptor, 'video1.mp4');

  async aboutToAppear() {
    if (this.currIndex === CommonConstants.TYPE_LOCAL) {
      this.videoList = await HomeVideoListModel.getLocalVideo();
      Logger.info(`getLocalVideo====,  ${JSON.stringify(this.videoList)}`);
    } else {
      let videoInternetList = GlobalContext.getContext().getObject('videoInternetList') as VideoItem[];
      this.videoList = videoInternetList;
      Logger.info(`videoInternetList====,  ${JSON.stringify(this.videoList)}`);
    }


  }

  build() {
    Column() {
      List({
        space: HomeConstants.LIST_SPACE,
        initialIndex: HomeConstants.LIST_INITIAL_INDEX
      }) {
        ForEach(this.videoList, (item: VideoItem, index?: number) => {
          ListItem() {
            HomeTabContentListItem({ item: item });
          }.onClick(() => {
            GlobalContext.getContext().setObject('globalVideoList', this.videoList);
            router.pushUrl({
              url: CommonConstants.PLAY_PAGE,
              params: {
                src: item.src,
                iSrc: item.iSrc,
                index: index,
                type: this.currIndex
              }
            }).catch((err: Error) => {
              Logger.error('[IndexTabLocalList] router error: ' + JSON.stringify(err))
            });
          })
        }, (item: VideoItem) => JSON.stringify(item))
      }
      .backgroundColor(Color.White)
      .borderRadius($r('app.float.list_border_radius'))
    }
    .width(HomeConstants.COLUMN_WIDTH)
    .height(CommonConstants.NINETY_PERCENT)
  }
}