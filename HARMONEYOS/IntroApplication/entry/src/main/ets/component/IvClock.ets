import { vp2vp } from '../utils/BaseRem'
import router from '@ohos.router';
import {Auth} from '../utils/Auth'
import promptAction from '@ohos.promptAction';
import {Request} from '../utils/Request'


@Component
export struct IvClock {

  @Prop
  clockCount: number

  build() {
    Stack({ alignContent: Alignment.End }) {
      Image(this.clockCount > 0 ? $r('app.media.clocked') : $r('app.media.unclock'))
        .objectFit(ImageFit.Fill)
      if (this.clockCount > 0) {
        Column() {
          Text('已连续打卡')
            .fontSize(8)
          Text() {
            Span(this.clockCount.toString())
              .fontWeight(600)
              .fontSize(12)
            Span(' 天')
              .fontSize(10)
          }
        }
        .width('50')
      } else {
        Text('打卡')
          .width('50')
          .textAlign(TextAlign.Center)
          .fontSize(vp2vp(18))
          .fontWeight(500)
          .fontColor('#333C4F')
          .margin({ bottom: vp2vp(4) })

      }
    }
    .width(vp2vp(74))
    .height(vp2vp(28))
    .onClick(()=>{
      const user = Auth.getUser()
      if (user.token) {
        if (user.clockinNumbers > 0) {
          // 跳转打卡日历页面
          return router.pushUrl({ url: 'pages/ClockPage' })
        } else {
          // 进行打卡
          Request.post<{ clockinNumbers: number }>('clockin').then(res => {
            Auth.setUser({ ...user, clockinNumbers: res.data.clockinNumbers })
            promptAction.showToast({ message: '打卡成功' })
          })
        }
      } else {
        router.pushUrl({ url: 'pages/LoginPage' })
      }
    })
  }
}