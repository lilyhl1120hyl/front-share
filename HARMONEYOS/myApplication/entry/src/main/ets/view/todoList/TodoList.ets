
import DataModel from '../../viewmodel/DataModel';
import CommonConstants from '../../common/constants/CommonConstant';
import ToDoItem from './todoItem';
import router from '@ohos.router';


@Entry
@Component
struct ToDoListPage {
  private totalTasks: Array<string> = [];
  // 接收router传递的参数
  @State src:string = router.getParams()?.['src'];

  aboutToAppear() {
    this.totalTasks = DataModel.getData();
  }

  build() {
    Column({ space: CommonConstants.COLUMN_SPACE }) {
      Text($r('app.string.page_title'))
        .fontSize($r('app.float.title_font_size'))
        .fontWeight(FontWeight.Bold)
        .lineHeight($r('app.float.title_font_height'))
        .width(CommonConstants.TITLE_WIDTH)
        .margin({
          top: $r('app.float.title_margin_top'),
          bottom: $r('app.float.title_margin_bottom')
        })
        .textAlign(TextAlign.Start);

      Text(this.src)
        .fontSize(50)
        .fontWeight(FontWeight.Bold);

      ForEach(this.totalTasks, (item: string) => {
        ToDoItem({ content: item })
      }, (item: string) => JSON.stringify(item))
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.page_background'));
  }
}