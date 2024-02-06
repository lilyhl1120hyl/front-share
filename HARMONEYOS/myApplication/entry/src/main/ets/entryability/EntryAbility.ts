import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import deviceInfo from '@ohos.deviceInfo';
import Want from '@ohos.app.ability.Want';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import CommonConstants from '../common/constants/CommonConstant';
import { GlobalContext } from '../common/utils/GlobalContext';
import Logger from '../common/utils/Logger';


export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam:AbilityConstant.LaunchParam) {
   GlobalContext.getContext().setObject('abilityWant', want);
    GlobalContext.getContext().setObject('launchParam', launchParam);
    if(deviceInfo.deviceType !== CommonConstants.TABLET_DEVICE_TYPE){
      window.getLastWindow(this.context, (err, data) => {
        if (err.code) {
          Logger.error('Failed to obtain the top window. Cause: ' + JSON.stringify(err));
          return;
        }
        let orientation = window.Orientation.PORTRAIT;
        data.setPreferredOrientation(orientation, (err) => {
          if (err.code) {
            Logger.error('Failed to set window orientation. Cause: ' + JSON.stringify(err));
            return;
          }
          Logger.info('Succeeded in setting window orientation.');
        });
      });
    }
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    Logger.info(CommonConstants.TAG_ABILITY, 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/LoginPage', (err, data) => {
      if (err.code) {
        Logger.error(CommonConstants.TAG_ABILITY, 'Load the content to failed ' + JSON.stringify(err));
        return;
      }
      Logger.info(CommonConstants.TAG_ABILITY, 'Loading the content to succeeded ' + JSON.stringify(data));
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
