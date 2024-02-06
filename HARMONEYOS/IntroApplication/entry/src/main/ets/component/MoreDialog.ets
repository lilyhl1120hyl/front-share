

@CustomDialog
export struct MoreDialog {

  @Link activeIndex: number
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  @State
  List:string[] = ['收藏', '点赞', '问题反馈', '分享试题']

  build() {
    Column() {
      List() {// List默认竖直方向排列子组件
        ForEach(this.List, (item: any, index: number) => {
          ListItem() {
            Text(item)
              .fontSize(18)
              .height(40)
              .width('100%')
              .align(Alignment.Center)
              .textAlign(TextAlign.Center)
          }.onClick(()=>{
            this.activeIndex = index
            this.controller.close()
          })
        })
      }
      .width('100%')
      .align(Alignment.Center)
      .divider({
        strokeWidth: 1,   // 设置分割线宽度
        color: '#ccc'// 设置分割线颜色
      })
    }
  }
}
