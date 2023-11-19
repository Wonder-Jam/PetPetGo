import dataPreferences from '@ohos.data.preferences';
import {CommonConstants as Const} from '../common/constants/CommonConstants'

export class PetStateModel {
  fullness: number;
  cleanliness: number;
  mood: number;

  constructor(context: Context) {
    hasPreferencesValue(context, Const.PET_FULL, (preferences: dataPreferences.Preferences, hasValue: boolean)=>{
      if (hasValue){
        preferences.get(Const.PET_FULL, '-1.0', (err, val)=>{
          if(err){
            console.log(err.message);
          }
          if(val=='-1.0'){
            this.putFullness(context, 1.0);
            this.fullness=1.0;
          } else {
            this.fullness=Number(val);
          }
        })
      } else {
        this.putFullness(context, 1.0);
        this.fullness=1.0;
      }
    });
    hasPreferencesValue(context, Const.PET_CLEAN, (preferences: dataPreferences.Preferences, hasValue: boolean)=>{
      if (hasValue){
        preferences.get(Const.PET_CLEAN, '-1.0', (err, val)=>{
          if(err){
            console.log(err.message);
          }
          if(val=='-1.0'){
            this.putCleanness(context, 1.0);
            this.cleanliness=1.0;
          } else {
            this.cleanliness=Number(val);
          }
        })
      } else {
        this.putCleanness(context, 1.0);
        this.cleanliness=1.0;
      }
    });
    hasPreferencesValue(context, Const.PET_MOOD, (preferences: dataPreferences.Preferences, hasValue: boolean)=>{
      if (hasValue){
        preferences.get(Const.PET_MOOD, '-1.0', (err, val)=>{
          if(err){
            console.log(err.message);
          }
          if(val=='-1.0'){
            this.putMood(context, 1.0);
            this.mood=1.0;
          } else {
            this.cleanliness=Number(val);
          }
        })
      } else {
        this.putMood(context, 1.0);
        this.mood=1.0;
      }
    });
  }

  public getFullness(){
    return this.fullness;
  }

  public getCleanliness(){
    return this.cleanliness;
  }

  public getMood(){
    return this.mood;
  }

  public getPetState(): Object{
    return {fullness: this.fullness, cleanliness: this.cleanliness, mood: this.mood};
  }

  public putFullness(context: Context, fullness: number){
    this.fullness=fullness;
    hasPreferencesValue(context, Const.PET_FULL, (preferences: dataPreferences.Preferences, hasValue: boolean)=>{
      if (hasValue){
        preferences.put(Const.PET_FULL, fullness, (err) => {
          if (err) {
            console.error(`Failed to put data. Code:${err.code}, message:${err.message}`);
            return;
          }
          console.info('Succeeded in putting data.');
          preferences.flush();
        });
      }
    })
  }

  public putCleanness(context: Context, cleanliness: number){
    this.cleanliness=cleanliness;
    hasPreferencesValue(context, Const.PET_FULL, (preferences: dataPreferences.Preferences, hasValue: boolean)=>{
      if (hasValue){
        preferences.put(Const.PET_CLEAN, cleanliness, (err) => {
          if (err) {
            console.error(`Failed to put data. Code:${err.code}, message:${err.message}`);
            return;
          }
          console.info('Succeeded in putting data.');
          preferences.flush();
        });
      }
    })
  }

  public putMood(context: Context, mood: number){
    this.mood = mood;
    hasPreferencesValue(context, Const.PET_FULL, (preferences: dataPreferences.Preferences, hasValue: boolean)=>{
      if (hasValue){
        preferences.put(Const.PET_MOOD, mood, (err) => {
          if (err) {
            console.error(`Failed to put data. Code:${err.code}, message:${err.message}`);
            return;
          }
          console.info('Succeeded in putting data.');
          preferences.flush();
        });
      }
    })
  }
}

function hasPreferencesValue(context: Context, hasKey: string, callback: Function) {
  let preferencesPromise = dataPreferences.getPreferences(context, Const.PET_STATE);
  preferencesPromise.then((preferences: dataPreferences.Preferences) => {
    preferences.has(hasKey).then((hasValue: boolean) => {
      callback(preferences, hasValue);
    });
  });
}



