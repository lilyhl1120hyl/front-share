import promptAction from '@ohos.promptAction';
import { FeedBackModel } from '../models/FeedBackModel';
import { Request } from "../utils/Request";
import router from '@ohos.router';
import {SuccessOrFailDialog} from '../component/SuccessOrFailDialog'

@Entry
@Component
struct FeedBackPage {

  // 1内容不准确2、知识点不准确3题目重复4其他
  @State
  total_Tasks: Array<string> = [
    '知识点不准确',
    '内容不准或错误',
    '题目重复',
    '其他',
  ]
  @State
  selectedIndex: Array<number> = []
  loading: boolean = false
  feedBackList: FeedBackModel[] = []
  @State
  value: string = ""
  questionId: string=""
  showType: string=""


  SuccessOrFailDialog: CustomDialogController = new CustomDialogController({
  builder: SuccessOrFailDialog({ type: this.showType , questionId:this.questionId }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    customStyle: true
})

  aboutToAppear() {
    // this.getFeedBackList()
    this.questionId = router.getParams()['questionId']

  }

  getFeedBackList() {
    if (this.loading) return
    this.loading = true
    Request.get<FeedBackModel[]>('feedback/type')
      .then(res => {
        this.feedBackList = res.data
        this.loading = false
      })
      .catch(() => {
        this.loading = false
      })
  }

  submitTask() {
    if (this.selectedIndex.length === 0) {
      promptAction.showToast({ message: "请选择问题反馈" })
      return
    }

    this.showType = 'success'
    this.SuccessOrFailDialog.open()

    return;

    const params = {
      questionId: this.questionId,
      type: this.selectedIndex.map(item=> { return (item +1)}),
      feedbackInfo: this.value
    }
    this.loading = true
    Request.post<FeedBackModel[]>('question/feedback', params)
      .then(() => {
        promptAction.showToast({ message: '提交反馈成功' })
        this.loading = false
        this.showType = 'success'
        this.SuccessOrFailDialog.open()
      })
      .catch(() => {
        this.loading = false
        this.showType = 'fail'
        this.SuccessOrFailDialog.open()
      })

  }

  build() {
    Column() {
      Navigation() {
       Column() {
         Row() {
           Text() {
             Span("*").fontColor(Color.Red)
             Span("错误类型（可多选）")
           }.padding({ left: 10, top: 20, bottom: 10 })
         }

         Column({ space: 25 }) {
           ForEach(this.total_Tasks, (item, index) => {
             Row() {
               if (this.selectedIndex.includes(index)) {
                 Image($r('app.media.select_icon'))
                   .width(20)
                   .height(20)
                   .onClick(() => {
                     this.selectedIndex = this.selectedIndex.filter((item) => {
                       return item !== index
                     })
                   })
               } else {
                 Image($r('app.media.unSelect_icon'))
                   .width(20)
                   .height(20)
                   .onClick(() => {
                     this.selectedIndex.push(index)
                   })
               }
               Text(item)
                 .padding({ left: 10 })


             }

           })
         }
         .alignItems(HorizontalAlign.Start)
         .padding(10)

         Text()
           .height(15)
           .width('100%')
           .backgroundColor("#eee")

         Row() {
           Text('问题描述（可选填）')
             .padding({ left: 10, top: 20, bottom: 10 })

         }

         Row() {
           Stack({ alignContent: Alignment.BottomEnd }) {
             TextArea({ placeholder: "请输入反馈内容：" })
               .width("100%")
               .height(200)
               .fontColor('#000')
               .fontStyle(FontStyle.Italic)
               .placeholderColor('#ccc')
               .placeholderFont({
                 size: 16,
                 style: FontStyle.Italic,
                 weight: FontWeight.Bold
               })
               .onChange((value) => {
                 this.value = value;
               })

             Text(this.value.length + "/200")
               .fontSize(14)
               .margin(10)
           }
           .layoutWeight(1)
           .width('100%')
           .padding({ left: 10, right: 10 })
           .height(200)
         }
         .alignItems(VerticalAlign.Top)
         .width('100%')
         .height(200)
         .margin({ top: 10 })

         Image($r('app.media.button_icon'))
           .width("90%")
           .position({ x: 20, y: 650 })
           .onClick(() => {
             // 提交
             this.submitTask()
           })
       }.alignItems(HorizontalAlign.Start)
      }
    .title('问题反馈')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Auto)

    }


  }
}