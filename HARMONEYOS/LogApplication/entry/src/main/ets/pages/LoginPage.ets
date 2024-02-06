import ColorConstants from "../common/constants/color"


@Entry
@Component
struct LoginPage {
  @State
  isPhoneLogin: boolean = false
  @State
  phoneNumber: string = ''
  @State
  code: string = ''
  @State
  account: string = ''
  @State
  password: string = ''
  @State
  phoneError: boolean = false
  phoneErrorMessage: string = '手机号输入有误! 请重新输入'
  @State
  codeError: boolean = false
  codeErrorMessage: string = '验证码输入有误! 请重新输入'
  @State
  @Watch('changeTime')
  isClock: boolean = false
  @State
  timeAccount: number = 60
  @State
  timerId: number = 0
  @State
  isAllow: boolean = false

  // 倒计时 60s
  changeTime() {
    if (this.isClock) {
      this.timeAccount = 59
      this.timerId = setInterval(this.countDown, 1000)
    }
  }

  countDown() {
    this.timeAccount--
    if (this.timeAccount == 0) {
      this.timeAccount = 60
      this.timerId && clearInterval(this.timerId)
      this.isClock = false
    }
  }

  aboutToDisappear() {
    this.timerId && clearInterval(this.timerId)
  }

  @Builder
  PhoneLogin() {

    Column() {

      List() {
        ListItem() {
          TextInput({ text: this.account, placeholder: '请输入账号' })
            .placeholderColor(ColorConstants.PlaceHolder_Color)
            .backgroundColor(ColorConstants.White_Color)
            .height(50)
            .padding({left:15, right:15})
            .borderRadius(0)
            .onChange((val) => {
              this.account = val

            })

        }
      }.divider({ strokeWidth: 1, color: ColorConstants.Line_Color })


      List() {
        ListItem() {
          Row() {

            TextInput({ text: this.password, placeholder: '请输入密码' })
              .placeholderColor(ColorConstants.PlaceHolder_Color)
              .type(InputType.Password)
              .backgroundColor(ColorConstants.White_Color)
              .height(50)
              .padding({left:15, right:15})
              .borderRadius(0)
              .onChange((val) => {
                this.password = val
              })


          }

        }
      }.divider({ strokeWidth: 1, color: ColorConstants.Line_Color })

    }

  }

  @Builder
  AccountLogin() {

    Column() {

      List() {
        ListItem() {
          TextInput({ text: this.phoneNumber, placeholder: '请输入手机号' })
            .placeholderColor(ColorConstants.PlaceHolder_Color)
            .type(InputType.PhoneNumber)
            .backgroundColor(ColorConstants.White_Color)
            .height(50)
            .padding({left:15, right:15})
            .borderRadius(0)
            .onChange((val) => {
              this.phoneNumber = val

            })
            .onEditChange((isEditing: boolean) => {
              // 停止编辑 校验
              if (!isEditing && this.phoneNumber) {
                let iphoneStr = this.phoneNumber.replace(/\s*/g, '')
                if (!/^1\d{10}$/.test(iphoneStr)) {
                  this.phoneError = true
                } else {
                  this.phoneError = false
                }
              }
            })
        }
      }
      .margin({top:20, bottom:20})
      .divider({ strokeWidth: 2, color: ColorConstants.Line_Color })

      if (this.phoneError) {
        Text(this.phoneErrorMessage)
          .fontColor(ColorConstants.Error_Color)
      }

      List() {
        ListItem() {
          Row() {
            TextInput({ text: this.code, placeholder: '请输入验证码' })
              .placeholderColor(ColorConstants.PlaceHolder_Color)
              .type(InputType.PhoneNumber)
              .backgroundColor(ColorConstants.White_Color)
              .height(50)
              .padding({left:15, right:15})
              .borderRadius(0)
              .onChange((val) => {
                this.code = val
              })
              .onEditChange((isEditing: boolean) => {
                // 停止编辑 校验
                if (!isEditing && this.code) {
                  if (this.code.length !== 6) {
                    this.codeError = true
                  } else {
                    this.codeError = false
                  }
                }
              })

            Row() {
              if (this.isClock) {
                Text(`${this.timeAccount} s后重新获取`)
              } else {
                Text('获取验证码')
                  .onClick(() => {
                    this.isClock = true
                  })
              }
            }

          }

        }
      }
      .margin({top:20, bottom:20})
      .divider({ strokeWidth: 1, color: ColorConstants.Line_Color })

      if (this.codeError) {
        Text(this.codeErrorMessage)
          .fontColor(ColorConstants.Error_Color)
      }

    }

  }

  build() {
    Column() {
      Row() {
        Text('神领物流')
          .fontSize(24)
          .padding({top:10, bottom:50})
          .fontColor(ColorConstants.Main_Text_Color)
      }
      .padding(10)

      Row() {
        Text(this.isPhoneLogin ? '手机号登录' : '账号登录').fontColor(ColorConstants.Main_Text_Color)
          .fontSize(32)

        Row() {
          Text(this.isPhoneLogin ? '账号登录' : '手机号登录').fontColor(ColorConstants.Main_Text_Color)
            .fontSize(16)
            .fontColor(ColorConstants.Brand_Color)
          Image($r('app.media.circle'))
            .width(20)
            .height(20)
        }
        .onClick(() => {
          this.isPhoneLogin = !this.isPhoneLogin
        })

      }
      .width('100%')
      .padding({ left: 15, right: 15 })
      .justifyContent(FlexAlign.SpaceBetween)

      if (this.isPhoneLogin) {
        this.PhoneLogin()
      } else {
        this.AccountLogin()
      }

     Row(){
       Button('登录', { type: ButtonType.Capsule, stateEffect: true })
         .width('100%')
         .height(60)
         .fontSize(24)
         .fontColor(ColorConstants.White_Color)
         .backgroundColor(this.isAllow ? ColorConstants.Brand_Color : ColorConstants.Disabled_Red_Color)
     }
      .width('100%')


    }
    .height('100%')
    .width('100%')

  }
}