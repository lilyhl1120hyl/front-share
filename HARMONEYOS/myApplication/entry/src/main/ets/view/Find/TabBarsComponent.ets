

import { initTabBarData } from '../../viewmodel/InitialData';
import CommonConstants from '../../common/constants/CommonConstant';
import GoodsList from './GoodsListComponent';
import PutDownRefresh from './PutDownRefreshLayout';

const { LAYOUT_WIDTH_OR_HEIGHT,
  NORMAL_FONT_SIZE,
  BIGGER_FONT_SIZE,
  MAX_FONT_SIZE,
  MAX_OFFSET_Y,
  REFRESH_TIME} = CommonConstants;



@Component
export default struct TabBar {
  private currentOffsetY: number = 0;
  private timer: number = 0;
  @State tabsIndex: number = 0;
  @State refreshStatus: boolean = false;
  @State refreshText: Resource = $r('app.string.refresh_text');

  @Builder
  firstTabBar() {
    Column() {
      Text($r('app.string.selected'))
        .fontSize(this.tabsIndex === 0 ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE)
        .fontColor(this.tabsIndex === 0 ? Color.Black : $r('app.color.gray'))
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  otherTabBar(content: Resource, index: number) {
    Column() {
      Text(content)
        .fontSize(this.tabsIndex === index + 1 ? BIGGER_FONT_SIZE : NORMAL_FONT_SIZE)
        .fontColor(this.tabsIndex === index + 1 ? Color.Black : $r('app.color.gray'))
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .justifyContent(FlexAlign.Center)
  }

  putDownRefresh(event?: TouchEvent): void {
    if (event === undefined) {
      return;
    }
    switch (event.type) {
      case TouchType.Down:
        this.currentOffsetY = event.touches[0].y;
        break;
      case TouchType.Move:
        this.refreshStatus = event.touches[0].y - this.currentOffsetY > MAX_OFFSET_Y;
        break;
      case TouchType.Cancel:
        break;
      case TouchType.Up:

      // Only simulation effect, no data request
        this.timer = setTimeout(() => {
          this.refreshStatus = false;
        }, REFRESH_TIME);
        break;
    }
  }

  aboutToDisappear() {
    clearTimeout(this.timer);
  }

  build() {
    Tabs() {
      TabContent() {
        Scroll() {
          Column() {
            if (this.refreshStatus) {
              PutDownRefresh({ refreshText: $refreshText })
            }
            GoodsList()
            Text($r('app.string.to_bottom')).fontSize(NORMAL_FONT_SIZE).fontColor($r('app.color.gray'))
          }
          .width(LAYOUT_WIDTH_OR_HEIGHT)
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .width(LAYOUT_WIDTH_OR_HEIGHT)
        .height(LAYOUT_WIDTH_OR_HEIGHT)
        .onTouch((event?: TouchEvent) => {
          this.putDownRefresh(event);
        })
      }
      .tabBar(this.firstTabBar)

      ForEach(initTabBarData, (item: Resource, index?: number) => {
        TabContent() {
          Column() {
            Text(item).fontSize(MAX_FONT_SIZE)
          }
          .justifyContent(FlexAlign.Center)
          .width(LAYOUT_WIDTH_OR_HEIGHT)
          .height(LAYOUT_WIDTH_OR_HEIGHT)
        }
        .tabBar(this.otherTabBar(item, index !== undefined ? index : 0))
      })
    }
    .onChange((index: number) => {
      this.tabsIndex = index;
    })
    .vertical(false)
  }
}