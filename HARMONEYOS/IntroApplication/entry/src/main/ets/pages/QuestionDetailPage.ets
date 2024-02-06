import router from '@ohos.router';
import { Request } from '../utils/Request';
import { questionDetailModel } from '../models/QuestionTypeModel'
import { vp2vp } from '../utils/BaseRem'
import { IvTag } from '../component/IvTag'
import promptAction from '@ohos.promptAction';
import { MoreDialog } from '../component/MoreDialog'

@Entry
@Component
struct QuestionDetailPage {
  @State
  detailData: questionDetailModel = {
    stem: "Vue的最大的优势是什么？ ",
    id: "string",
    content: "string",
    answer: "一、vue作为一款轻量级框架，门槛低，上手快，简单易学。\n二、vue可以进行组件化开发，数据与结构相分离，使代码量减少，从而提升开发效率，易于理解\n三、vue最突出的优势在于对数据进行双向绑定，使用虚拟DOM\n四、相较于传统页面通过超链接实现页面跳转，vue会使用路由跳转不会刷新页面\n五、vue是单页面应用，页面局部刷新，不用每次跳转都请求数据，加快了访问速度，提升了用户体验",
    difficulty: 0,
    stage: ['Vue', 'React'],
    collectFlag: 0,
    likeFlag: 0,
    likeCount: 0,
    creatorName: "string",
    creatorAvatar: "string",
    views: 0,
    createdAt: "string",
    relatedQuestions: [
      {
        id: "string",
        questionNo: "string",
        stem: "string",
        createdAt: "string"
      }
    ]
  }
  @State
  loading: boolean = false
  answerArr: string[] = []
  @State
  @Watch('changeHandle')
  activeIndex: number = 999
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

    if (this.detailData.answer) {
      this.answerArr = this.detailData.answer.split('\n')
    }

    // 路由参数获取
    let id = router.getParams()['id'] || '38204'
    this.questionId = id
    this.getDetail(id)
  }

  changeHandle() {

    if (this.activeIndex === 0) {
      this.detailData.collectFlag = 1
      this.questionOpt('collectFlag')
    } else if (this.activeIndex === 1) {
      this.detailData.likeFlag = 1
      this.questionOpt('likeFlag')
    } else if (this.activeIndex === 2) {
      // 反馈
      router.pushUrl({
        url: 'pages/FeedBackPage',
        params: {
          questionId: this.questionId
        }
      })
    } else {
      // 分享
    }
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

  build() {

    Column() {
      Row() {
        Divider().height(20)
          .width(1)
          .backgroundColor('#222')
          .margin({ right: 20 })

        Text(this.detailData.stem)
          .fontSize(vp2vp(20))
          .layoutWeight(1)
          .fontColor('#000')
          .padding({ top: 16, bottom: 16 })
      }

      Row() {
        Row() {
          IvTag({ difficulty: this.detailData.difficulty })

          ForEach(this.detailData.stage, (item) => {
            Text(item)
              .fontColor('#94AFF7')
              .padding({ left: 16 })
          })
        }

        Text('...')
          .fontSize(20)
          .onClick(() => {
            this.moreDialog.open()
          })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 20 })
      .justifyContent(FlexAlign.SpaceBetween)

      Divider().height(10)
        .width('100%')
        .backgroundColor('#eee')

      Column() {
        Text('答案：')
          .fontSize(20)
          .fontColor('#000')
          .padding(10)
        ForEach(this.answerArr, (item) => {
          Text(item).padding(10)
        })
      }


      Row() {
        Image($r('app.media.frame'))
          .width(20)
          .height(20)
          .margin({ left: 20, right: 10 })
        Text('有问题？点我反馈')
          .fontColor('#687FB9')
          .onClick(() => {
            router.pushUrl({ url: 'pages/FeedBackPage',
              params: {
                questionId: this.questionId
              } })
          })
      }

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
      .margin({ top: 20 })
      .justifyContent(FlexAlign.End)

      Row() {
        Image($r('app.media.next_black'))
          .width(80)
        Image($r('app.media.prev_black'))
          .width(80)
      }
      .width('100%')
      .position({ x: 0, y: 730 })
      .padding({ left: 20, right: 20 })
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}