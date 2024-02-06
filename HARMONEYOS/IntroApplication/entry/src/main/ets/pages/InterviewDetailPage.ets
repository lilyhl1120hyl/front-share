import router from '@ohos.router';
import { Request } from '../utils/Request';
import { questionDetailModel } from '../models/QuestionTypeModel'
import { vp2vp } from '../utils/BaseRem'
import { IvTag } from '../component/IvTag'
import promptAction from '@ohos.promptAction';
import { MoreDialog } from '../component/MoreDialog'

@Entry
@Component
struct InterviewDetailPage {
  @State
  detailData: questionDetailModel = {
    stem: "上海一家科技公司面经记录",
    id: "string",
    content: "⼀⾯线上，⼆⾯线下，公司环境⼀栋写字楼, 环境整体还是比较好的。\n 一面是外包的电话面试, 二面去的甲方公司, 面试我的是两个小姐姐, 一个是公司的后端, 另一个是技术负责人, 包含项目的整体架构都是她在负责。\n初试就是做了个简单的了解, 具体面试题也都可以面试宝典里找到。\n复试分为面试和笔试两部分\n面试部分: \n1.vue2与vue3的区别\n2.vue2的各个生命周期\n3.项目中利用vue做了哪些优化?\n笔试部分:\n1.封装一个树形结构的函数, 用以写树形下拉框\n2.一个数组的相关问题, 主要看对数组新增方法的熟悉程度及使用",
    answer: "一、vue作为一款轻量级框架，门槛低，上手快，简单易学。\n二、vue可以进行组件化开发，数据与结构相分离，使代码量减少，从而提升开发效率，易于理解\n三、vue最突出的优势在于对数据进行双向绑定，使用虚拟DOM\n四、相较于传统页面通过超链接实现页面跳转，vue会使用路由跳转不会刷新页面\n五、vue是单页面应用，页面局部刷新，不用每次跳转都请求数据，加快了访问速度，提升了用户体验",
    difficulty: 0,
    stage: ['Vue', 'React'],
    collectFlag: 0,
    likeFlag: 0,
    likeCount: 0,
    creatorName: "小糯米",
    creatorAvatar: "",
    views: 0,
    createdAt: "刚刚",
    relatedQuestions: [
      {
        id: "1",
        questionNo: "",
        stem: "VUE单页应用首屏加载速度优化方案",
        createdAt: "string"
      },
      {
        id: "2",
        questionNo: "",
        stem: "Vue2和Vue3的区别",
        createdAt: "string"
      }
    ]
  }
  @State
  loading: boolean = false
  answerArr: string[] = []

