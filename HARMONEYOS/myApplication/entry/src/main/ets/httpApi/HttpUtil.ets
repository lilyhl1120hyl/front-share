
// 简易http请求

import http from '@ohos.net.http';
import HttpConfig from './httpConfig';
import Logger from '../common/utils/Logger';

export default async function httpGet(url: string) {
  if (!url) {
    return undefined;
  }
  Logger.info('url = ', url)
  let request = http.createHttp();
  let options = {
    method: http.RequestMethod.GET,
    header: { 'Content-Type': 'application/json' },
    readTimeout: HttpConfig.READ_TIMEOUT,
    connectTimeout: HttpConfig.CONNECT_TIMEOUT
  } as http.HttpRequestOptions;
  let result = await request.request(url, options);
  return result;
}