import router from '@ohos.router'
import WebConstants from '../common/constants/WebConstants'
import { usePost } from '../common/utils/HttpUtil'
import { Alert } from '../Components/Dialog'

interface RegisterRequestData {
  username: string,
  avatar: string,
  phone: string,
  password: string,
}

@Entry
@Component
struct RegisterPage {
  username: string = ''
  phone: string = ''
  password: string = ''
  checkpassword: string = ''
  @State avatar: string = 'app.media.default_profile'

  build() {
    Row() {
      Column() {
        Row(){
          Image($r('app.media.default_profile'))
            .width("30%")
        }
        Row(){
          Text('输入账号')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入...', text: this.username})
            .width('60%')
            .margin({
              left: 10,
              right: 30,
            })
            .onChange((value)=>{
              this.username = value;
            })
        }.margin({
          top: 40,
          bottom: 10,
          right: 10,
          left: 10
        })
        Row(){
          Text('手机号码')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入...', text: this.phone})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
            .onChange((value)=>{
              this.phone = value;
            })
        }.margin(10)
        Row(){
          Text('输入密码')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入...', text: this.password})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
            .type(InputType.Password)
            .onChange((value)=>{
              this.password = value;
            })
        }.margin(10)
        Row(){
          Text('确认密码')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          TextInput({placeholder: '请输入...', text: this.checkpassword})
            .width('60%')
            .margin({
              left: 10,
              right: 30
            })
            .type(InputType.Password)
            .onChange((value)=>{
              this.checkpassword = value;
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
        }.type(ButtonType.Capsule).margin({ top: 50 }).backgroundColor('#ffd175').width('60%').height('5%')
        .onClick(async ()=>{
          let re = new RegExp("\\d{4}")
          if (!re.test(this.username)){Alert('请自定义四位数字的账号');return}
          if (this.phone.length === 0){Alert('手机号码不能为空');return}
          if (this.password.length === 0){Alert('密码不能为空');return}
          if (this.checkpassword.length === 0){Alert('请输入确认密码');return}
          if (this.checkpassword !== this.password){Alert('两次密码输入不一致');return}
          await usePost<boolean, RegisterRequestData>(WebConstants.TEST_ENVIRONMENT + '/user/register', {
            username: this.username,
            avatar: this.avatar,
            phone: this.phone,
            password: this.password,
          }).then(async ({data}) => {
            if (data) {
              router.replaceUrl({url: 'pages/LoginPage'})
            }else{
              Alert('注册失败，请更换信息后重试')
            }
          })
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}