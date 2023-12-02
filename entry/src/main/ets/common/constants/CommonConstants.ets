

export class CommonConstants {
  static readonly PET_STATE = "petState";
  static readonly PET_FULL = "fullness";
  static readonly PET_CLEAN = "cleanliness";
  static readonly PET_MOOD = "mood";
  static readonly RDB_NAME = { dbName: 'taskInfo.db' };
  static readonly FORM_INFO = {
    tableName: 'formInfo',
    columns: ['id', 'formId', 'formName', 'formDimension']
  }
  static readonly FORM_PARAM_IDENTITY_KEY = "ohos.extra.param.key.form_identity";
  static readonly FORM_PARAM_DIMENSION_KEY = "ohos.extra.param.key.form_dimension";
  static readonly FORM_PARAM_NAME_KEY = "ohos.extra.param.key.form_name";
}