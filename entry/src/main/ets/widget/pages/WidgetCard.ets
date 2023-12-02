

let agencyStorage = new LocalStorage();

@Entry(agencyStorage)
@Component
struct WidgetCard {
  readonly ACTION_TYPE: string = 'router';
  readonly MESSAGE: string = 'add detail';
  readonly ABILITY_NAME: string = 'EntryAbility';
  @LocalStorageProp('fullness') fullness: string = '0';
  @LocalStorageProp('cleanliness') cleanliness: string = '20';
  @LocalStorageProp('mood') mood: string = '40';
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
              Text(this.fullness)
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)
          Stack(){
            Image($r("app.media.fullness_widget"))
              .width(44)
            Text("20")
              .fontColor(Color.White)
              .fontSize(14)
              .padding({
                right: 2
              })
          }
          .alignContent(Alignment.End)

            Row(){
              Image($r("app.media.cleanliness_widget"))
                .width(13)
                .height(13)
                .padding(1)
              Text(this.cleanliness)
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)

          Stack(){
            Image($r("app.media.cleanliness_widget"))
              .width(44)
            Text("20")
              .fontColor(Color.White)
              .fontSize(14)
              .padding({
                right: 2
              })
          }
          .alignContent(Alignment.End)


            Row(){
              Image($r("app.media.mood_widget"))
                .width(14)
                .height(14)
              Text(this.mood)
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)
          Stack(){
            Image($r("app.media.mood_widget"))
              .width(44)
            Text("20")
              .fontColor(Color.White)
              .fontSize(14)
              .padding({
                right: 2
              })
          }
          .alignContent(Alignment.End)
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)



        Image($r("app.media.sad_and_cry"))
          .width("70%")
          .height("70%")
          .objectFit(ImageFit.ScaleDown)
          .onClick(()=>{
            this.count++;
            this.showDialog = true;
          })
          .offset({
            x: 0,
            y: 8
          })
      }
      .width("100%")
      .height("100%")
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        top:10,
        left:10,
        right: 10
      })

      if(this.showDialog) {
        Text("呜呜，干嘛老点人家！已经点了" + this.count.toString() + "次了！")
          .width('90%')
          .borderRadius(10)
          .backgroundColor(0xEEF2FD)
          .fontSize(12)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .padding({
            left:8,
            right:8,
            top:4,
            bottom:4
          })
          .offset({
            x:0,
            y:-10
          })
          .onClick(()=>{
            this.showDialog = false;
            console.log("click the dialog")
          })
      }

    }
    .width("100%")
    .height("100%")
    .alignContent(Alignment.Center)
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