import router from '@ohos.router'
import WebConstants from '../common/constants/WebConstants'
import { usePost } from '../common/utils/HttpUtil'

interface LoginRequestData {
  username: string,
  password: string
}

interface LoginResponseData {
  id: number,
  username: string,
  avatar: string,
  phone: string,
}

@Entry
@Component
struct LoginPage {
  onPageShow() {
    usePost<LoginResponseData, LoginRequestData>(WebConstants.TEST_ENVIRONMENT + '/user/login', {
      username: 'zouding',
      password: '123456',
    }).then(({code,data,msg}) => {
      console.log(data.username, data.avatar, data.phone)
    })
  }

  build() {
    Row() {
      Column() {
        Row(){
          Image($r('app.media.default_profile'))
            .width("30%")
        }
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
        }.margin({
          top: 40,
          bottom: 10,
          right: 10,
          left: 10
        })
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
            .type(InputType.Password)
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