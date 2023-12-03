import router from '@ohos.router'
import ChatDialogViewModel, { ChatDialogue } from '../viewmodel/ChatDialogViewModel'

@Entry
@Component
struct ChatPage {
  scroller: Scroller = new Scroller()
  controller: TextAreaController = new TextAreaController()
  @State text: string = router.getParams() ? router.getParams()['text'] : ""
  @State dialogs: ChatDialogue[] = ChatDialogViewModel.useGetDefaultDialogue();
  build() {
    Flex({ direction: FlexDirection.Column }) {
      Scroll(this.scroller) {
        Column() {
          ForEach(this.dialogs, (item: ChatDialogue, index) => {
            Text(item.dialogue.question)
              .width('90%')
              .borderRadius({
                topLeft: 15,
                topRight: 15,
                bottomLeft: 15,
                bottomRight: 0
              })
              .backgroundColor(0xDCDCDC)
              .fontSize(16)
              .margin({ left: 10, right: 10, top: 20 })
              .lineHeight(20)
              .padding(10)
            Text(item.dialogue.answer)
              .width('90%')
              .borderRadius({
                topLeft: 15,
                topRight: 15,
                bottomLeft: 0,
                bottomRight: 15
              })
              .backgroundColor(0xEEF2FD)
              .fontSize(16)
              .margin({ left: 10, right: 10, top: 20 })
              .lineHeight(20)
              .padding(10)
          }, item => item)
        }.width('100%')
      }
      .height('90%')
      .scrollable(ScrollDirection.Vertical) // 滚动方向纵向
      .scrollBar(BarState.Auto) // 滚动条常驻显示
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(5) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .onScroll((xOffset: number, yOffset: number) => {
        console.info(xOffset + ' ' + yOffset)
      })
      .onScrollEdge((side: Edge) => {
        console.info('To the edge')
      })

      Row() {
        TextArea({ text: this.text, placeholder: '快来聊天吧！', controller: this.controller })
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .caretColor(Color.Blue)
          .width('85%')
          .constraintSize({
            minHeight: 40,
            maxHeight: 80,
          })
          .margin(5)
          .fontSize(14)
          .fontColor(Color.Black)
          .onChange((value: string) => {
            this.text = value
          })
          .onFocus(() => {
            console.info('获取焦点')
          })
        Image($r('app.media.message_send'))
          .width(30)
          .rotate({
            angle: 45,
          })
          .onClick(() => console.info('发送信息'))
      }.width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }.width('100%').height('100%')
  }
}