

import image from '@ohos.multimedia.image';
import { VideoItem } from './VideoItem';
import { VIDEO_DATA } from '../common/constants/Constants';
import { GlobalContext } from '../common/utils/GlobalContext';
import resourceManager from '@ohos.resourceManager';
import Logger from '../common/utils/Logger';

export class HomeVideoListModel {
  private videoLocalList: Array<VideoItem> = [];
  private videoInternetList: Array<VideoItem> = [];

  /**
   * Scan the local video.
   *
   * @return Local video list data
   */
  async getLocalVideo() {
    this.videoLocalList = [];
    await this.assemblingVideoBean();
    Logger.info(`videoLocalList====,  ${JSON.stringify(this.videoLocalList)}`);
    GlobalContext.getContext().setObject('videoLocalList', this.videoLocalList);
    return this.videoLocalList;
  }

  /**
   * Assembling the video object
   */
  async assemblingVideoBean() {
    Logger.info(`VIDEO_DATA====,  ${JSON.stringify(VIDEO_DATA)}`);
    VIDEO_DATA.forEach(async (item: VideoItem) => {
      let videoBean = await getContext().resourceManager.getRawFd(item.iSrc);
      let uri = videoBean;
      Logger.info(`uri====,  ${JSON.stringify(uri)}`);
      this.videoLocalList.push(new VideoItem(item.name, uri, ''));
    });
  }

  /**
   * Scan the internet video.
   *
   * @param name Video Name.
   * @param pixelMap pixelMap object.
   * @param src Playback Path.
   * @param duration Video duration.
   * @return Network video list data.
   */
  async setInternetVideo(name: string, src: string, pixelMap?: image.PixelMap) {
    this.videoInternetList.push(new VideoItem(name, {} as resourceManager.RawFileDescriptor, src, pixelMap));
    let videoInternetList = this.videoInternetList;
    GlobalContext.getContext().setObject('videoInternetList', videoInternetList);
    return videoInternetList;
  }
}

let homeVideoListModel = new HomeVideoListModel();

export default homeVideoListModel as HomeVideoListModel;