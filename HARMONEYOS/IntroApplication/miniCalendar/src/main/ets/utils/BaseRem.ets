import display from '@ohos.display'
import deviceInfo from '@ohos.deviceInfo'

// 设计宽度
const designWidth = 375
const devicePhysics = display.getDefaultDisplaySync().width // 预览器不生效

export const vp2vp = (originSize: number) => {
  // 不是PAD是手机 等比例缩放, 预览器不生效
  // if ( deviceInfo.deviceType !== 'tablet' ) {
  //   // 书写尺寸 = 设备宽度 / 设计稿宽度 * 测量尺寸
  //   return px2vp(devicePhysics) / designWidth * originSize
  // }
  return originSize
}