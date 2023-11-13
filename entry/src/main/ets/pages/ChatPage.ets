import router from '@ohos.router'

@Entry
@Component
struct ChatPage{
  scroller: Scroller = new Scroller()
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  controller: TextInputController = new TextInputController()
  @State text: string = router.getParams() ? router.getParams()['text'] : ""
  build(){
    Flex({direction: FlexDirection.Column}){
      //TODO: 展示聊天记录
      Scroll(this.scroller) {
        Column() {
          ForEach(this.arr, (item) => {
            Text(item.toString())
              .width('90%')
              .height(150)
              .borderRadius(15)
              .backgroundColor(0xDCDCDC)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
          }, item => item)
        }.width('100%')
      }.height('90%')
      .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
      .scrollBar(BarState.Auto)  // 滚动条常驻显示
      .scrollBarColor(Color.Gray)  // 滚动条颜色
      .scrollBarWidth(5) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      .onScroll((xOffset: number, yOffset: number) => {
        console.info(xOffset + ' ' + yOffset)
      })
      .onScrollEdge((side: Edge) => {
        console.info('To the edge')
      })
      .onScrollEnd(() => {
        console.info('Scroll Stop')
      })
      //TODO: 底部的发送框
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
          })
      }.width('95%')
    }.width('100%').height('100%')
  }
}