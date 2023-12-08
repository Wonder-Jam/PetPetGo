import WebConstants from '../common/constants/WebConstants';
import { useGet } from '../common/utils/HttpUtil';
import PreferencesUtils from '../common/utils/PreferencesUtils';

interface InfoRequestData {}

interface InfoResponseData {
  id: number,
  avatar: string,
  username: string,
  phone: string,
  gender: string,
  email: string,
  birthday: string,
  region: string,
  intro: string
}

@Entry
@Component
struct PersonalInfoPage{
  @State isChange: boolean = false

  @State username: string = '默认昵称'
  @State avatar: string = 'app.media.default_profile'

  @State sex: string = '请选择'
  @State date: string = '请选择'
  selectedDate: Date = new Date("2010-1-1")

  @State textValue: string = ''
  @State inputValue: string = 'click me'
  @State phoneNumber: string = '00000000000'
  @State mailbox: string = 'xxx@xxx'
  @State localArea: string = 'undefined'
  @State profile: string = '这个人很懒'
  numDialogController: CustomDialogController = new CustomDialogController({ builder: CustomDialogExample({
      confirm: (()=>{this.phoneNumber = this.inputValue;this.isChange = true}), textValue: $textValue, inputValue: $inputValue }), })
  mailDialogController: CustomDialogController = new CustomDialogController({ builder: CustomDialogExample({
    confirm: (()=>{this.mailbox = this.inputValue;this.isChange = true}), textValue: $textValue, inputValue: $inputValue }), })
  areaDialogController: CustomDialogController = new CustomDialogController({ builder: CustomDialogExample({
    confirm: (()=>{this.localArea = this.inputValue;this.isChange = true}), textValue: $textValue, inputValue: $inputValue }), })
  profileDialogController: CustomDialogController = new CustomDialogController({ builder: CustomDialogExample({
    confirm: (()=>{this.profile = this.inputValue;this.isChange = true}), textValue: $textValue, inputValue: $inputValue }), })

  async onPageShow(){
      let id = await PreferencesUtils.preferencesGet('userid')
      // useGet<InfoResponseData, InfoRequestData>(WebConstants.TEST_ENVIRONMENT + '/user/'+id.toString()+'/info')
      //   .then(({code,data,msg}) => {
      //     this.username = data.username;
      //     this.avatar = data.avatar;
      //     this.sex = data.gender;
      //     this.phoneNumber = data.phone;
      //     // this.date = data.birthday;
      //     this.localArea = data.region;
      //     this.mailbox = data.email;
      //     this.profile = data.intro;
      //   })
      // await PreferencesUtils.preferencesGetAll().then((val)=>{
      //   let allKeys = Object.keys(val);
      //   console.info('getAll keys = ' + allKeys);
      //   console.info("getAll object = " + JSON.stringify(val));
      // })
  }

  aboutToDisappear() {
    delete this.numDialogController,
    this.numDialogController = undefined
  }

