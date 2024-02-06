import { IvClock } from '../../component/IvClock'
import { IvSearch } from '../../component/IvSearch'
import { IvSkeleton } from '../../component/IvSkeleton'
import {vp2vp} from "../../utils/BaseRem"
import {Request} from '../../utils/Request'
import {QuestionTypeModel} from '../../models/QuestionTypeModel'
import {IvQuestionList} from '../../component/IvQuestionList'
import emitter from '@ohos.events.emitter';
import {LOGIN_EVENT} from '../../common/constants'
import {UserModel} from '../../models/UserModel'
import { USER_KEY} from '../../utils/Auth'
import {FilterDialog} from '../../component/filterDialog'
import promptAction from '@ohos.promptAction'

@Component
export struct Home {

  @State
  loading: boolean = false
  @State
  questionTypeList: QuestionTypeModel[] = []
  @State
  activeIndex: number = 0
  @State
  sort: number = 0

  @StorageProp(USER_KEY)
  @Watch('updateUser')
  userJson: string = '{}'
  @State
  user: UserModel = JSON.parse(this.userJson)

  updateUser() {
    this.user = JSON.parse(this.userJson)
  }


  filterDialog: CustomDialogController = new CustomDialogController({
    builder: FilterDialog({ sort: $sort , activeIndex: $activeIndex }),
    customStyle: true,
    alignment: DialogAlignment.Bottom,
  })

  aboutToAppear() {
    this.getQuestionTypeList()

    emitter.on(LOGIN_EVENT, () => this.getQuestionTypeList())
  }

  async getQuestionTypeList() {
    this.loading = true
    const res = await Request.get<QuestionTypeModel[]>('question/type')
    this.questionTypeList = res.data
    this.loading = false
  }


  // 骨架屏
  @Builder
  SkeletonBuilder() {
    Column() {
      Row({ space: vp2vp(15) }) {
        IvSkeleton()
        IvSkeleton({ widthValue: vp2vp(60) })
        IvSkeleton({ widthValue: vp2vp(80) })
      }
      .width('100%')
      .margin({ bottom: vp2vp(15) })

      List({ space: vp2vp(15) }){
        ForEach([1, 2, 3, 4, 5, 6, 7], () => {
          ListItem(){
            Column({ space: vp2vp(15) }){
              Row({ space: vp2vp(15) }){
                IvSkeleton({ widthValue: vp2vp(30) })
                IvSkeleton({ widthValue: '100%' }).layoutWeight(1)
              }
              Row({ space: vp2vp(15) }){
                IvSkeleton({ widthValue: vp2vp(50) })
                IvSkeleton({ widthValue: vp2vp(50) })
                IvSkeleton({ widthValue: vp2vp(50) })
              }
              .width('100%')
            }
            .padding({ top: vp2vp(10), bottom: vp2vp(10) })
          }
        })
      }
      .divider({ strokeWidth: 0.5, color: $r('app.color.gray_bg') })
    }
    .width('100%')
    .padding(vp2vp(15))
    .layoutWeight(1)
  }

  @Builder
  TabItemBuilder(q: QuestionTypeModel, index: number) {
      Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(q.name)
          .fontSize(vp2vp(15))
          .height(vp2vp(44))
          .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.gray'))
        Text()
          .width(this.activeIndex === index ? vp2vp(20) : 0)
          .height(vp2vp(2))
          .backgroundColor($r('app.color.black'))
          .animation({ duration: this.activeIndex === index ? 300 : 0 })
      }.margin(index === 0 ? { left: vp2vp(15) } : {})

      if (q.displayNewestFlag === 1) {
        Image($r('app.media.new'))
          .width(vp2vp(34))
          .height(vp2vp(14))
          .padding({ left: vp2vp(5) })
      }
    }
    .padding({ right: vp2vp(15) })

  }

  build() {
    Column() {
      Row({ space: 15 }) {

        IvSearch({questionBankType:10})
        IvClock({ clockCount: this.user.clockinNumbers || 0 })
      }
      .padding(15)

      Row() {
        Swiper() {
          Flex() {
            Image($r('app.media.banner_ai'))
              .objectFit(ImageFit.Fill)
          }
          .padding({ left: vp2vp(15), right: vp2vp(15) })

          Flex() {
            Image($r('app.media.banner_pj'))
              .objectFit(ImageFit.Fill)
          }
          .padding({ left: vp2vp(15), right: vp2vp(15) })

          Flex() {
            Image($r('app.media.banner_qa'))
              .objectFit(ImageFit.Fill)
          }
          .padding({ left: vp2vp(15), right: vp2vp(15) })
        }
        .autoPlay(true)
        .indicator(false)
      }
      .aspectRatio(2.8)

      // 显示隐藏试题列表和试题类型
      if (this.loading) {
        this.SkeletonBuilder()
      } else {
        Row() {
          Stack({ alignContent: Alignment.TopEnd }) {

          Tabs({ index: this.activeIndex }) {
            ForEach(this.questionTypeList, (item, index: number) => {
              TabContent() {
                IvQuestionList({ type: item.id, selfIndex: index, activeIndex: this.activeIndex, sort: this.sort })
              }
              .tabBar(this.TabItemBuilder(item, index))
              .height('100%')
            })
          }
          .layoutWeight(1)
          .barMode(BarMode.Scrollable)
          .onChange(index => this.activeIndex = index)

          Image($r('app.media.saixuan'))
            .width('24')
            .height('24')
            .margin({top:18})
            .onClick(()=>{
              // promptAction.showToast({ message: '点击了' })
               this.filterDialog.open()
            })
        }
        }
        .justifyContent(FlexAlign.Start)

      }
    }
    .width('100%')
    .height('100%')
  }
}