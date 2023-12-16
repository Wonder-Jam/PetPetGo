import router from '@ohos.router'
import PreferencesUtils from '../common/utils/PreferencesUtils'
import ChatDialogViewModel, { ChatDialogue } from '../viewmodel/ChatDialogViewModel'

@Entry
@Component
struct ChatPage {
  scroller: Scroller = new Scroller()
  TextScroller: Scroller = new Scroller()
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
    if (this.text === '') {
      return
    }
    const data = ChatDialogViewModel.useGetMockMessage({
      useId: +this.userid,
      petId: 0,
      content: this.text
    })
    console.log(data.dialogue.question, data.dialogue.answer, this.text, this.userid)
    this.dialogs.push(data)
    this.text = ''
    setTimeout(() => {
      this.scroller.scrollEdge(Edge.Bottom)
    }, 15) // 很蹩脚的实现-等到UI更新后在滚动
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
        Scroll(this.TextScroller) {
          TextArea({ text: this.text, placeholder: '快来聊天吧！', controller: this.controller })
            .placeholderColor(Color.Grey)
            .placeholderFont({ size: 14, weight: 400 })
            .fontSize(14)
            .fontColor(Color.Black)
            .onChange((value: string) => {
              this.text = value
              this.TextScroller.scrollEdge(Edge.Bottom) // 为了实现始终滚动到底部
            })
            .backgroundColor('#ffffff')
            .width('100%')// 不能设置高度为100%，否则最高只有80px，无法让scroller能够scroll（内部必须必外部高）
        }
        .width('85%')
        .scrollBarWidth(0)
        .backgroundColor('#19000000') // 设置为聚焦时的背景颜色，视觉上让用户误以为是在area内部滚动
        .constraintSize({
          maxHeight: 80
        })//设置最大高度，从而实现滚动
        .border({
          color: '#E5E5E5',
          style: BorderStyle.Solid,
          width: 5,
          radius: 18
        })// 必须在scroller中设置border-而不能设置padding，因为padding在盒子内部，会随着滚动而隐藏
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