import router from '@ohos.router'
import PreferencesUtils from '../common/utils/PreferencesUtils'
import ChatDialogViewModel, { ChatDialogue, Dialogue } from '../viewmodel/ChatDialogViewModel'

@Entry
@Component
struct ChatPage {
  scroller: Scroller = new Scroller()
  TextScroller: Scroller = new Scroller()
  controller: TextAreaController = new TextAreaController()
  private userId = ''
  @State text: string = ''
  @State dialogs: Dialogue[] = [];
  @State historyId: string = router.getParams()['historyId'] ?? ''
  @State title: string = router.getParams()['title'] ?? ''

  onPageShow() {
    console.log('show')
    PreferencesUtils.preferencesGet('userid', -1).then((id) => {
      this.userId = String(id); // 这里的赋值是异步的
      this.useChatHistoryPage()
    }).catch((err) => {
      console.log('preference error' + err)
    });
  }

  async useChatHistoryPage() {
    let result = await ChatDialogViewModel.useGetHistoryDialogue({
      userId: +this.userId,
      cursor: null,
      size: null,
      petId: +this.userId,
      historyId: +this.historyId
    })
    this.dialogs = result.map(value => ({
      answer: value.dialogue.answer,
      question: value.dialogue.question
    }))
  }

  async sendMessage() {
    if (this.text === '') {
      return
    }
    this.dialogs.push({
      answer: '',
      question: this.text
    })
    let content = this.text
    this.text = '' // 提前清空
    this.scroller.scrollEdge(Edge.Bottom)
    const data = await ChatDialogViewModel.usePostMessage({
      userId: +this.userId,
      petId: +this.userId,
      content: content,
      historyId: +this.historyId
    })
    this.dialogs[this.dialogs.length -1] = {
      question: content,
      answer: data.dialogue.answer
    }
    console.log(JSON.stringify(this.dialogs[this.dialogs.length - 1]))
    setTimeout(() => {
      this.scroller.scrollEdge(Edge.Bottom)
    }, 15) // 很蹩脚的实现-等到UI更新后在滚动
  }

  build() {
    Column() {
      List({ scroller: this.scroller }) {
        ForEach(this.dialogs, (item: Dialogue, index) => {
          ListItem() {
            Column() {
              Text(item.question)
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
              if (item.answer !== '') {
                Text(item.answer)
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
              } else {
                Progress({ value: 75, total: 150, type: ProgressType.ScaleRing })
                  .color(Color.Grey).value(50).width(30)
                  .style({ strokeWidth: 20, scaleCount: 30, scaleWidth: 3 })
              }
            }
          }
        }, item => JSON.stringify(item))
      //   https://developer.huawei.com/consumer/cn/forum/topic/0203944139717840171?fid=0102683795438680754
      }
      .width('100%')
      .height('90%')
      .listDirection(Axis.Vertical) // 滚动方向纵向
      .scrollBar(BarState.Auto) // 滚动条常驻显示
      .edgeEffect(EdgeEffect.None)
      .onScroll((xOffset: number, yOffset: number) => {
        console.info(xOffset + ' ' + yOffset)
      })
      .onReachEnd(() => {
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
            .width('100%') // 不能设置高度为100%，否则最高只有80px，无法让scroller能够scroll（内部必须必外部高）
        }
        .width('85%')
        .scrollBarWidth(0)
        .backgroundColor('#19000000') // 设置为聚焦时的背景颜色，视觉上让用户误以为是在area内部滚动
        .constraintSize({
          maxHeight: 80
        }) //设置最大高度，从而实现滚动
        .border({
          color: '#E5E5E5',
          style: BorderStyle.Solid,
          width: 5,
          radius: 18
        }) // 必须在scroller中设置border-而不能设置padding，因为padding在盒子内部，会随着滚动而隐藏
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