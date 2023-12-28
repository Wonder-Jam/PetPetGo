import router from '@ohos.router';
import hilog from '@ohos.hilog';
import HistoryListViewModel, { HistoryItem } from '../viewmodel/HistoryListViewModel'
import PreferencesUtils from '../common/utils/PreferencesUtils';

@Entry
@Component
struct HistoryPage {
  @State historyList: HistoryItem[] = [];
  private userid = ''

  aboutToAppear() {
    console.info('aboutTo');
  }

  onPageShow() {
    console.info('show')
    PreferencesUtils.preferencesGet('userid', -1).then((id) => {
      this.userid = String(id);
      this.useHistoryList()
    }).catch((err) => {
      console.log('preference error' + err)
    });
  }

  async useHistoryList() {
    const list = await HistoryListViewModel.useGetHistoryList(this.userid)
    this.historyList = list.map(value => ({
      ...value,
      lastChatAt: new Date(value.lastChatAt).toISOString().split('T')[0]
    }))
  }

  build() {
    Row() {
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          Text('对话历史')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ left: 20, bottom: 20 })
          if (this.historyList.length !== 0) {
            List({ space: 4, initialIndex: 0 }) {
              ForEach(this.historyList, (item: HistoryItem, index) => {
                ListItem() {
                  Row() {
                    Text(item.lastAnswer)
                      .width('55%')
                      .fontSize(16)
                      .margin({ left: 10 })
                      .borderRadius(10)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Text(item.lastChatAt)
                      .width('30%')
                    Image($r('app.media.arrow_right'))
                      .height('50%')
                  }.height(70)
                  .width('100%')
                  .margin({ left: 10, right: 10 })
                }.borderRadius(10)
                .backgroundColor('#F5F5F5')
                .flexShrink(1)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ChatPage',
                    params: {
                      title: item.lastAnswer,
                      historyId: item.historyId,
                    }
                  });
                })
              }, item => item)
            }.width('95%')
            .height('80%')
          } else {
            Empty()
          }
        }
      }
    }
  }
}

@Component
export struct Empty {
  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Image($r('app.media.sad_and_cry'))
        .width(250)
        .height(250)
        .borderRadius(30)
        .objectFit(ImageFit.Contain)
      Text('快来陪我聊天吧！')
        .fontSize(22)
    }.width('100%')
    .height('100%')
  }
}