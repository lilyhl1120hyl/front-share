import router from '@ohos.router'
import { UserModel } from '../models/UserModel'

export const USER_KEY = 'interview-user'
const PASS_LIST = ['pages/LoginPage']

export class Auth {
  static initLocalUser() {
    PersistentStorage.PersistProp(USER_KEY, '{}')
  }

  static setUser(user: UserModel) {
    AppStorage.SetOrCreate(USER_KEY, JSON.stringify(user))
  }

  static getUser() {
    const str = AppStorage.Get<string>(USER_KEY) || '{}'
    return JSON.parse(str) as UserModel
  }

  static delUser() {
    AppStorage.Set(USER_KEY, '{}')
  }

  // 需要登录页面使用
  static pushUrl(options: router.RouterOptions) {
    const user = this.getUser()
    if (!PASS_LIST.includes(options.url) && !user.token) {
      return router.pushUrl({
        url: 'pages/LoginPage',
        params: {
          ...options.params,
          return_url: options.url
        }
      })
    }
    return router.pushUrl(options)
  }
}