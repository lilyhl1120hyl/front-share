import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Index {
  @State
  text: string = '下拉即可刷新'
  @State
  translateY: number = 0
  @State
  loading: boolean = false

  // 如果传入 100 返回 60
  ease (distance: number) {
    const space = 60 // 开始阻尼的阀值
    const damp = 0.3 // 阻尼效果
    if ( distance > 60 ) {
      const newDistance =  space + (distance - space) * damp
      return newDistance
    }
    return distance
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // 文字和加载效果
      Row() {
        if (this.loading) {
          LoadingProgress()
            .width(32)
            .aspectRatio(1)
        }
        Text(this.text)
          .fontSize(14)
          .fontColor('#999')
      }
      .height(100)
      // 列表，遮住文字
      List() {
        ListItem(){
          Text('下拉刷新')
        }

      }
      .translate({ y: this.translateY })
      .backgroundColor('#fff')
      .width('100%')
      .height('100%')
      // 拖动手势事件
      .gesture(
        PanGesture()
          .onActionUpdate(event => {
            this.translateY = this.ease(event.offsetY)
            // 超过100显示 释放立刻刷新
            if (this.translateY > 100) {
              this.text = '释放立刻刷新'
            }
          })
          .onActionEnd(() => {
            ``
            if (this.translateY > 100) {
              this.loading = true
              this.text = '正在刷新中...'
              animateTo({ duration: 300 }, () => {
                this.translateY = 100
              })
              // 可以进行刷新的动作，发请求
              setTimeout(() => {
                this.loading = false
                this.text = ''

                // 进行吸附
                animateTo({ duration: 300, onFinish: () => {
                  promptAction.showToast({ message: '刷新成功' })
                } }, () => {
                  this.translateY = 0
                })
              }, 2000)

            } else {
              animateTo({ duration: 300 }, () => {
                this.translateY = 0
              })
            }
          })
      )
    }
    .backgroundColor('#ccc')
  }
}