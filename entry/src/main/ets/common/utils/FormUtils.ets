/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import formBindingData from '@ohos.app.form.formBindingData';
import formProvider from '@ohos.app.form.formProvider';
import RdbUtils from '../database/rdb/RdbUtils';
import FormInfoApi from '../dataBase/tables/FormInfoApi';
import FormInfo from '../../viewmodel/FormInfo';
import Logger from '../utils/Logger';
import { columnDayInfoList, columnTaskInfoInfoList, columnFormInfoList } from '../../viewmodel/RdbColumnModel';
import { CommonConstants as Const } from '../constants/CommonConstants';
import { GlobalContext } from './GlobalContext';
import PreferencesUtils from './PreferencesUtils'

class FormUtils {
  /**
   * Insert form data
   *
   * @param {Context} context Indicates the context of application or capability.
   * @param {FormInfo} formInfo Insert the form information to be saved.
   */
  public insertFormData(context: Context, formInfo: FormInfo): void {
    RdbUtils.initDb(context, Const.RDB_NAME.dbName ? Const.RDB_NAME.dbName : '');
    let isCreatePromise = RdbUtils.isCreateTable(Const.FORM_INFO.tableName ?
    Const.FORM_INFO.tableName : '', columnFormInfoList);
    isCreatePromise.then((result: boolean) => {
      if (!result) {
        Logger.error('error', 'insertFormData form table create error');
        return;
      }
      FormInfoApi.insertData(formInfo, (isDone: number) => {
        if (isDone) {
          Logger.info('error', 'insert formInfo success: ' + JSON.stringify(isDone));
          this.queryFormsAndUpdate();
        }
      });
    });
  }

  /**
   * Update card operation
   *
   * @param {Context} context Indicates the context of application or capability.
   */
  public updateCards(context: Context): void {
    RdbUtils.initDb(context, Const.RDB_NAME.dbName ? Const.RDB_NAME.dbName : '');
    let isCreatePromise = RdbUtils.isCreateTable(Const.FORM_INFO.tableName ?
    Const.FORM_INFO.tableName : '', columnFormInfoList);
    console.log('fromAction: updateCards undergoing')
    isCreatePromise.then((result: boolean) => {
      if (!result) {
        Logger.error('error', 'updateCards form table create error');
        return;
      }
      console.log('fromAction: createPromise undergoing')
      this.queryFormsAndUpdate();
    });
  }

  /**
   * Delete form data
   *
   * @param {Context} context Indicates the context of application or capability.
   * @param {string} formId delete form id
   */
  public deleteFormData(context: Context, formId: string): void {
    RdbUtils.initDb(context, Const.RDB_NAME.dbName ? Const.RDB_NAME.dbName : '');
    let isCreatePromise = RdbUtils.isCreateTable(Const.FORM_INFO.tableName ?
    Const.FORM_INFO.tableName : '', columnFormInfoList);
    isCreatePromise.then((result: boolean) => {
      if (!result) {
        Logger.error('error', 'deleteFormData form table create error');
        return;
      }
      FormInfoApi.deleteFormData(formId);
    });
  }

  /**
   * Update form operation
   */
  public queryFormsAndUpdate(): void {
    console.log('fromAction: queryFormData undergoing');
    FormInfoApi.queryFormData((resultSet: Array<FormInfo>) => {
      resultSet.forEach((item: FormInfo) => {
        let obj = {
          fullness: AppStorage.Get('fullness')??'85',
          cleanliness: AppStorage.Get('cleanliness')??'85',
          mood: AppStorage.Get('mood')??'85',
          // fullness : await PreferencesUtils.preferencesGet('fullness', -1),
          // cleanliness : await PreferencesUtils.preferencesGet('cleanliness', -1),
          // mood : await PreferencesUtils.preferencesGet('mood', -1)
        };
        let formData = formBindingData.createFormBindingData(obj);
        console.log('fromAction: got '+ obj.fullness + obj.cleanliness + obj.mood)
        formProvider.updateForm(item.formId, formData).catch((err: Error) => {
          Logger.error('error', `processTaskData updateForm, err: ${JSON.stringify(err)}`);
        }).then(() => {
          console.log('fromAction: updateForm success');
        });
      });
    });
  }

  /**
   * Background update all card
   */
  public backgroundUpdateCard(taskListChange: boolean): void {
    if (taskListChange) {
      GlobalContext.getContext().setObject('taskListChange', false);
      let timeId = setTimeout(() => {
        this.queryFormsAndUpdate();
        clearInterval(timeId);
      }, 100);
    }
  }
  
}

export default new FormUtils();