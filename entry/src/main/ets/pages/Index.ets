import router from '@ohos.router';


@Entry
@Component
struct Index {
  @State text: string = ''
  @State show: boolean = false;
  controller: TextInputController = new TextInputController()
  build() {
    Row() {
      Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
        Column() {
          // TODO：顶部的两个按钮
          Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
            Button('历史', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
                router.pushUrl({
                  url: 'pages/HistoryPage'
                });
              })
            Button('登录', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
                this.show=true
              })
          }.height('10%')
          .width('95%')
          // TODO：三个状态条
          Row() {
            Progress({ value: 20, type: ProgressType.Capsule }).width('100%').height(20).margin({ top: 10 })
          }.height('6%').width('95%')
          Row() {
            Progress({ value: 20, type: ProgressType.Capsule }).width('100%').height(20).margin({ top: 10 })
          }.height('6%').width('95%')
          Row() {
            Progress({ value: 20, type: ProgressType.Capsule }).width('100%').height(20).margin({ top: 10 })
          }.height('6%').width('95%')
          // TODO：pet主体，目前采用的是image，但是实现需求里的交互应该要换组件
          Row() {
            Image($r('app.media.icon'))
              .width(250).height(250).margin(15)
          }.height('40%')
          // TODO：底下的三个button
          Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
            Button('零食', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
              })
            Button('玩具', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
              })
            Button('保健', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
              })
          }.height('15%').width('95%')
          //TODO: 底部的输入框，按照设想，当用户点击发送后，会展示聊天页面从底部弹出的动画，更加丝滑
          Row(){
            TextInput({ text: this.text, placeholder: 'input your word...', controller: this.controller })
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .caretColor(Color.Blue)
              .width('75%')
              .height(40)
              .margin(5)
              .fontSize(14)
              .fontColor(Color.Black)
              .inputFilter('[a-z]', (e) => {
                console.log(JSON.stringify(e))
              })
              .onChange((value: string) => {
                this.text = value
              })
            Button('发送', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width('22%')
              .margin(5)
              .onClick(() => {
                console.log('ButtonType.Normal')
                router.pushUrl({
                  url: 'pages/ChatPage',
                  params: {
                    text: this.text
                  }
                });
              })
          }.height('17%').width('95%')
          Panel(this.show) { // 展示日程
            Column() {
              Text('Today Calendar')
              Divider()
              Text('1. afternoon 4:00 The project meeting')
            }
          }
          .type(PanelType.Foldable).mode(PanelMode.Half)
          .dragBar(true) // 默认开启
          .halfHeight('50%') // 默认一半
          .onChange((width: number, height: number, mode: PanelMode) => {
            console.info(`width:${width},height:${height},mode:${mode}`)
          })
        }
        .width('100%')
      }
      .height('100%')
    }
  }
}