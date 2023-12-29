import data_preferences from '@ohos.data.preferences'

let preferences: data_preferences.Preferences = null;
const INSTANCE_NAME: string = "desktopPet";

export class PreferencesUtils{
  initPreferences(context: Context): Promise<void> {
    return data_preferences.getPreferences(context,INSTANCE_NAME).then((val) => {
              preferences=val;
              }).catch((err) => {
              console.error("Failed to get preferences. code ="+err.code+", message ="+err.message);
            });

  }

  preferencesGet(key: string, defaultVal?: any): Promise<data_preferences.ValueType> {
    return preferences.get(key, defaultVal??'default')
  }

  preferencesPut(key: string, value: data_preferences.ValueType = null): Promise<void>{
    return preferences.put(key, value)
  }

  preferencesHas(key: string): Promise<boolean>{
    return preferences.has(key)
  }

  preferencesDelete(key: string): Promise<void>{
    return preferences.delete(key)
  }

  preferencesFlush(): Promise<void>{
    return preferences.flush()
  }

  preferencesGetAll(): Promise<object>{
    return preferences.getAll()
  }
}

let preferencesUtils = new PreferencesUtils()

export default preferencesUtils as PreferencesUtils;