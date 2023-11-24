import router from '@ohos.router'
@Entry
@Component
struct RegisterPage {

  build() {
    Row() {
      Column() {
        // Row(){
        //   Image($r('app.media.icon'))
        //     .scale({x: 0.1, y: 0.1})
        // }
        Row(){
          Text('输入昵称')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入...'})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
        }.margin(10)
        Row(){
          Text('手机号码')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入...'})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
        }.margin(10)
        Row(){
          Text('输入密码')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入...'})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
        }.margin(10)
        Row(){
          Text('确认密码')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入...'})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
        }.margin(10)
        Text(){
          Span('已有账号？快来').fontSize(11).fontColor(0xCCCCCC)
          Span('登录').fontSize(11).fontColor('#ffd175').decoration({
            type: TextDecorationType.Underline,
            color: '#ffd175'
          }).onClick(()=>{
            router.replaceUrl({ url: 'pages/LoginPage' }).then(() => {
              console.info('Succeeded in jumping to the Login page.')
            }).catch((err) => {
              console.error(`Failed to jump to the Login page.Code is ${err.code}, message is ${err.message}`)
            })
          })
          Span('吧！').fontSize(11).fontColor(0xCCCCCC)
        }
        .alignSelf(ItemAlign.End)
        .margin({right: 40})
        Button() {
          Text('注册')
            .fontSize(16)
            .fontWeight(FontWeight.Normal)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 50
        })
        .backgroundColor('#ffd175')
        .width('60%')
        .height('5%')
      }
      .width('100%')
    }
    .height('100%')
  }
}