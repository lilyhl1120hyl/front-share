

import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import CommonConstants from '../constants/CommonConstant';
import Logger from './Logger';
import HobbyItem from '../../viewmodel/HobbyItem';
import Context from '@ohos.app.ability.common';

/**
 * Common operation tools.
 */
export class CommonUtils {
  /**
   * ArkTS login account and password.
   *
   * @param {string} account account
   * @param {string} password password
   */
  public loginArkTS(account: string, password: string): void {
    let check: Resource | string = this.loginCheckArkTS(account, password);
    if (CommonConstants.LOGIN_TEXT !== check) {
      Logger.error(CommonConstants.TAG_COMMON_UTILS, 'login account or password is empty');
      this.showToastContent(check);
      return;
    }
    this.routerPage(CommonConstants.MAIN_PAGE_URL);
  }

  /**
   * Native login account and password.
   *
   * @param {string} account account
   * @param {string} password password
   */
  public loginNative(account: string, password: string): void {
    let check: string = this.loginCheckNative(account, password);
    if (CommonConstants.LOGIN_TEXT !== check) {
      Logger.error(CommonConstants.TAG_COMMON_UTILS, 'login account or password is empty');
      this.showToastContent(check);
      return;
    }
    this.routerPage(CommonConstants.MAIN_PAGE_URL);
  }

  /**
   * CHeck account and password is it empty.
   *
   * @param {string} account account
   * @param {string} password password
   * @return {Resource|string} return check result
   */
   private loginCheckArkTS(account: string, password: string): Resource | string {
    let check: string = '';
    if (account === '') {
      return $r('app.string.please_input_account');
    } else if (password === '') {
      return $r('app.string.please_input_password');
    } else {
      check = CommonConstants.LOGIN_TEXT;
    }
    return check;
  }

  /**
   * Native login account and password.
   *
   * @param {string} account account
   * @param {string} password password
   * @return {string} return  check result
   */
  private loginCheckNative(account: string, password: string): string {
    let check: string = 'login'
    return check;
  }

  /**
   * Router page
   *
   * @param {string} url page url
   */
  public routerPage(url: string): void {
    router.replaceUrl({
      url: url
    }).catch((error: Error) => {
      Logger.error(CommonConstants.TAG_COMMON_UTILS, 'replace url error ' + JSON.stringify(error));
    });
  }

  /**
   * Show toast content.
   *
   * @param {Resource | string} content content to show
   */
  public showToastContent(content: Resource | string): void {
    promptAction.showToast({
      message: content,
      duration: CommonConstants.TOAST_DURATION
    });
  }

  /**
   * Alert dialog dialog
   */
  alertDialog(context: Context.UIAbilityContext) {
    AlertDialog.show({
      message: $r('app.string.alert_dialog_message'),
      alignment: DialogAlignment.Bottom,
      offset: {
        dx: 0,
        dy: CommonConstants.DY_OFFSET
      },
      primaryButton: {
        value: $r('app.string.cancel_button'),
        action: () => {
          Logger.info(CommonConstants.TAG_COMMON_UTILS, 'Callback cancel button is clicked');
        }
      },
      secondaryButton: {
        value: $r('app.string.definite_button'),
        action: () => {
          // Exiting the app.
          context.terminateSelf();
          Logger.info(CommonConstants.TAG_COMMON_UTILS, 'Callback definite button is clicked');
        }
      }
    });
  }


  /**
   * Date dialog dialog
   */
  datePickerDialog(dateCallback: Function) {
    DatePickerDialog.show({
      start: new Date(CommonConstants.START_TIME),
      end: new Date(),
      selected: new Date(CommonConstants.SELECT_TIME),
      lunar: false,
      onAccept: (value: DatePickerResult) => {
        let year: number = Number(value.year);
        let month: number = Number(value.month) + CommonConstants.PLUS_ONE;
        let day: number = Number(value.day);
        let birthdate: string = this.getBirthDateValue(year, month, day);
        dateCallback(birthdate);
      }
    });
  }

  /**
   * Text dialog dialog
   */
  textPickerDialog(sexArray: Resource, sexCallback: Function) {
    if (this.isEmpty(sexArray)) {
      Logger.error(CommonConstants.TAG_COMMON_UTILS, 'sex is null');
      return;
    }
    TextPickerDialog.show({
      range: sexArray,
      selected: 0,
      onAccept: (result: TextPickerResult) => {
        sexCallback(result.value);
      },
      onCancel: () => {
        Logger.info(CommonConstants.TAG_COMMON_UTILS, 'TextPickerDialog onCancel');
      }
    });
  }

  /**
   * Get default birth date
   *
   * @param {number} year year
   * @param {number} month month
   * @param {number} day day
   * @returns {string} return birth date
   */
  getBirthDateValue(year: number, month: number, day: number): string {
    let birthdate: string = `${year}${CommonConstants.DATE_YEAR}${month}` +
    `${CommonConstants.DATE_MONTH}${day}${CommonConstants.DATE_DAY}`;
    return birthdate;
  }

  /**
   * Check obj is empty
   *
   * @param {object} obj
   * @return {boolean} true(empty)
   */
  isEmpty(obj: object | string): boolean {
    return obj === undefined || obj === null || obj === '';
  }

  /**
   * Check array is empty
   *
   * @param {Array}array
   * @return {boolean} true(empty)
   */
  isEmptyArr(array: Array<HobbyItem>): boolean {
    return this.isEmpty(array) || array.length === 0;
  }

}

export default new CommonUtils();