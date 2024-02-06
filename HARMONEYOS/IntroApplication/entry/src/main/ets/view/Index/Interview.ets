
import {IvSearch} from '../../component/IvSearch'
import {vp2vp} from '../../utils/BaseRem'
import {InterviewQuestionList} from '../../component/InterviewQuestionList'
import {IvSkeleton} from '../../component/IvSkeleton'

@Component
export struct Interview {

  @State
  loading: boolean = false

  @State
  changeItem: string[] = ['推荐', '最新']
  @State
  activeIndex: number = 0


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
  TabItemBuilder(q: string, index: number) {
    Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(q)
          .fontSize(vp2vp(15))
          .height(vp2vp(44))
          .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.gray'))
        Text()
          .width(this.activeIndex === index ? vp2vp(20) : 0)
          .height(vp2vp(2))
          .backgroundColor($r('app.color.black'))
          .animation({ duration: this.activeIndex === index ? 300 : 0 })
      }.margin(index === 0 ? { left: vp2vp(15) } : {})

    }
    .padding({ right: vp2vp(15) })

  }


  build() {
    Column(){
      Row(){
        IvSearch({questionBankType:9})
      }.padding(12)
      // 显示隐藏试题列表和试题类型
      if (this.loading) {
        this.SkeletonBuilder()
      } else {
        Row() {
          Stack({ alignContent: Alignment.TopEnd }) {
            Tabs({ index: this.activeIndex }) {
              ForEach(this.changeItem, (item, index: number) => {
                TabContent() {
                   InterviewQuestionList({ selfIndex: index, activeIndex: this.activeIndex})
                }
                .tabBar(this.TabItemBuilder(item, index))
                .height('100%')
              })
            }
            .layoutWeight(1)
            .barMode(BarMode.Scrollable)
            .onChange(index => this.activeIndex = index)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
  }
}