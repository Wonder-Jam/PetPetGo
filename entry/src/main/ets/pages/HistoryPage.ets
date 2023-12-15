import router from '@ohos.router';
import hilog from '@ohos.hilog';
import HistoryListViewModel, { HistoryItem } from '../viewmodel/HistoryListViewModel'
import { useGet } from '../common/utils/HttpUtil';
import WebConstants from '../common/constants/WebConstants';
import { Alert } from '../Components/Dialog';
import PreferencesUtils from '../common/utils/PreferencesUtils';

@Entry
@Component
struct HistoryPage {
  @State historyList: HistoryItem[] = HistoryListViewModel.useGetDefaultHistoryList();
  private userid = ''

  aboutToAppear() {
    console.info('aboutTo');
  }

  onPageShow() {
    console.info('show')
    PreferencesUtils.preferencesGet('userid', -1).then((id) => {
      this.userid = String(id);
    }).catch((err) => {
      console.log('preference error' + err)
    });
    // this.useHistoryList()
  }

  async useHistoryList() {
    this.historyList = await HistoryListViewModel.useGetHistoryList(this.userid)
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
                hilog.fatal(0x0000, 'Tag', '%{public}s', 'onClick被点击')
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
        }
      }
    }
  }
}