
import { VideoSpeed } from '../../viewmodel/VideoSpeed';
import CommonConstants from '../../common/constants/CommonConstant';
import { PlayConstants } from '../../common/constants/PlayConstants';

@CustomDialog
export struct PlayTitleDialog {
  @Link playSpeed: number;

  controller: CustomDialogController = new CustomDialogController({
    builder: PlayTitleDialog({
      playSpeed: 0
    })
  });

  build() {
    Column() {
      Row() {
        Text($r('app.string.speed_play'))
          .fontSize($r('app.float.title_font_size'))
      }
      .height(PlayConstants.TITLE_DIALOG_ROW_HEIGHT)
      .width(PlayConstants.TITLE_DIALOG_ROW_WIDTH)

      Column() {
        Grid() {
          ForEach(CommonConstants.SPEED_ARRAY, (item: VideoSpeed) => {
            GridItem() {
              Text(item.text)
                .fontSize($r('app.float.title_dialog_font_size'))
                .backgroundColor($r('app.color.speed_text_color'))
                .width(CommonConstants.FULL_PERCENT)
                .height(CommonConstants.FULL_PERCENT)
                .textAlign(TextAlign.Center)
                .borderRadius($r('app.float.text_border_radius'))
            }
            .onClick(() => {
              this.playSpeed = item.value;
              this.controller.close();
            })
          }, (item: VideoSpeed) => JSON.stringify(item))
        }
        .columnsTemplate(PlayConstants.TITLE_DIALOG_COLUMNS_TEMPLATE)
        .rowsTemplate(PlayConstants.TITLE_DIALOG_ROWS_TEMPLATE)
        .columnsGap(PlayConstants.TITLE_DIALOG_COLUMNS_GAP)
        .rowsGap(PlayConstants.TITLE_DIALOG_ROWS_GAP)
        .width(PlayConstants.TITLE_DIALOG_ROW_WIDTH)
        .height(CommonConstants.FULL_PERCENT)
      }
      .height(CommonConstants.FIFTY_PERCENT)

      Row() {
        Text($r('app.string.cancel'))
          .fontColor($r('app.color.index_tab_selected_font_color'))
          .fontSize($r('app.float.title_dialog_font_size'))
      }
      .height(PlayConstants.TITLE_DIALOG_ROW_HEIGHT)
      .width(PlayConstants.TITLE_DIALOG_ROW_WIDTH)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.controller.close();
      })
    }
    .height(PlayConstants.TITLE_DIALOG_COLUMN_WIDTH)
    .width(CommonConstants.FULL_PERCENT)
    .backgroundColor(Color.White)
  }
}


/**
 * # 定义
 * UpdateDialogController: CustomDialogController = new CustomDialogController({
 builder: UpdateDialog(),
 customStyle: true
 })

 # 调用
 this.UpdateDialogController.open()

 #关闭

 this.UpdateDialogController.close()
 *

 * **/