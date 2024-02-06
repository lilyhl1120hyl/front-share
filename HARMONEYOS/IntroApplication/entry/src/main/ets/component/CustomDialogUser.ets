
@CustomDialog
struct CustomDialogExample {

  @Link activeIndex: number
  controller: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在最后
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
          }.onSelect(()=>{
            this.activeIndex = index
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
    // dialog默认的borderRadius为24vp，如果需要使用border属性，请和borderRadius属性一起使用。
  }
}

@Entry
@Component
struct CustomDialogUser {

  @State activeIndex: number = 999
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: this.onCancel,
      confirm: this.onAccept,
      activeIndex: $activeIndex
    }),
    cancel: this.existApp,
    autoCancel: true,
  })

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = undefined // 将dialogController置空
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

  build() {
    Column() {
      Button('弹窗')
        .onClick(() => {
          if (this.dialogController != undefined) {
            this.dialogController.open()
          }
        }).backgroundColor(0x317aff)
    }.width('100%').margin({ top: 5 })
  }
}