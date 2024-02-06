import { BasicDataSource } from '../models/BasicDataSource'
import { QueryQuestionListParams, QuestionItemModel } from '../models/QuestionTypeModel'
import { vp2vp } from '../utils/BaseRem'
import { Request } from '../utils/Request'
import { InterviewListItem } from './InterviewListItem'

// LazyForEach 的数据源
class QuestionListDataSource extends BasicDataSource {

  private questionList: QuestionItemModel[] = []

  public totalCount(): number {
    return this.questionList.length;
  }

  public getData(index: number): QuestionItemModel {
    return this.questionList[index];
  }

  public addData(index: number, data: QuestionItemModel): void {
    this.questionList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: QuestionItemModel): void {
    this.questionList.push(data);
    this.notifyDataAdd(this.questionList.length - 1);
  }
}


@Component
export struct InterviewQuestionList {

  @Prop
  selfIndex: number

  // 更改类型
  @Prop
  @Watch('initQuestionList')
  activeIndex: number

  @State
  questionList: QuestionItemModel[] = []
  @State
  finished: boolean = false
  @State
  loading: boolean = false

  params: QueryQuestionListParams = {
    questionBankType: 9,
    page: 1,
    type: 0,
    // keyword: this.activeIndex === 0 ? '推荐' : '最新'
  }


  questionListDataSource = new QuestionListDataSource()

  aboutToAppear() {
    this.initQuestionList()
  }

  initQuestionList() {
    if (this.activeIndex === this.selfIndex && this.questionListDataSource.totalCount() === 0) {
      this.getQuestionList()
    }
  }

  getQuestionList() {
    if (this.loading || this.finished) return

    this.loading = true
    Request.get<{
      total: number
      pageTotal: number
      rows: QuestionItemModel[]
    }>('question/list', this.params)
      .then(res => {

        res.data.rows.forEach(item => {
          this.questionListDataSource.pushData(item)
        })

        if (this.params.page < res.data.pageTotal) {
          this.params.page++
        } else {
          this.finished = true
        }
        this.loading = false
      })
      .catch(e => {
        this.loading = false
      })
  }

  @Builder
  LoadingBuilder() {
    if (this.finished) {
      Row() {
        Text('没有更多了~')
          .fontColor($r('app.color.gray'))
          .fontSize(vp2vp(14))
      }
      .width('100%')
      .height(vp2vp(50))
      .justifyContent(FlexAlign.Center)
    } else {
      if (this.loading) {
        Row() {
          LoadingProgress()
            .width(vp2vp(24))
            .margin({ right: vp2vp(5) })
          Text('加载中...')
            .fontColor($r('app.color.gray'))
            .fontSize(vp2vp(14))
        }
        .width('100%')
        .height(vp2vp(50))
        .justifyContent(FlexAlign.Center)
      }
    }
  }

  build() {
    List() {
      LazyForEach(this.questionListDataSource, (item: QuestionItemModel) => {
        ListItem() {
          InterviewListItem({ item })

        }
      })
      // 加一个 loading
      ListItem(){
        this.LoadingBuilder()
      }
    }
    .divider({
      strokeWidth: 10,
      color: $r('app.color.gray_bg')
    })
    .height('100%')
    .width('100%')
    .onReachEnd(() => {
      this.getQuestionList()
    })
  }
}