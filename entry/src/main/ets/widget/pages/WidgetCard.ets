@Entry
@Component
struct WidgetCard {
  unhappyState = [{url: $r('app.media.looking_stupid'), res: '我是谁？我在哪？我都有点神志不清了捏'},{url: $r('app.media.want_food'), res: '妈妈，饿饿，饭饭'}, {url: $r('app.media.want_to_play'), res: '嗨嗨！快来陪我Van呀！'}, {url:$r('app.media.nonono_state'), res:'不要不要不要！'}, {url: $r('app.media.mad'), res: '人家状态不好啦！'}, {url: $r('app.media.proud_and_eager'), res: '哼！主人根本就不爱我！是不是嘛！'} ];
  normalState = [{url: $r('app.media.little_dance'), res: '呼啦呼啦!呼啦呼啦~'}, {url: $r('app.media.drawing_love'), res: '啦啦啦，最爱我的主人啦！'}, {url: $r('app.media.norm_rolling'), res: '滚呐滚~想快快滚到主人身边捏...'}, {url: $r('app.media.shy_and_happy'), res: '嘿嘿嘿，主人终于来找我咯!'}, {url: $r('app.media.eating'), res: 'emm喵喵喵，好吃的嘞'} ]
  happyState = [{url: $r('app.media.giving_out_love'), res: '嘿嘿嘿，也要给主人小心心！'}, {url: $r('app.media.happy_rolling'), res: '诶嘿嘿，滚呐滚呐滚！'}, {url: $r('app.media.shaking_head_happy'), res: '好耶好耶好耶！'}, {url: $r("app.media.spreading_love_around"), res: '嘿嘿嘿，也要给主人小心心！'}, {url: $r('app.media.shaking_happy'), res: '嘿嘿嘿，主人，我的主人...'}]

  getAMediaAndRes(fullness: number, cleanliness: number, mood: number){
    if(fullness<=20 && cleanliness<=20 && mood <=20){
      return { url: $r('app.media.hungry_and_begging'), res: '我又饿又难过，还生病了呜呜呜...'}
    } else if (fullness<=20 && cleanliness<=20){
      return { url: $r('app.media.sad_and_cry'), res: '我好饿...好像还生病了...'}
    } else if (fullness<=20 && mood<=20){
      return { url: $r('app.media.sad_and_cry'), res: '我好饿...好伤心...'}
    } else if (mood<=20 && cleanliness<=20){
      return { url: $r('app.media.sad_and_cry'), res: '我好难过...好像还生病了...'}
    } else if (fullness<20){
      return { url: $r('app.media.eating_mud'), res: '好饿哟...已经在吃土了...'}
    } else if (cleanliness<20){
      return { url: $r('app.media.hungry_and_begging'), res: '好饿哟...已经在吃土了...'}
    } else if (mood<20){
      return { url: $r('app.media.angry_and_sad'), res: '主人你不要我了么！'}
    } else if (fullness<=60 || cleanliness<=60 || mood<=60){
      let choice = Math.floor(Math.random()*this.unhappyState.length);
      return this.unhappyState[choice]
    } else if (fullness<=80 || cleanliness<=80 || mood<=80){
      let choice = Math.floor(Math.random()*this.normalState.length);
      return this.normalState[choice]
    } else {
      let choice = Math.floor(Math.random()*this.happyState.length);
      return this.happyState[choice]
    }
  }

  readonly ACTION_TYPE: string = 'router';
  readonly MESSAGE: string = 'add detail';
  readonly ABILITY_NAME: string = 'EntryAbility';
  @LocalStorageProp('fullness') fullness: string = '0';
  @LocalStorageProp('cleanliness') cleanliness: string = '20';
  @LocalStorageProp('mood') mood: string = '40';
  @State showDialog : boolean = false;
  @State count: number = 0;
  @State url: Resource = this.getAMediaAndRes(Number(this.fullness), Number(this.cleanliness), Number(this.mood)).url;
  @State dialog: string = this.getAMediaAndRes(Number(this.fullness), Number(this.cleanliness), Number(this.mood)).res;

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
            let stateMediaAndRes = this.getAMediaAndRes(Number(this.fullness), Number(this.cleanliness), Number(this.mood))
            this.dialog=stateMediaAndRes.res;
            this.url=stateMediaAndRes.url;
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
        "action": this.ACTION_TYPE,
        "abilityName": this.ABILITY_NAME,
        "params": {
          "message": this.MESSAGE
        }
      });
    })
  }
}