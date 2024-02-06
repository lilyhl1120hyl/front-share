import { vp2vp } from '../utils/BaseRem';
import router from '@ohos.router';

@CustomDialog
export struct SuccessOrFailDialog {
  type: string = 'success'
  questionId: string = ''
  controller: CustomDialogController

  build() {
    Column() {
      Text('提交反馈')
      .fontSize(20)
      .padding(10)
      .fontColor("#000")

     Row(){
      if(this.type === 'success'){
          Image($r('app.media.fail_group'))
            .width(250)
            .margin({top:40})

        }else{
        Image($r('app.media.success_group'))
          .width(250)
          .margin({top:40})

       }
    }

      if(this.type === 'success'){
        Image($r('app.media.submit_2'))
          .width(150)
          .margin({top:180})
          .onClick(()=>{
            router.pushUrl({
              url: 'pages/QuestionDetailPage',
              params:{
                id: this.questionId
              }
            })
          })

      }else{
        Image($r('app.media.submit_1'))
          .width(150)
          .margin({top:180})
          .onClick(()=>{
            this.controller.close()
          })

      }
      }
    .width('100%')
    .height('60%')
    .backgroundColor('#fff')
    .borderRadius({ topLeft: 20, topRight: 20 })
    .justifyContent(FlexAlign.Start)


    }


}