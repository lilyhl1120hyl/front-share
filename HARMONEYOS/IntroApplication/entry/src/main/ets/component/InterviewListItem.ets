import { QuestionItemModel } from '../models/QuestionTypeModel'
import { Auth } from '../utils/Auth'
import { vp2vp } from '../utils/BaseRem'
import router from '@ohos.router';
import promptAction from '@ohos.promptAction'

@Component
export struct InterviewListItem {
  @ObjectLink
  item: QuestionItemModel

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
    Column({ space: 5 }) {
      Row() {
        if (this.item.creatorAvatar) {
          Image(this.item.creatorAvatar)
            .width(40)
            .height(40)
        } else {
          Image($r('app.media.icon'))
            .width(40)
            .height(40)
        }

        Column() {
          Row() {
            Text('面经')
            this.SplitBuilder()
            Text(this.item.stem)
              .fontSize(vp2vp(15))
              .layoutWeight(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
          }

          Row() {
            Text(this.item.creatorName)
              .fontSize(12)
            this.SplitBuilder()
            Text(this.item.createdAt)
              .fontSize(vp2vp(12))
              .layoutWeight(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
          }
        }
      }
      .width('100%')
      .margin({ top: vp2vp(8) })

      Row() {
        Text(this.item.content)
          .fontSize(vp2vp(14))
          .width(vp2vp(220))
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)

        Image($r('app.media.banner_ai'))
          .width(100)
          .height(60)

        if (this.item.imgUrl) {
          Image(this.item.imgUrl)
            .width(100)
            .height(60)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: vp2vp(8) })

      Row() {
        this.TextBuilder(`点赞 ${this.item.likeCount}`)
        this.SplitBuilder()
        this.TextBuilder(`浏览 ${this.item.views}`)
        this.SplitBuilder()
        if (this.item.readFlag === 1) {
          this.TextBuilder(`已看过`)
        }
      }
      .width('100%')
      .margin({ top: vp2vp(8) })
    }
    .height(vp2vp(160))
    .width('100%')
    .padding({ left: vp2vp(15), right: vp2vp(15) })
    .onClick(() => {
      promptAction.showToast({ message: this.item.id.toString() })
      router.pushUrl({
        url: 'pages/InterviewDetailPage',
        params: { id: this.item.id }
      })
    })
  }
}