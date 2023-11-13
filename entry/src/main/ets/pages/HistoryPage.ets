import router from '@ohos.router';
import hilog from '@ohos.hilog';

@Entry
@Component
struct HomePage{
  @State  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  build(){
    Row(){
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          Text('对话历史')
            .textAlign(TextAlign.Center)
            .fontSize(20)
            .padding(10)
            .width('100%')
            .height('20%')
          // TODO: 对话历史列表，需要从后端获取数据
          // TODO: 这里最好改成可以和上面的Text组件一起拖动
          List({ space: 4, initialIndex: 0 }) {
            ForEach(this.arr, (item, index) => {
              ListItem() {
                Text('' + item)
                  .width('100%')
                  .height(80)
                  .fontSize(16)
                  .textAlign(TextAlign.Center)
                  .borderRadius(10)
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