import router from '@ohos.router'
import WebConstants from '../common/constants/WebConstants'
import { usePost } from '../common/utils/HttpUtil'
import PreferencesUtils from '../common/utils/PreferencesUtils'
import { Alert } from '../Components/Dialog'

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
  @State username: string = ''
  @State password: string = ''


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
          TextInput({text: this.username, placeholder: '请输入账号'})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
            .onChange((value)=>{
              this.username = value
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
          TextInput({text: this.password, placeholder: '请输入密码'})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
            .type(InputType.Password)
            .onChange((value)=>{
              this.password = value
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
        .onClick(async ()=>{
          if (this.username.length === 0){Alert('账号不能为空');return}
          if (this.password.length === 0){Alert('密码不能为空');return}
          await usePost<LoginResponseData, LoginRequestData>(WebConstants.TEST_ENVIRONMENT + '/user/login', {
            username: this.username,
            password: this.password,
          }).then(async ({code, data}) => {
            if(code == '0'){
              await PreferencesUtils.preferencesPut('userid', data.id);
              await PreferencesUtils.preferencesFlush()
              router.clear()
              router.replaceUrl({url: 'pages/Index'})
            }else{
              Alert('账号或密码错误')
            }
          })
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}