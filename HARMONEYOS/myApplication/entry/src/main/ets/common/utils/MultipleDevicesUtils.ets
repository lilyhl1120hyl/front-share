

import mediaQuery from '@ohos.mediaquery';
import CommonConstants from '../constants/CommonConstant';

class MultipleDevicesUtils {
  private currentDeviceSize: string = '';
  private smListener?: mediaQuery.MediaQueryListener;
  private mdListener?: mediaQuery.MediaQueryListener;
  private lgListener?: mediaQuery.MediaQueryListener;

  private updateCurrentDeviceSize(deviceSize: string): void {
    if (this.currentDeviceSize !== deviceSize) {
      this.currentDeviceSize = deviceSize;
      AppStorage.Set<string>('currentDeviceSize', this.currentDeviceSize);
    }
  }

  private isDeviceSizeSM = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentDeviceSize(CommonConstants.SM);
    }
  }
  private isDeviceSizeMD = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentDeviceSize(CommonConstants.MD);
    }
  }
  private isDeviceSizeLG = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentDeviceSize(CommonConstants.LG);
    }
  }

  public register(): void {
    this.smListener = mediaQuery.matchMediaSync(CommonConstants.WIDTH_CONDITION_SM);
    this.smListener.on('change', this.isDeviceSizeSM);
    this.mdListener = mediaQuery.matchMediaSync(CommonConstants.WIDTH_CONDITION_MD);
    this.mdListener.on('change', this.isDeviceSizeMD);
    this.lgListener = mediaQuery.matchMediaSync(CommonConstants.WIDTH_CONDITION_LG);
    this.lgListener.on('change', this.isDeviceSizeLG);
  }

  public unregister(): void {
    this.smListener?.off('change', this.isDeviceSizeSM);
    this.mdListener?.off('change', this.isDeviceSizeMD);
    this.lgListener?.off('change', this.isDeviceSizeLG);
  }
}

export default new MultipleDevicesUtils();