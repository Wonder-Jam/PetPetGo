import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import FormUtils from '../common/utils/FormUtils';
import FormInfo from '../viewmodel/FormInfo';
import {CommonConstants} from '../common/constants/CommonConstants'
import formProvider from '@ohos.app.form.formProvider';
import { getAMediaAndRes } from '../viewmodel/PetMedia';

// PersistentStorage.PersistProp<string>('fullness', '60');
// PersistentStorage.PersistProp<string>('cleanliness','60');
// PersistentStorage.PersistProp<string>('mood','60');
// PersistentStorage.PersistProp<string>('formId', '');

export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want) {
    let parameters = want.parameters;
    if (parameters) {
      let formId: string = parameters[CommonConstants.FORM_PARAM_IDENTITY_KEY] as string;
      let formName: string = parameters[CommonConstants.FORM_PARAM_NAME_KEY] as string;
      let formDimension: number = parameters[CommonConstants.FORM_PARAM_DIMENSION_KEY] as number;
      let formInfo: FormInfo = {
        formId: formId,
        formName: formName,
        formDimension: formDimension
      };
      // AppStorage.SetOrCreate('fullness', '60');
      // AppStorage.SetOrCreate('cleanliness', '60');
      // AppStorage.SetOrCreate('mood', '60');
      console.log('fromAction: system updating the card')
      FormUtils.insertFormData(this.context, formInfo);

      // let formData = formBindingData.createFormBindingData({fullness: AppStorage.Get('fullness'), cleanliness: AppStorage.Get('cleanliness'), mood: AppStorage.Get('mood')});
      let formData = formBindingData.createFormBindingData('');
      // FormUtils.updateCards(this.context);
      return formData;
    }
  }

  onCastToNormalForm(formId) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  onUpdateForm(formId) {

    FormUtils.updateCards(this.context);
  }

  onChangeFormVisibility(newStatus) {
    // Called when the form provider receives form events from the system.
  }

  onFormEvent(formId, message) {
    // Called when a specified message event defined by the form provider is triggered.
    let msg = JSON.parse(message)
    let stateMediaAndRes = getAMediaAndRes(Number(msg.fullness), Number(msg.cleanliness), Number(msg.mood)).then((value)=>{
      let formData = {
        'url': value.url,
        'dialog': value.res,
      };
      let formInfo = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(formId, formInfo).then((data) => {
        console.info('FormAbility updateForm success.' + JSON.stringify(data));
      }).catch((error) => {
        console.error('FormAbility updateForm failed: ' + JSON.stringify(error));
      })
    })
  }

  onRemoveForm(formId) {
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
};