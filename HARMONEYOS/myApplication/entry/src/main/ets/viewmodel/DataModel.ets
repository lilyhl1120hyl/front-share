

import CommonConstants from '../common/constants/CommonConstant';

export class DataModel {
  /**
   * Saved Data.
   */
  private tasks: Array<string> = CommonConstants.TODO_DATA;

  /**
   * Get the data.
   */
  getData(): Array<string> {
    return this.tasks;
  }
}

export default new DataModel();