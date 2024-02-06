

import { VideoItem } from '../../viewmodel/VideoItem';
import { HomeTabContentList } from './HomeTabContentList';
import { HomeTabContentButton } from './HomeTabContentButton';
import CommonConstants  from '../../common/constants/CommonConstant';

@Component
export struct HomeTabContent {
  private currIndex: number = 0;
  @Provide videoList: Array<VideoItem> = [];

  build() {
    Column() {
      HomeTabContentList({ currIndex: this.currIndex });
      HomeTabContentButton({ currIndex: this.currIndex });
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
  }
}