  build() {
    Column() {
      Column({ space: 5 }) {
        Stack(){
          Row().width("100%").height("100%").linearGradient({
            colors: [[0x6fc7ec, 0.0], [0x7dcbec, 0.1], [0x8bd0ed, 0.2],[0x9ad4ed, 0.3],[0xa8d9ed, 0.4],[0xb6ddee, 0.5],[0xc4e2ee, 0.6],[0xd3e6ee, 0.7],[0xe1ebef, 0.8],[0xefefef, 0.9],[0xefefef, 1.0]]
          })
          Image($r('app.media.default_profile'))
            .width("30%")
            .borderRadius(90)
            .position({x: 20, y: 60})
          Text(this.username).fontSize(20).fontWeight(700).position({x: 150, y: 110})
        }.height('25%')

        Column(){
          Row(){
            Text('个人信息').fontSize(18).fontWeight(FontWeight.Bold)
            Blank()
            if(this.isChange){
              Button('保存', {type: ButtonType.Capsule}).width('22%').backgroundColor('#6fc7ec').fontSize(16).fontWeight('600').fontColor('#')
                .onClick(()=>{
                  this.isChange = false
                })
            }else{
              Button('保存', {type: ButtonType.Capsule}).width('22%').backgroundColor('#efefef').fontSize(16).fontWeight('600').fontColor('#')
            }
          }.width('100%').margin({left: 20, right: 20, bottom: 10})
          Divider().color('#efefef')
          List(){
            ListItem(){
              Row(){
                Text('手机号码')
                Blank()
                Text(this.phoneNumber).textAlign(TextAlign.End).fontSize(12).width('35%').backgroundColor('#fff')
                Image($r('app.media.arrow_right')).width(20)
                  .onClick(()=>{
                    this.numDialogController.open()
                  })
              }.width('100%').height(40)
            }

            ListItem(){
              Row(){
                Text('性别')
                Blank()
                Text(this.sex).textAlign(TextAlign.End).fontSize(12).width('12%').backgroundColor('#fff')
                Image($r('app.media.arrow_right')).width(20)
                  .onClick(()=>{
                    ActionSheet.show({
                      title: '',
                      message: '选择性别',
                      confirm: {
                        value: '确认',
                        action: () => {

                        }
                      },
                      alignment: DialogAlignment.Bottom,
                      offset: { dx: 0, dy: -10 },
                      sheets: [
                        {
                          title: '男孩',
                          action: () => {
                            this.sex = '男孩'
                            this.isChange = true
                          }
                        },
                        {
                          title: '女孩',
                          action: () => {
                            this.sex = '女孩'
                            this.isChange = true
                          }
                        }
                      ]
                    })
                  })
              }.width('100%').height(40)
            }

            ListItem(){
              Row(){
                Text('邮箱')
                Blank()
                Text(this.mailbox).textAlign(TextAlign.End).fontSize(12).width('35%').backgroundColor('#fff')
                Image($r('app.media.arrow_right')).width(20)
                  .onClick(()=>{
                    this.mailDialogController.open()
                  })
              }.width('100%').height(40)
            }

            ListItem(){
              Row(){
                Text('生日')
                Blank()
                Text(this.date).textAlign(TextAlign.End).fontSize(12).width('26%').backgroundColor('#fff')
                Image($r('app.media.arrow_right')).width(20)
                  .onClick(() => {
                    DatePickerDialog.show({
                      start: new Date("2000-1-1"),
                      end: new Date("2050-12-31"),
                      selected: this.selectedDate,
                      onAccept: (value: DatePickerResult) => {
                        this.selectedDate.setFullYear(value.year, value.month, value.day)
                        this.isChange = true
                        this.date = this.selectedDate.getFullYear().toString() + '年' + this.selectedDate.getMonth().toString()+'月'+this.selectedDate.getDay().toString()+'日'
                      },
                    })
                  })
              }.width('100%').height(40)
            }

            ListItem(){
              Row(){
                Text('地区')
                Blank()
                Text(this.localArea).textAlign(TextAlign.End).fontSize(12).width('35%').backgroundColor('#fff')
                Image($r('app.media.arrow_right')).width(20)
                  .onClick(()=>{
                    this.areaDialogController.open()
                  })
              }.width('100%').height(40)
            }

            ListItem(){
              Row(){
                Text('简介')
                Blank()
                Text(this.profile).textAlign(TextAlign.End).fontSize(12).width('35%').backgroundColor('#fff')
                Image($r('app.media.arrow_right')).width(20)
                  .onClick(()=>{
                    this.profileDialogController.open()
                  })
              }.width('100%').height(40)
            }

          }.divider({
            strokeWidth: 1,
            startMargin: 10,
            endMargin: 10,
            color: '#ffe9f0f0'
          })
        }
        .borderRadius(20)
        .height('42%')
        .width('90%')
        .margin(10)
        .padding(10)
        .backgroundColor('#ffffff')

        TextArea()
          .backgroundColor('#ffffff')
          .margin(20)
          .padding(10)
          .height('18%')

      }
      .backgroundColor('#efefef')
      .width('100%')
      .height('100%')
      .margin({ top: 5 })
    }.width('100%')
  }

}

@CustomDialog
struct CustomDialogExample {
  @Link textValue: string
  @Link inputValue: string
  controller: CustomDialogController
  confirm: () => void

  build() {
    Column() {
      Text('请输入').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '', text: this.textValue }).height(60).width('90%')
        .onChange((value: string) => {
          this.textValue = value
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确定')
          .onClick(() => {
            this.inputValue = this.textValue
            this.controller.close()
            this.confirm()
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}