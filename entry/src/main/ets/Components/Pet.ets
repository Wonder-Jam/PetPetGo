import {getAMediaAndRes, getRandomProperty} from '../viewmodel/PetMedia'


// PersistentStorage.PersistProp("fullness", 0);
// PersistentStorage.PersistProp("cleanliness",0);
// PersistentStorage.PersistProp("mood",0);



@Component
export struct Pet {
  @Prop userid: string
  @State showDialog: boolean = false;
  @State dialog: string = '呜呜主人你不要我了么!'
  @StorageLink("fullness") fullness: number = 1
  @StorageLink("cleanliness") cleanliness: number = 1
  @StorageLink("mood") mood: number = 1
  @State url: Resource = $r('app.media.sad_and_cry')
  @State particleAnimationFlag: boolean = false
  @State newPropertyAnimationFlag: boolean = false
  @State showParticle: Visibility = Visibility.Hidden
  @State newProperty: {id: number, url: Resource, text: string, effect: number[]}=null
  @State newPropertyOpacity: number=0
  @State newPropertyTranslate: {x:number, y:number}={x:0,y:0}
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
          this.particleAnimationFlag=true;
          this.showParticle=Visibility.Visible
          if(Math.random()<1){
            this.newProperty=getRandomProperty(this.userid)
            this.newPropertyAnimationFlag=true;
            animateTo({duration: 500, curve: Curve.EaseInOut, onFinish:()=>{
              animateTo({duration: 500, curve: Curve.EaseInOut, onFinish: ()=>{
                this.newPropertyTranslate={x:0, y:0}
              }}, ()=>{
                this.newPropertyTranslate={x:0, y:-150}
                this.newPropertyOpacity=0
              })
            }},()=>{
              this.newPropertyTranslate={x:0,y:-75}
              this.newPropertyOpacity=1
            })
          }
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
            .visibility(this.showParticle)
            .translate(this.particleAnimationFlag ? {x:Math.random()*300-150, y:Math.random()*300-150} : {x:0,y:0})
            .opacity(this.particleAnimationFlag ? 0 : 1)
            .animation({
              delay: 5,
              duration: 400,
              iterations: 1,
              curve: Curve.FastOutLinearIn,
              playMode: PlayMode.Normal,
              onFinish:()=>{
                this.showParticle=Visibility.Hidden
                this.particleAnimationFlag=false
              }
            })
        })
        Image(this.newProperty?this.newProperty.url:'')
          .width(60)
          .height(60)
          .opacity(this.newPropertyOpacity)
          .translate(this.newPropertyTranslate)
      }
    }.height('40%')
  }
}