  @State questionId: string = ''
  moreDialog: CustomDialogController = new CustomDialogController({
    builder: MoreDialog({ activeIndex: $activeIndex }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Top,
    offset: { dx: 80, dy: 100 },
    gridCount: 2,
    customStyle: false
  })

  aboutToDisappear() {
    this.moreDialog = undefined // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }

  aboutToAppear() {

    if (this.detailData.content) {
      this.answerArr = this.detailData.content.split('\n')
    }

    // 路由参数获取
    let id = router.getParams()['id'] || '41117'
    this.questionId = id
    this.getDetail(id)
  }

  getDetail(id) {
    if (this.loading) return
    this.loading = true
    promptAction.showToast({ message: id.toString() })
    Request.get<questionDetailModel>('question/' + id,)
      .then(res => {
        this.detailData = res.data
        this.loading = false
      })
      .catch(() => {
        this.loading = false
      })
  }

  // 点赞 收藏
  questionOpt(flag) {
    if (this.loading) return
    this.loading = true
    const params = {
      id: this.detailData.id,
      type: 0,
      optType: flag === 'collectFlag' ? '2' : '1'
    }
    Request.get('question/opt', params)
      .then(() => {
        promptAction.showToast({ message: '收藏成功' })
        this.loading = false
      })
      .catch(() => {
        this.loading = false
      })
  }

  // 取消点赞 收藏
  questionUnOpt(flag) {
    if (this.loading) return
    this.loading = true
    const params = {
      id: this.detailData.id,
      type: 0,
      optType: flag === 'collectFlag' ? '2' : '1'
    }
    Request.get('question/unOpt', params)
      .then(() => {
        promptAction.showToast({ message: '取消收藏成功' })
        this.loading = false
      })
      .catch(() => {
        this.loading = false
      })
  }

  @Builder
  SplitBuilder() {
    Text('|')
      .width(vp2vp(30))
      .textAlign(TextAlign.Center)
      .fontColor('#C3C3C5')
      .fontSize(vp2vp(12))
  }

  @Builder
  TextBuilder(text: string) {
    Text(text)
      .fontColor('#C3C3C5')
      .fontSize(vp2vp(12))
  }

  build() {
    Column() {
      Navigation() {
        Stack({ alignContent: Alignment.BottomEnd }) {

          Column() {
            Row() {
              Text(this.detailData.stem)
                .fontSize(vp2vp(20))
                .layoutWeight(1)
                .fontColor('#000')
            }

            Row() {
              this.TextBuilder(`${this.detailData.createdAt}`)
              this.SplitBuilder()
              this.TextBuilder(`点赞 ${this.detailData.likeCount}`)
              this.SplitBuilder()
              this.TextBuilder(`浏览 ${this.detailData.views}`)
            }
            .width('100%')
            .margin({ top: vp2vp(5) })

            Row() {
              if(this.detailData.creatorAvatar){
                Image(this.detailData.creatorAvatar)
                  .width(20)
                  .height(20)
              }else{
                Image($r('app.media.icon'))
                  .width(20)
                  .height(20)
              }

              this.TextBuilder(this.detailData.creatorName)
            }
            .width('100%')
            .margin({ top: vp2vp(5) })


            Column() {
              ForEach(this.answerArr, (item) => {
                Text(item).padding({ top: 10 })
              })
            }.alignItems(HorizontalAlign.Start)

            Row(){
              Text('相关题目：')
              Column({space:5}){
                ForEach(this.detailData.relatedQuestions, (item, index)=>{

                  Row(){
                    Image($r('app.media.document'))
                      .width(16)
                      .height(16)
                      .margin({left:6})
                    Text(item.stem)
                      .width(230)
                      .fontColor('#658CF1')
                      .textOverflow({overflow:TextOverflow.Ellipsis})
                      .maxLines(1)
                  }
                  .onClick(()=>{
                    router.pushUrl({
                      url:"pages/InterviewDetailPage",
                      params:{
                        id: item.questionNo
                      }
                    })
                  })
                })
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width("100%")
            .padding(10)
            .margin({top:12})
            .backgroundColor('#F6F7F9')
            .alignItems(VerticalAlign.Top)


          }
          .alignItems(HorizontalAlign.Start)
          .padding(10)


          Row() {
            Stack({ alignContent: Alignment.Center }) {
              Text()
                .width(40)
                .height(40)
                .borderRadius(20)
                .backgroundColor('#ccc')

              Image(this.detailData.likeFlag === 0 ? $r('app.media.like') : $r('app.media.like_able')).width(20)
                .height(20)

            }
            .margin({ right: 20 })
            .onClick(() => {
              this.detailData.likeFlag = this.detailData.likeFlag === 0 ? 1 : 0
              if (this.detailData.likeFlag === 0) {
                this.questionUnOpt('likeFlag')
              } else {
                this.questionOpt('likeFlag')
              }
            })

            Stack({ alignContent: Alignment.Center }) {
              Text()
                .width(40)
                .height(40)
                .borderRadius(20)
                .backgroundColor('#FEC635')

              Image(this.detailData.collectFlag === 0 ? $r('app.media.save') : $r('app.media.save_able')).width(20)
                .height(20)

            }.onClick(() => {
              this.detailData.collectFlag = this.detailData.collectFlag === 0 ? 1 : 0
              if (this.detailData.collectFlag === 0) {
                this.questionUnOpt('collectFlag')
              } else {
                this.questionOpt('collectFlag')
              }
            })

          }
          .width('100%')
          .padding({ right: 20 })
          .margin({ top: 120 })
          .justifyContent(FlexAlign.End)

        }

      }
      .title('面经')
      .titleMode(NavigationTitleMode.Mini)
    }
    .width('100%')
    .height("100%")


  }
}