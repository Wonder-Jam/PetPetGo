@Entry
@Component
struct PersonalInfoPage{
  build() {
    Column() {
      Column({ space: 5 }) {
        Stack(){

        }.height('25%')

        Column(){
          Row(){
            Text('个人信息').fontSize(18).fontWeight(FontWeight.Bold)
            Blank()
            Toggle({ type: ToggleType.Switch })
          }.width('100%').margin({left: 20, right: 20})
          Divider().color('#efefef')
          Row(){
            Text('手机号码')
            Blank()
            TextInput({text: '12345678910'}).fontSize(12).width('35%').backgroundColor('#fff')
          }.width('100%').height(40).borderRadius(20)
          Divider().color('#efefef')
          Row(){
            Text('性别')
            Blank()
            TextInput({text: '待填写'}).fontSize(12).width('35%').backgroundColor('#fff')
          }.width('100%').height(40).borderRadius(20)
          Divider().color('#efefef')
          Row(){
            Text('邮箱')
            Blank()
            TextInput({text: '待填写'}).fontSize(12).width('35%').backgroundColor('#fff')
          }.width('100%').height(40).borderRadius(20)
          Divider().color('#efefef')
          Row(){
            Text('生日')
            Blank()
            TextInput({text: '待填写'}).fontSize(12).width('35%').backgroundColor('#fff')
          }.width('100%').height(40).borderRadius(20)
          Divider().color('#efefef')
          Row(){
            Text('地区')
            Blank()
            TextInput({text: '待填写'}).fontSize(12).width('35%').backgroundColor('#fff')
          }.width('100%').height(40).borderRadius(20)
          Divider().color('#efefef')
          Row(){
            Text('简介')
            Blank()
            TextInput({text: '待填写'}).fontSize(12).width('35%').backgroundColor('#fff')
          }.width('100%').height(40).borderRadius(20)
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