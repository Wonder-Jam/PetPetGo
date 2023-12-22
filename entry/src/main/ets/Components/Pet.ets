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
  @State animationFlag: boolean = false
  @State show: Visibility = Visibility.Hidden
  private particleColor = [Color.Red, Color.Blue, Color.Green, Color.Orange, Color.Pink, Color.Orange, Color.Yellow, Color.Gray]
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
          this.animationFlag=true;
          this.show=Visibility.Visible
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
      Stack() {
        ForEach(Array.from({length: 40}),()=>{
          Circle({width: 10, height: 10}).fill(this.particleColor[Math.floor(Math.random()*this.particleColor.length)])
            .visibility(this.show)
            .translate(this.animationFlag ? {x:Math.random()*300-150, y:Math.random()*300-150}:{x:0,y:0})
            .opacity(this.animationFlag ? 0 : 1)
            .animation({
              delay: 5,
              duration: 400,
              iterations: 1,
              curve: Curve.FastOutLinearIn,
              playMode: PlayMode.Normal,
              onFinish:()=>{
                this.show=Visibility.Hidden
                this.animationFlag=false
              }
            })

        })
        // Circle({width: 15, height: 15}).fill(Color.Red)
      }
    }.height('40%')
  }
}