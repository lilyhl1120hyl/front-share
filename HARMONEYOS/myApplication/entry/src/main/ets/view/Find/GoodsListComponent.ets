

import CommonConstants from '../../common/constants/CommonConstant';
import { GoodsListItemType } from '../../viewmodel/InitialData';
import { ListDataSource } from '../../viewmodel/ListDataSource';

@Component
export default struct GoodsList {
  @Provide goodsListData: ListDataSource = new ListDataSource();
  private startTouchOffsetY: number = 0;
  private endTouchOffsetY: number = 0;

  build() {
    Row() {
      List({ space: CommonConstants.LIST_ITEM_SPACE }) {
        LazyForEach(this.goodsListData, (item: GoodsListItemType) => {
          ListItem() {
            Row() {
              Column() {
                Image(item?.goodsImg)
                  .width(CommonConstants.LAYOUT_WIDTH_OR_HEIGHT)
                  .height(CommonConstants.LAYOUT_WIDTH_OR_HEIGHT)
              }
              .width(CommonConstants.GOODS_IMAGE_WIDTH)
              .height(CommonConstants.LAYOUT_WIDTH_OR_HEIGHT)

              Column() {
                Text(item?.goodsName)
                  .fontSize(CommonConstants.NORMAL_FONT_SIZE)
                  .margin({ bottom: CommonConstants.BIGGER_FONT_SIZE })

                Text(item?.advertisingLanguage)
                  .fontColor($r('app.color.gray'))
                  .fontSize(CommonConstants.GOODS_EVALUATE_FONT_SIZE)
                  .margin({ right: CommonConstants.MARGIN_RIGHT, bottom: CommonConstants.BIGGER_FONT_SIZE })

                Row() {
                  Text(item?.evaluate)
                    .fontSize(CommonConstants.GOODS_EVALUATE_FONT_SIZE)
                    .fontColor($r('app.color.deepGray'))
                  Text(item?.price).fontSize(CommonConstants.NORMAL_FONT_SIZE).fontColor($r('app.color.freshRed'))
                }
                .justifyContent(FlexAlign.SpaceAround)
                .width(CommonConstants.GOODS_LIST_WIDTH)
              }
              .padding(CommonConstants.GOODS_LIST_PADDING)
              .width(CommonConstants.GOODS_FONT_WIDTH)
              .height(CommonConstants.LAYOUT_WIDTH_OR_HEIGHT)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .height(CommonConstants.GOODS_LIST_HEIGHT)
            .width(CommonConstants.LAYOUT_WIDTH_OR_HEIGHT)
          }
          .onTouch((event?: TouchEvent) => {
            if (event === undefined) {
              return;
            }
            switch (event.type) {
              case TouchType.Down:
                this.startTouchOffsetY = event.touches[0].y;
                break;
              case TouchType.Up:
                this.startTouchOffsetY = event.touches[0].y;
                break;
              case TouchType.Move:
                if (this.startTouchOffsetY - this.endTouchOffsetY > 0) {
                  this.goodsListData.pushData();
                }
                break;
            }
          })
        })
      }
      .width(CommonConstants.GOODS_LIST_WIDTH)
    }
    .justifyContent(FlexAlign.Center)
    .width(CommonConstants.LAYOUT_WIDTH_OR_HEIGHT)
  }
}