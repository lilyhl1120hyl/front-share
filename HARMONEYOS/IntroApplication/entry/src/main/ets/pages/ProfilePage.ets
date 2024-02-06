import { USER_KEY } from '../utils/Auth'
import { vp2vp } from '../utils/BaseRem'
import { UserModel } from '../models/UserModel'
import {IvLoadingDialog} from '../component/IvLoadingDialog'
import {Auth} from '../utils/Auth'
import {Request, BaseURL} from "../utils/Request"

import picker from '@ohos.file.picker'
import fs from '@ohos.file.fs'
import request from '@ohos.request'
import { Logger } from '../utils/Logger'


@Entry
@Component
struct ProfilePage {
  @StorageProp(USER_KEY)
  @Watch('updateUser')
  userJson: string = '{}'
  @State
  user: UserModel = JSON.parse(this.userJson)

  dialog: CustomDialogController = new CustomDialogController({
    builder: IvLoadingDialog({ message: '更新中...' }),
    customStyle: true,

  })

  updateUser() {
    this.user = JSON.parse(this.userJson)
  }

  URI: string = null

  pickerAvatar() {
    const photoSelectOptions = new picker.PhotoSelectOptions()
    photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE
    photoSelectOptions.maxSelectNumber = 1

    const photoViewPicker = new picker.PhotoViewPicker()
    photoViewPicker.select(photoSelectOptions).then(result => {
      // 1. 得到文件路径
      this.URI = result.photoUris[0]
      this.uploadAvatar()
    })
  }

  uploadAvatar() {
    this.dialog.open()

    const context = getContext(this)
    const fileType = 'jpg'
    const fileName = Date.now() + '.' + fileType
    const copyFilePath = context.cacheDir + '/' + fileName

    const file = fs.openSync(this.URI, fs.OpenMode.READ_ONLY)
    fs.copyFileSync(file.fd, copyFilePath)

    const config: request.UploadConfig = {
      url: BaseURL + 'userInfo/avatar',
      method: 'POST',
      header: {
        'Accept': '*/*',
        'Authorization': `Bearer ${this.user.token}`,
        'Content-Type': 'multipart/form-data'
      },
      files: [
        { name: 'file', uri: `internal://cache/` + fileName, type: fileType, filename: fileName }
      ],
      data: []
    }

    request.uploadFile(context, config, (err, data) => {
      if (err) return Logger.error('UPLOAD', err.message)
      data.on('progress', (size) => {
        Logger.info(size.toString())
      })
      data.on('complete', () => {
        this.getUserInfo()
      })
    })
  }

  getUserInfo () {
    Request.get<{ avatar: string }>('userInfo').then(res => {
      this.user.avatar = res.data.avatar
      Auth.setUser(this.user)
      this.dialog.close()
    })
  }

  updateNickName() {
    this.dialog.open()
    Request.post('userInfo/profile', {
      nickName: this.user.nickName
    }).then(res => {
      this.dialog.close()
      Auth.setUser(this.user)
    })
  }

  build() {
    Navigation() {
      List() {
        ListItem() {
          Row() {
            Text('头像')
            Image(this.user.avatar)
              .alt($r('app.media.avatar'))
              .width(vp2vp(40))
              .aspectRatio(1)
              .borderRadius(vp2vp(20))
              .border({ width: 0.5, color: '#e4e4e4' })
              .onClick(() => {
                this.pickerAvatar()
              })
          }
          .width('100%')
          .height(vp2vp(60))
          .justifyContent(FlexAlign.SpaceBetween)
        }

        ListItem() {
          Row() {
            Text('昵称')
            TextInput({ text: this.user.nickName })
              .textAlign(TextAlign.End)
              .layoutWeight(1)
              .padding(0)
              .height(vp2vp(60))
              .backgroundColor(Color.White)
              .borderRadius(0)
              .onChange((value) => this.user.nickName = value)
              .onSubmit(() => {
                this.updateNickName()
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: vp2vp(30), right: vp2vp(30), top: vp2vp(15), bottom: vp2vp(15) })
      .divider({ strokeWidth: 0.5, color: '#f5f5f5' })
    }
    .title('完善个人信息')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)
  }
}