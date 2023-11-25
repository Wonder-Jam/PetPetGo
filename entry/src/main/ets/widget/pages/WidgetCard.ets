
@Entry
@Component
struct WidgetCard {
  readonly ACTION_TYPE: string = 'router';
  readonly MESSAGE: string = 'add detail';
  readonly ABILITY_NAME: string = 'EntryAbility';
  @State showDialog : boolean = false;
  @State count: number = 0;

  build() {
    Stack() {
      Image($r("app.media.bg_widget"))
        .width("100%")
        .height("100%")
        .objectFit(ImageFit.Cover)
      Column() {
        Row(){
          Image($r("app.media.sad_and_cry"))
            .width("80%")
            .height("80%")
            .objectFit(ImageFit.ScaleDown)
          .onClick(()=>{
            this.count++;
            this.showDialog = true;
          })
          Column(){
            Row(){
              Image($r("app.media.fullness_widget"))
                .width(14)
                .height(14)
              Text("20")
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)

            Row(){
              Image($r("app.media.cleanliness_widget"))
                .width(13)
                .height(13)
                .padding(1)
              Text("20")
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)



            Row(){
              Image($r("app.media.mood_widget"))
                .width(14)
                .height(14)
              Text("20")
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)

          }
          .height("100%")
          .justifyContent(FlexAlign.Start)
        }
      }
      .width("100%")
      .height("100%")
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.End)
      .padding($r('app.float.column_padding'))

      if(this.showDialog) {
        Text("呜呜，干嘛老点人家！已经点了" + this.count.toString() + "次了！")
          .width('90%')
          .borderRadius(10)
          .backgroundColor(0xEEF2FD)
          .fontSize(12)
          .padding({
            left:8,
            right:8,
            top:4,
            bottom:4
          })
          .margin({
            bottom:10
          })
          .onClick(()=>{
            this.showDialog = false;
            console.log("click the dialog")
          })
      }

    }
    .width("100%")
    .height("100%")
    .alignContent(Alignment.Bottom)
    .onClick(() => {
      postCardAction(this, {
        "action": this.ACTION_TYPE,
        "abilityName": this.ABILITY_NAME,
        "params": {
          "message": this.MESSAGE
        }
      });
    })
  }
}