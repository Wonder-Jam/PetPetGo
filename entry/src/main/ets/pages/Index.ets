import router from '@ohos.router';
import { Pet } from '../Components/Pet'
import FormUtils from '../common/utils/FormUtils'
import BackgroundUtils from '../common/utils/BackgroundUtil'
import common from '@ohos.app.ability.common';
import { getProperties } from '../viewModel/PetMedia'


PersistentStorage.PersistProp<string>('fullness', '60');
PersistentStorage.PersistProp<string>('cleanliness', '60');
PersistentStorage.PersistProp<string>('mood', '60');


@Entry
@Component
struct Index {
  @State text: string = ''
  @State show: boolean = false;
  @State choice: Number = 0
  @StorageLink('fullness') fullness: string = '1'
  @StorageLink('cleanliness') cleanliness: string = '1'
  @StorageLink('mood') mood: string = '1'
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  @State properties: Object[] = []
  propertyAmount: Map<Number, {amount: Number}> =  new Map<Number, {amount: Number}>()
  scroller: Scroller = new Scroller()

  onPageShow() {
    BackgroundUtils.stopContinuousTask(this.context)
    console.log('map: ' + this.propertyAmount)
  }

  onPageHide() {
    BackgroundUtils.startContinuousTask(this.context)
    setInterval(() => {
      if (Number(this.mood) >= 10) {
        this.mood = String(Number(this.mood) - 10);
      }
      if (Number(this.fullness) >= 10) {
        this.fullness = String(Number(this.fullness) - 10);
      }
      if (Number(this.cleanliness) >= 10) {
        this.cleanliness = String(Number(this.cleanliness) - 10);
      }
      FormUtils.updateCards(getContext())
    }, 10000)
  }

  private updateForm() {
    // let formData = { fullness: this.fullness, cleanliness: this.cleanliness, mood: this.mood };
    // formProvider.updateForm(this.formId, formBindingData.createFormBindingData(formData))
    console.log('fromAction: updateForm undergoing');
    FormUtils.updateCards(getContext())
    console.log('fromAction: updateForm complete');
  }

  private pullPanel(type: string) {
    this.properties = getProperties(type)
    this.show = true;
  }

  controller: TextInputController = new TextInputController()

  build() {
    Stack() {
      // TODO：顶部的两个按钮
      Column() {
        Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
          Image($r('app.media.chat_history_button'))
            .borderRadius(8)
            .width(40)
            .margin({ left: 10 })
            .onClick(() => {
              console.log('ButtonType.Normal')
              router.pushUrl({
                url: 'pages/HistoryPage'
              });
            })
          Image($r('app.media.user_center_button'))
            .borderRadius(8)
            .width(40)
            .margin({ right: 10 })
            .onClick(() => {
              console.log('ButtonType.Normal')
              router.pushUrl({
                url: 'pages/PersonalInfoPage'
              })
            })
        }.height('7%').width('100%')
        // .width('95%')
        // TODO：三个状态条
        Column() {
          Row() {
            Image($r('app.media.food_state')).width(40).height(40).borderRadius(8).margin({ right: 10 })
            Progress({ value: Number(this.fullness), type: ProgressType.Capsule })
              .width('75%')
              .height(10)
              .margin({ top: 10 })
              .color('#7B68EE')
            Text("" + this.fullness).margin({ left: 5 })
          }.height('6%').width('95%')

          Row() {
            Image($r('app.media.clean_state')).width(40).height(40).borderRadius(8).margin({ right: 10 })
            Progress({ value: Number(this.cleanliness), type: ProgressType.Capsule })
              .width('75%')
              .height(10)
              .margin({ top: 10 })
              .color('#7B68EE')
            Text("" + this.cleanliness).margin({ left: 5 })
          }.height('6%').width('95%')

          Row() {
            Image($r('app.media.mood_upset')).width(40).height(40).borderRadius(8).margin({ right: 10 })
            Progress({ value: Number(this.mood), type: ProgressType.Capsule })
              .width('75%')
              .height(10)
              .margin({ top: 5 })
              .color('#7B68EE')
            Text("" + this.mood).margin({ left: 5 })
          }.height('6%').width('95%')
        }.width('95%')
        // TODO：pet主体，目前采用的是image，但是实现需求里的交互应该要换组件
        Pet()
        // TODO：底下的三个button
        Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
          Column() {
            Image($r('app.media.food_button'))
              .borderRadius(8)
              .width(80)
              .onClick(() => {
                if (Number(this.fullness) < 100) {
                  this.fullness = String(Number(this.fullness) + 10);
                  this.updateForm();
                }
                this.pullPanel('food')
              })
            Text('口粮零食').fontWeight(FontWeight.Bold)
          }

          Column() {
            Image($r('app.media.toy_button'))
              .borderRadius(8)
              .width(80)
              .onClick(() => {
                if (Number(this.mood) < 100) {
                  this.mood = String(Number(this.mood) + 10);
                  this.updateForm()
                }
                ;
                this.pullPanel('toys')
              })
            Text('玩具日用').fontWeight(FontWeight.Bold)
          }

          Column() {
            Image($r('app.media.clean_button'))
              .borderRadius(8)
              .width(80)
              .onClick(() => {
                if (Number(this.cleanliness) < 100) {
                  this.cleanliness = String(Number(this.cleanliness) + 10);
                  this.updateForm();
                }
                this.pullPanel('medicine')
              })
            Text('清洗保健').fontWeight(FontWeight.Bold)
          }
        }.height('25%').width('95%')
        //TODO: 底部的输入框，按照设想，当用户点击发送后，会展示聊天页面从底部弹出的动画，更加丝滑
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
      }

      if (this.show) {
        Column()
          .height('100%')
          .width('100%')
          .backgroundColor(0x66000000)
      }
      Panel(this.show) { // 展示日程
        Column() {
          Row() {
            Button('关闭')
              .onClick(() => {
                this.show = false;
              })
              .margin({ top: 10, bottom: 10, right: 20 })
              .width(100)
            Button('商店')
              .onClick(() => {
                this.show = false;
              })
              .margin({ top: 10, bottom: 10, left: 20 })
              .width(100)
          }

          Divider()
          Grid(this.scroller) {
            ForEach(this.properties, (item) => {
              GridItem() {
                Column() {
                  Image(item.url)
                    .borderRadius(10)
                    .objectFit(ImageFit.Contain)
                    .height(60)
                    .width(60)
                  Text(item.text)
                    .fontSize(12)
                    .height(10)
                  Text(this.propertyAmount.has(item.id) ? String(this.propertyAmount.get(item.id).amount) : '0')
                    .fontSize(12)
                    .height(10)
                }
              }.height(100)
            }, (item)=>{
              return item.id
            })
          }
          .columnsTemplate('1fr 1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('90%')
          // .backgroundColor(0xFAEEE0)
          .height('90%')
        }
      }
      .type(PanelType.Temporary)
      .dragBar(false) // 默认开启
      .onChange((width: number, height: number, mode: PanelMode) => {
        console.info(`width:${width},height:${height},mode:${mode}`)
      })
      .zIndex(100)
    }
    .width('100%')
    .height('100%')
  }
}