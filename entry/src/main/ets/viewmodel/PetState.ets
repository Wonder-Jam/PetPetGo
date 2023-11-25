import {PetStateModel} from '../model/PetStateModel'


@Observed
export class PetState{
  public fullness: number;
  public cleanliness: number;
  public mood: number;
  private PetState: PetStateModel;

  constructor(context: Context) {
    this.PetState = new PetStateModel(context);
    this.fullness = this.PetState.getFullness();
    this.cleanliness = this.PetState.getCleanliness();
    this.mood = this.PetState.getMood();
  }

  // 使用@Observed和@Prop进行单向绑定，@Observed和@ObjectLink进行双向绑定，不需要get方法了

  // public getFullness(){
  //   return this.fullness;
  // }
  //
  // public getCleanliness(){
  //   return this.cleanliness;
  // }
  //
  // public getMood(){
  //   return this.mood;
  // }
  //
  // public getPetState(): Object{
  //   return this.PetState.getPetState();
  // }

  // 对于双向绑定，不需要使用put方法，但是单向绑定需要

  public putFullness(context: Context, fullness: number){
    this.fullness=fullness;
    this.PetState.putFullness(context, fullness);
  }

  public putCleanliness(context: Context, cleanliness: number){
    this.cleanliness=cleanliness;
    this.PetState.putCleanness(context, cleanliness);
  }

  public putMood(context: Context, mood: number){
    this.mood=mood;
    this.PetState.putMood(context, mood);
  }

}

