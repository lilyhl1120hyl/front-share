

import { VideoModule } from '../Media/IndexModule';
import { SwiperVideo } from '../Media/IndexSwiper';
import { LIST, MARGIN_FONT_SIZE, ALL_PERCENT, DEFAULT_180 } from '../../common/constants/Constants';
import ScreenUtil from '../../common/utils/ScreenUtil';
import { HomeConstants } from '../../common/constants/HomeConstants';
import CommonConstants from '../../common/constants/CommonConstant';
import { HomeTabContent } from '../Play/HomeTabContent';


@Component
export default struct MediaPage {
  @State currentIndex: number = HomeConstants.CURRENT_INDEX;
  private controller: TabsController = new TabsController();

  aboutToAppear() {
    ScreenUtil.setScreenSize();
  }

  @Builder
  TabBuilder(index: number, name: Resource) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ?
        $r('app.color.index_tab_selected_font_color') : $r('app.color.index_tab_font_color'))
        .fontSize($r('app.float.home_page_font_size'))
        .fontWeight(this.currentIndex === index ?
        HomeConstants.FONT_WEIGHT_SELECT : HomeConstants.FONT_WEIGHT_UNSELECT)
        .lineHeight(HomeConstants.LINE_HEIGHT)
        .margin({
          top: HomeConstants.MARGIN_TOP_TWO,
          bottom: HomeConstants.MARGIN_BOTTOM
        })
      Divider()
        .strokeWidth(HomeConstants.STROKE_WIDTH)
        .color($r('app.color.index_tab_selected_font_color'))
        .opacity(this.currentIndex === index ?
        HomeConstants.TAB_BAR_SECOND : HomeConstants.TAB_BAR_FIRST)
    }
    .width(CommonConstants.FULL_PERCENT)
  }


  build() {
    Column({ space: MARGIN_FONT_SIZE.FOURTH_MARGIN }) {
      SwiperVideo()
      List() {
        ForEach(LIST, (item: string) => {
          ListItem() {
            VideoModule({ moduleName: item })
              .margin({ top: MARGIN_FONT_SIZE.FIRST_MARGIN })
          }
        }, (item: string) => JSON.stringify(item))
      }
      .listDirection(Axis.Vertical)
      .margin({ top: MARGIN_FONT_SIZE.THIRD_MARGIN })

      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        TabContent() {
          HomeTabContent({ currIndex: HomeConstants.TAB_BAR_FIRST });
        }.tabBar(this.TabBuilder(HomeConstants.TAB_BAR_FIRST, $r('app.string.index_tab_local_video')))

        TabContent() {
          HomeTabContent({ currIndex: HomeConstants.TAB_BAR_SECOND });
        }.tabBar(this.TabBuilder(HomeConstants.TAB_BAR_SECOND, $r('app.string.index_tab_internet_video')))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth(HomeConstants.BAR_WIDTH)
      .barHeight(HomeConstants.BAR_HEIGHT)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .width(CommonConstants.FULL_PERCENT)
      .height(DEFAULT_180)
      .margin({ top: $r('app.float.home_tab_margin_top') })
    }
    .width(ALL_PERCENT)
    .height(ALL_PERCENT)
    .backgroundColor($r("app.color.index_backgroundColor"))
  }
}

