import { QueryQuestionListParams, QuestionItemModel, HotQuestionModel } from '../models/QuestionTypeModel'
import { vp2vp } from '../utils/BaseRem'
import { Request } from '../utils/Request'
import { BasicDataSource } from '../models/BasicDataSource'
import router from '@ohos.router';
import {IvQuestionItem} from '../component/IvQuestionItem'
import {InterviewListItem} from '../component/InterviewListItem'


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


@Entry
@Component
struct SearchPage {
  @State isClick: boolean = false
  @State searchData: string = ''
  @State isClean: boolean = false
  @State searchList: string[] = ['java', 'hdkhk']


  // 入参对象
  params: QueryQuestionListParams = {
    questionBankType: 10,
    page: 1,
    type: 0,
    keyword: this.searchData
  }
  @State
  questionList: QuestionItemModel[] = []
  @State
  finished: boolean = false
  @State
  loading: boolean = false
  questionListDataSource = new QuestionListDataSource()

  // 热门推荐
  @State
  hotQuestionList: HotQuestionModel[] = [{ id: 1, subjectName: '测试收到货阿是大手大脚阿是实打实大卡司' }]

  aboutToAppear() {
    const questionBankType = router.getParams()['questionBankType']
    questionBankType && (this.params.questionBankType = questionBankType)
    this.getRecommends()
  }

  onChangeFunc(val) {
    this.searchData = val
    this.isClick = val.length > 0 ? true : false
  }

  cancelSearch() {
    this.searchData = ''
  }

  // 点击search按钮进行搜索
  onSubmitFunc() {
    this.searchList.push(this.searchData)
    this.getQuestionList()
  }

  // 热榜
  getRecommends() {
    if (this.loading || this.finished) return
    this.loading = true
    Request.get<{
      total: number
      pageTotal: number
      rows: HotQuestionModel[]
    }>('question/recommends', this.params)
      .then(res => {
        res.data.rows.forEach(item => {
          this.hotQuestionList.push(item)
        })
        this.loading = false
      })
      .catch(() => {
        this.loading = false
      })
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
      .catch(() => {
        this.loading = false
      })
  }


  // 搜索词条面板
  @Builder
  SearchItemPage() {
    Column() {
      Row() {
        Text('搜素记录')
        Row() {

          if (!this.isClean) {
            Image($r('app.media.clean_up'))
              .width(20)
              .height(20)
              .onClick(() => {
                this.isClean = true
              })
          } else {
            Row() {
              Text('全部删除')
                .onClick(() => {
                  this.searchList = []
                })
              Divider()
                .height(20)
                .color('#707070')
                .padding({ left: 10, right: 10 })
                .strokeWidth(vp2vp(1))
                .vertical(true)
              Text('完成')
                .onClick(() => {
                  this.isClean = false
                })
            }
          }
        }
      }
      .width('100%')
      .padding(15)
      .justifyContent(FlexAlign.SpaceBetween)


      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        ForEach(this.searchList, (item) => {
          Row() {
            Text(item)
              .fontSize(vp2vp(16))
              .padding({ left: vp2vp(20), right: vp2vp(15) })
              .onClick(()=>{
                this.searchData = item
                this.onSubmitFunc()
              })

            if (this.isClean) {
              Image($r('app.media.close'))
                .width(vp2vp(16))
                .height(vp2vp(16))
                .margin({ right: 10 })
                .onClick(() => {
                  // promptAction.showToast({message: item.toString()})
                  this.searchList = this.searchList.filter((val) => {
                    return val !== item
                  })
                })
            }

          }
          .height(vp2vp(40))
          .backgroundColor("#EDF2FF")
          .borderRadius(vp2vp(20))
          .margin({ right: vp2vp(20), bottom: vp2vp(10) })

        })
      }
      .width('100%')
      .padding({ left: 10 })


      Row() {
        Text('搜素热榜')
        Text("换一换").onClick(() => {
          this.getRecommends()
        })
      }
      .width('100%')
      .padding(15)
      .justifyContent(FlexAlign.SpaceBetween)


      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        ForEach(this.hotQuestionList, (item, index) => {
          Row() {
            Text(item.subjectName)
              .fontSize(vp2vp(16))
              .width('45%')
              .height(30)
              .maxLines(1)
              .textOverflow({
                overflow: TextOverflow.Ellipsis
              })

          }
          .margin({ right: vp2vp(20), bottom: vp2vp(10) })
          .onClick(() => {
            // 触发搜索
            this.searchData = item.subjectName
            this.getQuestionList()
          })

        })
      }
      .width('100%')
      .padding({ left: 10 })
    }
  }

  // 搜索结果列表
  @Builder
  SearchListPage() {
    Column() {
      List() {
        LazyForEach(this.questionListDataSource, (item: QuestionItemModel) => {
          ListItem() {
            if(this.params.questionBankType === 10){
              IvQuestionItem({item})
            }else{
              InterviewListItem({ item })
            }
          }
        })

      }
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.gray_bg')
      })
      .padding({ left: vp2vp(15), right: vp2vp(15) })
      .height('100%')
      .width('100%')
      .onReachEnd(() => {
        this.getQuestionList()
      })

    }
  }

  build() {
    Column() {
      Row() {
        TextInput({
          placeholder: "请输入关键词",
          text: this.searchData
        })
          .enterKeyType(EnterKeyType.Search)
          .width(this.searchData.length > 0 ? '80%' : '100%')
          .onChange(val =>
          this.onChangeFunc(val)
          )
          .onSubmit(() => {
            this.onSubmitFunc()
          })

        if (this.searchData.length > 0) {
          Text('取消')
            .onClick(() => {
              this.cancelSearch()
            })
        }

      }
      .padding(10)
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
        .width('100%')
        .color('#707070')
        .padding({ left: '5%', right: '5%' })
        .strokeWidth(vp2vp(1))

      // 切换搜索面板
      if (this.isClick) {
        this.SearchListPage()
      } else {
        this.SearchItemPage()
      }

    }
    .width('100%')
    .height('100%')

  }
}