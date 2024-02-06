import router from '@ohos.router';


let msg: string = '父页面传递过来的参数'

@Entry
@Component
struct Index {
  @State message: string = 'Hello word'


  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Red);
        Blank();
        Button('跳转待办').onClick(()=>{
          router.pushUrl({
            url: 'pages/TodoList',
            params: {
              src: 'Index页面传来的数据',
            }
          });
        }).width(160);
        Blank(10);
        Button('跳转水果排行榜').onClick(()=>{
          router.pushUrl({
            url: 'pages/RankPage'
          });
        }).width(160);
        Blank(10);
        Button('跳转登录').onClick(()=>{
          router.pushUrl({
            url: 'pages/LoginPage'
          });
        }).width(160);

      }
      .width('100%')
    }
    .height('100%')
  }
}