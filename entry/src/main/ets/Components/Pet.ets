import {getAMedia} from '../viewmodel/PetMedia'

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
  build() {
    Column() {
      Row() {
        if (this.showDialog) {
          Text(this.dialog)
            .width('90%')
            .borderRadius({
              topLeft: 15,
              topRight: 15,
            })
            .backgroundColor(0xEEF2FD)
            .fontSize(16)
            .margin({ left: 10, right: 10, top: 20 })
            .lineHeight(20)
            .padding(10)
        }
      }.height('20%')
      Image(this.url)
        .width(250)
        .height(250)
        .margin(15)
        .borderRadius(30)
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          this.showDialog = true;
          this.url=(getAMedia(this.fullness, this.cleanliness, this.mood));
          console.log("mediaSource"+this.url)
          setTimeout(()=>{
            this.showDialog = false;
          }, 3000)
        })
    }.height('40%')
  }
}