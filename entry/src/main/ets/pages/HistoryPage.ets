import router from '@ohos.router';
import hilog from '@ohos.hilog';
import HistoryListViewModel, { HistoryItem } from '../viewmodel/HistoryListViewModel'

@Entry
@Component
struct HistoryPage {
  @State historyList: HistoryItem[] = HistoryListViewModel.useGetDefaultHistoryList();

  aboutToAppear() {
    console.info('aboutTo');
  }

  onPageShow() {
    console.info('show')
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
          // TODO: 对话历史列表，需要从后端获取数据
          // TODO: 这里最好改成可以和上面的Text组件一起拖动
          List({ space: 4, initialIndex: 0 }) {
            ForEach(this.historyList, (item: HistoryItem, index) => {
              ListItem() {
                Row() {
                  Text(item.title)
                    .width('55%')
                    .fontSize(16)
                    .margin({ left: 10 })
                      // .textAlign(TextAlign.Center)
                    .borderRadius(10)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(item.lastChatDate)
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
                    title: item,
                    index: index,
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