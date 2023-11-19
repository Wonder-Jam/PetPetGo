import {PetStateModel} from '../model/PetStateModel'


@Observed
export class PetState{
  public fullness: number;
  public cleanliness: number;
  public mood: number;
  private PetState: PetStateModel;

  constructor(context: Context) {
    this.PetState = new PetStateModel(context);
  }

  public getFullness(){
    this.PetState.getFullness();
  }

  public getCleanliness(){
    this.PetState.getCleanliness();
  }

  public getMood(){
    this.PetState.getMood();
  }

  public getPetState(): Object{
    return this.PetState.getPetState();
  }

  public putFullness(context: Context, fullness: number){
    this.PetState.putFullness(context, fullness);
  }

  public putCleanliness(context: Context, cleanliness: number){
    this.PetState.putCleanness(context, cleanliness);
  }

  public putMood(context: Context, mood: number){
    this.PetState.putMood(context, mood);
  }

}