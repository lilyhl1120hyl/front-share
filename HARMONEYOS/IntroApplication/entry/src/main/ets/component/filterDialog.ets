import { vp2vp } from '../utils/BaseRem'
import { QuestionTypeModel } from '../models/QuestionTypeModel'
import { Request } from '../utils/Request'


@CustomDialog
export struct FilterDialog {

  // 双向绑定的数据
  @Link
  sort: number
  @Link
  activeIndex: number
  controller: CustomDialogController
  @State
  loading: boolean = false
  @State
  questionTypeList: QuestionTypeModel[] = []
  @State
  selfSort: number = 0
  @State
  selfIndex: number = 0

  aboutToAppear() {
    this.getQuestionTypeList()
  }

  async getQuestionTypeList() {
    this.loading = true
    const res = await Request.get<QuestionTypeModel[]>('question/type')
    this.questionTypeList = res.data
    this.loading = false
  }

  build() {
    Column() {

      Row() {

        Text('重置')
          .size({ width: 90, height: 50 })
          .onClick(() => {
            this.selfIndex = 0
            this.selfSort = 0
            this.sort = 0
            this.activeIndex = 0
          })
        Text('筛选题目')
          .size({ width: 120, height: 50 })

        Text('完成')
          .size({ width: 90, height: 50 })
          .fontColor("#628AF2")
          .onClick(() => {
            // 组件内部关闭弹窗
            this.controller.close()
            // 需要更新筛选参数
            this.sort = this.selfSort
            this.activeIndex = this.selfIndex

          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ top: 12, left: 20 })


      Text('题目排序')
        .width('100%')
        .fontSize(20)
        .padding(10)

      Flex({ direction: FlexDirection.Row }) {
        Text('默认')
          .height(40)
          .padding({ left: 10, right: 10 })
          .borderRadius(vp2vp(6))
          .fontColor(this.selfSort == 0 ? '#628AF2' : '#707175')
          .backgroundColor(this.selfSort == 0 ? "#EDF2FF" : '#F6F7F9')
          .margin({ right: 15 })
          .onClick(() => {
            this.selfSort = 0
          })


        Row() {
          Text('难易')
            .fontColor([10, 11].includes(this.selfSort) ? '#628AF2' : '#707175')
            .margin({ right: 10 })
          Image(this.selfSort == 11 ? $r('app.media.top') : $r('app.media.bottom'))
            .width(20)
            .height(20)

        }
        .height(40)
        .padding({ left: 10, right: 10 })
        .borderRadius(vp2vp(6))
        .margin({ right: 15 })
        .backgroundColor([10, 11].includes(this.selfSort) ? "#EDF2FF" : '#F6F7F9')
        .onClick(() => {
          this.selfSort = this.selfSort == 10 ? 11 : 10
        })


        Row() {
          Text('浏览量')
            .fontColor([20, 21].includes(this.selfSort) ? '#628AF2' : '#707175')
            .margin({ right: 10 })
          Image(this.selfSort == 21 ? $r('app.media.top') : $r('app.media.bottom'))
            .width(20)
            .height(20)

        }
        .height(40)
        .padding({ left: 10, right: 10 })
        .borderRadius(vp2vp(6))
        .backgroundColor([20, 21].includes(this.selfSort) ? "#EDF2FF" : '#F6F7F9')
        .onClick(() => {
          this.selfSort = this.selfSort == 20 ? 21 : 20
        })

      }.padding({ left: 10 })

      Text('选择阶段').width('100%')
        .fontSize(20)
        .padding(10)

      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        ForEach(this.questionTypeList, (item, index) => {
          Stack() {
            Text(item.name)
              .fontSize(vp2vp(16))
              .padding({  left: vp2vp(20), right: vp2vp(20) })
              .height(vp2vp(40))
              .fontColor(this.selfIndex == index ? '#628AF2' : '#707175')
              .backgroundColor(this.selfIndex == index ? "#EDF2FF" : '#F6F7F9')
              .borderRadius(vp2vp(20))

            if (item.displayNewestFlag === 1) {
              Image($r('app.media.new'))
                .width(vp2vp(38))
                .height(vp2vp(16))
                .margin({ left: vp2vp(70), top: vp2vp(-28) })
            }

          }
          .margin({ right: vp2vp(20), bottom: vp2vp(10) })
          .onClick(() => {
            this.selfIndex = index
          })

        })
      }
      .width('100%')
      .padding({ left: 10 })

    }
    .width('100%')
    .height('80%')
    .backgroundColor('#fff')
    .borderRadius({ topLeft: 20, topRight: 20 })
    .justifyContent(FlexAlign.Start)
  }
}