import router from '@ohos.router'
@Entry
@Component
struct LoginPage {

  build() {
    Row() {
      Column() {
        // Row(){
        //   Image($r('app.media.default_profile'))
        //     .scale({x: 0.1, y: 0.1})
        // }
        Row(){
          Text('账号')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入账号'})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
        }.margin(10)
        Row(){
          Text('密码')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入密码'})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
        }.margin(10)
        Text(){
          Span('还没有账号？快来').fontSize(11).fontColor(0xCCCCCC)
          Span('注册').fontSize(11).fontColor('#ffd175').decoration({
            type: TextDecorationType.Underline,
            color: '#ffd175'
          }).onClick(()=>{
            router.replaceUrl({ url: 'pages/RegisterPage' }).then(() => {
              console.info('Succeeded in jumping to the register page.')
            }).catch((err) => {
              console.error(`Failed to jump to the register page.Code is ${err.code}, message is ${err.message}`)
            })
          })
          Span('吧！').fontSize(11).fontColor(0xCCCCCC)
        }
        .alignSelf(ItemAlign.End)
        .margin({right: 60})
        Button() {
          Text('登录')
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