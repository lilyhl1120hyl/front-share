import { vp2vp } from '../utils/BaseRem'
import {ClockModel} from '../models/ClockModel'
import {Request} from '../utils/Request'
import dayjs from 'dayjs'
import { MiniCalendar } from '@ohos/miniCalendar'

@Entry
@Component
struct ClockPage {

  @State
  clockData: ClockModel = {
    totalClockinNumber: 0,
    clockinNumbers: 0
  }

  @State
  selectedDays: string[] = []


  aboutToAppear() {
    this.getData()
  }

  async getData(date?: {
    year: string,
    month: string
  }) {
    const res = await Request.get<ClockModel>('clockinInfo', date || {})
    this.clockData = res.data
    this.selectedDays = res.data.clockins.map(item => item.createdAt)
  }


  @Builder
  dayBuilder(params: {
    day: number,
    text: string
  }) {
    Column() {
      Row() {
        Text(params.day.toString())
          .fontSize(vp2vp(40))
          .fontWeight(FontWeight.Bold)
        Text('天')
          .fontSize(vp2vp(10))
          .fontColor($r('app.color.gray'))
          .margin({ bottom: vp2vp(8), left: vp2vp(10) })
      }
      .alignItems(VerticalAlign.Bottom)

      Text(params.text)
        .fontSize(vp2vp(10))
        .fontColor($r('app.color.gray'))
    }.margin({ right: vp2vp(36) })
  }

  build() {
    Column() {
      Navigation() {
        Column() {
          Row() {
            Text('今日已打卡')
              .fontSize(vp2vp(20))
              .margin({ right: vp2vp(5) })
            Image($r('app.media.icon_clock_card'))
              .width(vp2vp(20))
              .aspectRatio(1)
              .objectFit(ImageFit.Fill)
          }
          .width('100%')

          Row() {
            this.dayBuilder({ day: this.clockData.totalClockinNumber, text: '累计打卡' })
            this.dayBuilder({ day: this.clockData.clockinNumbers, text: '连续打卡' })
          }
          .padding({ top: vp2vp(10), bottom: vp2vp(25) })
          .width('100%')
          .justifyContent(FlexAlign.Start)

          Row() {
            // currentDate 当前时间
            // selectedDays 哪些日期需要选中 ['2023-12-09','2023-12-03']
            MiniCalendar({
              currentDate: dayjs().format('YYYY-MM-DD'),
              selectedDays: $selectedDays,
              onChangeMonth: (date: string) => {
                const [ year, month ] = date.split('-')
                this.getData({ year, month })
              },
              selectedText: '已签到'
            })
          }
          .height(300)
          .margin({ bottom: vp2vp(50) })

          Image($r('app.media.clock_btn'))
            .width(vp2vp(145))
            .height(vp2vp(38))
            .objectFit(ImageFit.Fill)

        }
        .padding(vp2vp(15))
        .layoutWeight(1)
      }
      .title('每日打卡')
      .titleMode(NavigationTitleMode.Mini)
      .mode(NavigationMode.Stack)
      .backgroundImage($r('app.media.clock_bg'))
      .backgroundImageSize(ImageSize.Contain)
      .backgroundImagePosition(Alignment.Top)
    }.backgroundColor($r('app.color.gray_bg'))
  }
}