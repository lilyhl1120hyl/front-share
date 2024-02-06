import { vp2vp } from '../utils/BaseRem'
import router from '@ohos.router';
import {Auth} from '../utils/Auth'
import promptAction from '@ohos.promptAction';
import {Request} from '../utils/Request'
import {UserModel} from '../models/UserModel'
import emitter from '@ohos.events.emitter';
import {LOGIN_EVENT} from '../common/constants'
import { Logger } from '../utils/Logger'
// 样式扩展
@Extend(TextInput) function customStyle() {
  .height(vp2vp(44))
  .borderRadius(vp2vp(2))
  .backgroundColor('#ffffff')
  .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
  .padding({ left: 0 })
  .placeholderColor('#C3C3C5')
  .caretColor('#fa711d')
}



@Entry
@Component
struct LoginPage {
  @State
  username: string = 'hmheima'
  @State
  password: string = 'Hmheima%123'
  @State
  isAgree: boolean = false
  @State
  loading: boolean = false


  login() {
    if (!this.username) {
      return promptAction.showToast({ message: '请输入用户名' })
    }
    if (!this.password) {
      return promptAction.showToast({ message: '请输入密码' })
    }
    if (!this.isAgree) {
      return promptAction.showToast({ message: '请勾选已阅读并同意' })
    }

    this.loading = true
    Request.post<UserModel>('login', {
      username: this.username,
      password: this.password
    }).then(res => {
      Auth.setUser(res.data)
      Logger.info(`res.data→`, JSON.stringify(res.data))

      // 通知 Home 更新页面
      emitter.emit(LOGIN_EVENT)
      const params = router.getParams()
      if (params && params['return_url']) {
        const url = params['return_url']
        delete params['return_url']
        router.replaceUrl({ url, params })
      } else {
        //router.pushUrl({url: 'pages/Index'})
        router.back()
      }
      this.loading = false
      return promptAction.showToast({ message: '登录成功' })
    }).catch(() => {
      this.loading = false
      return promptAction.showToast({ message: '登录失败' })
    })

  }

  build() {
    Navigation() {
      Scroll() {
        Column() {
          Column() {
            Image($r('app.media.icon'))
              .width(vp2vp(120))
              .aspectRatio(1)
            Text('面试宝典')
              .fontSize(vp2vp(28))
              .margin({ bottom: vp2vp(15) })
            Text('搞定企业面试真题，就用面试宝典')
              .fontSize(vp2vp(14))
              .fontColor($r('app.color.gray'))
          }

          Column({ space: vp2vp(15) }) {
            TextInput({ placeholder: '请输入用户名', text: this.username })
              .customStyle()
              .onChange(val => this.username = val)
            TextInput({ placeholder: '请输入密码', text: this.password, })
              .type(InputType.Password)
              .showPasswordIcon(false)
              .customStyle()
              .onChange(val => this.password = val)
            Row() {
              Checkbox()
                .selectedColor('#fa711d')
                .width(vp2vp(14))
                .aspectRatio(1)
                .select(this.isAgree)
                .onChange((val) => {
                  this.isAgree = val
                })
              Row({ space: vp2vp(4) }) {
                Text('已阅读并同意')
                  .fontSize(vp2vp(14))
                  .fontColor($r('app.color.gray'))
                Text('用户协议')
                  .fontSize(vp2vp(14))
                Text('和')
                  .fontSize(vp2vp(14))
                  .fontColor($r('app.color.gray'))
                Text('隐私政策')
                  .fontSize(vp2vp(14))
              }
            }
            .width('100%')

            Button({ type: ButtonType.Normal   }) {
              Row() {
                if (this.loading) {
                  LoadingProgress()
                    .color('#ffffff')
                    .width(vp2vp(24))
                    .height(vp2vp(24))
                    .margin({ right: vp2vp(10) })
                }
                Text('立即登录').fontColor('#ffffff')
              }
            }
            .width('100%')
            .backgroundColor('transparent')
            .stateEffect(false)
            .borderRadius(vp2vp(4))
            .height(vp2vp(44))
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [['#fc9c1c', 0], ['#fa711d', 1]]
            })
            .enabled(!this.loading)
            .onClick(()=>{ this.login() })
          }
          .padding(vp2vp(30))

          Column() {
            Text('其他登录方式')
              .fontSize(vp2vp(14))
              .fontColor($r('app.color.gray'))
          }
          .padding({ top: vp2vp(70), bottom: vp2vp(100) })
        }
      }
    }
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}