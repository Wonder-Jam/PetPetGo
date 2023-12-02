import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import App from '@system.app';
import {CommonConstants} from '../common/constants/CommonConstants'
import RdbUtils from '../common/database/Rdb/RdbUtils';
import Logger from '../common/utils/Logger';
import { columnFormInfoList } from '../model/RdbColumnModel';



export default class EntryAbility extends UIAbility {
  async onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    RdbUtils.initDb(this.context, CommonConstants.RDB_NAME.dbName ? CommonConstants.RDB_NAME.dbName : '');
    await RdbUtils.createDb();
    RdbUtils.createTable(CommonConstants.FORM_INFO.tableName ? CommonConstants.FORM_INFO.tableName : '', columnFormInfoList)
      .catch((err: Error) => {
        Logger.error(`RdbHelper formInfo err : ${JSON.stringify(err)}`);
      });
    AppStorage.SetOrCreate('fullness', '60');
    AppStorage.SetOrCreate('cleanliness', '60');
    AppStorage.SetOrCreate('mood', '60');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
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