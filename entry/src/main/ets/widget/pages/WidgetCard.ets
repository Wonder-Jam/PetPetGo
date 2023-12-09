let storage = new LocalStorage();

@Entry(storage)
@Component
struct WidgetCard {
  @LocalStorageProp('fullness') fullness: string = '0';
  @LocalStorageProp('cleanliness') cleanliness: string = '20';
  @LocalStorageProp('mood') mood: string = '40';
  @State showDialog : boolean = false;
  @State count: number = 0;
  @LocalStorageProp('url') url: Resource = $r("app.media.sleep");
  @LocalStorageProp('dialog') dialog: string = '';

  build() {
    Stack() {
      Image($r("app.media.bg_widget"))
        .width("100%")
        .height("100%")
        .objectFit(ImageFit.Cover)
      Column() {
        Row(){
          Stack(){
            Image($r("app.media.fullness_widget"))
              .width(48)
            Text(this.fullness)
              .fontColor(Color.White)
              .fontSize(12)
              .padding({
                right: 2
              })
          }
          .alignContent(Alignment.End)

          Stack(){
            Image($r("app.media.cleanliness_widget"))
              .width(48)
            Text(this.cleanliness)
              .fontColor(Color.White)
              .fontSize(12)
              .padding({
                right: 2
              })
          }
          .alignContent(Alignment.End)

          Stack(){
            Image($r("app.media.mood_widget"))
              .width(48)
            Text(this.mood)
              .fontColor(Color.White)
              .fontSize(12)
              .padding({
                right: 2
              })
          }
          .alignContent(Alignment.End)
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)



        Image(this.url)
          .width("70%")
          .height("70%")
          .objectFit(ImageFit.ScaleDown)
          .onClick(()=>{
            this.count++;
            this.showDialog = true;
            postCardAction(this, {
              'action': 'message',
              'params': {
                'msgTest': 'interact'
              }
            });
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
        Text(this.dialog)
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
            this.url=$r("app.media.sleep");
            console.log("click the dialog")
          })
      }

    }
    .width("100%")
    .height("100%")
    .alignContent(Alignment.Center)
    .onClick(() => {
      postCardAction(this, {
        "action": 'router',
        "abilityName": 'EntryAbility',
        "params": {
          "message": 'add detail'
        }
      });
    })
  }
}