import router from '@ohos.router'
import PreferencesUtils from '../common/utils/PreferencesUtils'
import ChatDialogViewModel, { ChatDialogue } from '../viewmodel/ChatDialogViewModel'

@Entry
@Component
struct ChatPage {
  scroller: Scroller = new Scroller()
  controller: TextAreaController = new TextAreaController()
  private userid = ''
  @State text: string = ''
  @State dialogs: ChatDialogue[] = ChatDialogViewModel.useGetDefaultDialogue();
  @State historyId: string = router.getParams()['historyId'] ?? ''
  @State title: string = router.getParams()['title'] ?? ''

  onPageShow() {
    console.log('show')
    PreferencesUtils.preferencesGet('userid', -1).then((id) => {
      this.userid = String(id); // 这里的赋值是异步的
    }).catch((err) => {
      console.log('preference error' + err)
    });
    // console.log(this.title,this.historyId,'here',this.userid) this.userid log出来的是赋值前的值
    // this.useChatHistoryPage()
  }

  async useChatHistoryPage() {
    await ChatDialogViewModel.useGetHistoryDialogue({
      userId: +this.userid,
      cursor: 0,
      petId: 0, // TODO:这里默认为0
      historyId: 0
    })
  }

  sendMessage() {
    console.log('click')
    if (this.text === ''){
      return
    }
    const data = ChatDialogViewModel.useGetMockMessage({
      useId: +this.userid,
      petId: 0,
      content: this.text
    })
    console.log(data.dialogue.question, data.dialogue.answer, this.text, this.userid)
    this.dialogs.push(data)
    this.scroller.scrollEdge(Edge.Bottom) // 有bug
    // this.text = ''
    // const {dialogue} = await ChatDialogViewModel.usePostMessage({
    //   useId: +this.userid,
    //   petId: 0,
    //   content: this.text
    // })
    // console.log(dialogue.question, dialogue.answer)
  }

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
            console.log(value, this.text)
          })
          .onFocus(() => {
            console.info('获取焦点')
          })
        Image($r('app.media.message_send'))
          .width(30)
          .rotate({
            angle: 45,
          })
          .onClick(() => this.sendMessage()) // this 问题；不可以直接写：.onClick(this.sendMessage)
      }.width('100%')
      .margin({ top: 10 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }.width('100%').height('100%')
  }
}