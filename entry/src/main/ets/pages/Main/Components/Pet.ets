import { PetState } from '../../../viewmodel/PetState'

@Component
export struct Pet {
  @ObjectLink petState: PetState
  @State showDialog: boolean = false;
  @State dialog: string = '呜呜主人你不要我了么!'

  build() {
    Column() {
      Row() {
        if (this.showDialog) {
          Text(this.dialog)
            .width('90%')
            .borderRadius({
              topLeft: 15,
              topRight: 15,
              // bottomLeft: item.chatterType === 'user' ? 15 : 0,
              // bottomRight: item.chatterType === 'user' ? 0 : 15
            })
            .backgroundColor(0xEEF2FD)
            .fontSize(16)
            .margin({ left: 10, right: 10, top: 20 })
            .lineHeight(20)
            .padding(10)
        }
      }.height('20%')
      Image($r('app.media.sad_and_cry'))
        .width(250)
        .height(250)
        .margin(15)
        .borderRadius(30)
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          this.showDialog = true;
          setTimeout(()=>{
            this.showDialog = false;
          }, 3000)
        })
    }.height('40%')
  }
}