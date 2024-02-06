

import router from '@ohos.router';
import Constants from '../common/constants/CommonConstant';

@Entry
@Component
struct ListPage {
  photoArr: Array<Resource> = (router.getParams() as Record<string, Array<Resource>>)[`${Constants.PARAM_PHOTO_ARR_KEY}`];
  @StorageLink('selectedIndex') selectedIndex: number = 0;

  build() {
    Navigation() {
      Grid() {
        ForEach(this.photoArr, (img: Resource, index?: number) => {
          GridItem() {
            Image(img)
              .height(Constants.FULL_PERCENT)
              .width(Constants.FULL_PERCENT)
              .objectFit(ImageFit.Cover)
              .onClick(() => {
                if (!index) {
                  index = 0;
                }
                this.selectedIndex = index;
                router.pushUrl({
                  url: Constants.URL_DETAIL_LIST_PAGE,
                  params: {
                    photoArr: this.photoArr,
                  }
                });
              })
          }
          .width(Constants.FULL_PERCENT)
          .aspectRatio(1)
        }, (item: Resource) => JSON.stringify(item))
      }
      .columnsTemplate(Constants.GRID_COLUMNS_TEMPLATE)
      .rowsGap(Constants.LIST_ITEM_SPACE)
      .columnsGap(Constants.LIST_ITEM_SPACE)
      .layoutWeight(1)
    }
    .title(Constants.PAGE_TITLE)
    .hideBackButton(false)
    .titleMode(NavigationTitleMode.Mini)
  }
}