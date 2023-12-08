import {getAMediaAndRes} from '../viewmodel/PetMedia'

// PersistentStorage.PersistProp("fullness", 0);
// PersistentStorage.PersistProp("cleanliness",0);
// PersistentStorage.PersistProp("mood",0);

@Component
export struct Pet {
  @State showDialog: boolean = false;
  @State dialog: string = '呜呜主人你不要我了么!'
  @StorageLink("fullness") fullness: number = 1
  @StorageLink("cleanliness") cleanliness: number = 1
  @StorageLink("mood") mood: number = 1
  @State url: Resource = $r('app.media.sad_and_cry')
  aboutToAppear(){
    let stateMediaAndRes = getAMediaAndRes(this.fullness, this.cleanliness, this.mood)
    this.showDialog = true;
    this.url=stateMediaAndRes.url;
    this.dialog=stateMediaAndRes.res;
    setTimeout(()=>{
      this.showDialog=false;
    }, 3000)
  }
  build() {
    Stack() {
      Image(this.url)
        .width(250)
        .height(250)
        // .margin(15)
        .borderRadius(30)
        // .border({width:1, color:Color.Gray})
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          let stateMediaAndRes = getAMediaAndRes(this.fullness, this.cleanliness, this.mood)
          this.showDialog = true;
          this.url=stateMediaAndRes.url;
          this.dialog=stateMediaAndRes.res;
          console.log("mediaSource"+this.url)
          setTimeout(()=>{
            this.showDialog = false;
          }, 3000)
        })
      Row() {
        if (this.showDialog) {
          Text(this.dialog)
            .width('90%')
            .borderRadius(15)
            .backgroundColor(0xEEF2FD)
            .fontSize(16)
            .margin({ left: 10, right: 10, bottom: 170 })
            .lineHeight(20)
            .padding(10)
        }
      }.height('20%')
    }.height('40%')
  }
}