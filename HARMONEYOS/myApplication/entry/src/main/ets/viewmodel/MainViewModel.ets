

import ItemData from './ItemData';

import {
  SWIPER_IMAGES,
  CENTER_GRID_DATA,
  LIST_IMAGE_DATA,
  MINE_LIST_DATA
} from '../common/data/SourceData';

/**
 * Binds data to components and provides interfaces.
 */
export class MainViewModel {

  /**
   * Get swiper image data.
   *
   * @return {Array<Resource>} swiperImages.
   */
  public getSwiperImages(): Array<Resource> {
    let swiperImages: Array<Resource> = [];
    SWIPER_IMAGES.forEach((swiperImage: Resource) => {
      swiperImages.push(swiperImage);
    });
    return swiperImages;
  }

  /**
   * Get data of the Center grid.
   *
   * @return {Array<PageResource>} firstGridData.
   */
  public getCenterGridData(): Array<ItemData> {
    let firstGridData: Array<ItemData> = [];
    CENTER_GRID_DATA.forEach((itemData: ItemData) => {
      let data: ItemData = {
        title: itemData.title,
        img: itemData.img,
        clickPrompt: itemData.clickPrompt
      };
      firstGridData.push(data);
    });
    return firstGridData;
  }


  /**
   * Get data of the list.
   *
   * @return {Array<PageResource>} secondGridData.
   */
  public getListImageData(): Array<ItemData> {
    let secondGridData: Array<ItemData> = [];
    LIST_IMAGE_DATA.forEach((itemData: ItemData, index: number) => {
      let data: ItemData = {
        id: index,
        title: itemData.title,
        img: itemData.img,
        others: itemData.others,
        clickPrompt: itemData.clickPrompt
      };
      secondGridData.push(data);
    });
    return secondGridData;
  }


  /**
   * Get data of the mine page list.
   *
   * @return {Array<PageResource>} settingListData.
   */
  public getMineListData(): Array<ItemData> {
    let settingListData: Array<ItemData> = [];
    MINE_LIST_DATA.forEach((itemData: ItemData) => {
      let data: ItemData = {
        title: itemData.title,
        img: itemData.img,
        others: itemData.others,
        clickPrompt: itemData.clickPrompt
      };
      settingListData.push(data);
    });
    return settingListData;
  }
}

export default new MainViewModel();