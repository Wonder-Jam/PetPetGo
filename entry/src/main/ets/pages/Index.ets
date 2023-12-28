import router from '@ohos.router';
import { Pet } from '../Components/Pet'
import FormUtils from '../common/utils/FormUtils'
import BackgroundUtils from '../common/utils/BackgroundUtil'
import common from '@ohos.app.ability.common';
import { getProperties, putPropertyUpdate } from '../viewModel/PetMedia'
import { useGet, usePost } from '../common/utils/HttpUtil'
import PreferencesUtils from '../common/utils/PreferencesUtils'
import WebConstants from '../common/constants/WebConstants'
import { Alert, InformDialog } from '../Components/Dialog';
import promptAction from '@ohos.promptAction'
import { getCurrentWeather } from '../viewmodel/WeatherViewModel'
import { useGetMaxHistoryId, usePostMessage } from '../viewmodel/PetMedia';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import App from '@system.app';

@Observed
class resObject {
  id: number;
  amount: number;
  name: string;
  type: string;
}


PersistentStorage.PersistProp<string>('fullness', '60');
PersistentStorage.PersistProp<string>('cleanliness', '60');
PersistentStorage.PersistProp<string>('mood', '60');


@Entry
@Component
@Observed
struct Index {
  @State text: string = ''
  @State show: boolean = false;
  @State choice: Number = 0
  @StorageLink('fullness') fullness: string = '1'
  @StorageLink('cleanliness') cleanliness: string = '1'
  @StorageLink('mood') mood: string = '1'
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  @State userid: string = ''
  @State properties: Object[] = []
  @State curType: string = ''
  @State propertyAmount: resObject[] = []
  @State isHidden: boolean = false
  @State isLoadingAnswer: boolean = false
  @State answer: string = '快来和我聊天吧(*≧▽≦)'
  scroller: Scroller = new Scroller()
  reqPermissionsFromUser = async (permissions: Array<Permissions>):Promise<boolean> => {
    let context = getContext(this) as common.UIAbilityContext;
    let atManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, permissions)
    const permissionData = await atManager.requestPermissionsFromUser(context, permissions)
    //   .then((data) => {
    //   let grantStatus: Array<number> = data.authResults;
    //   let length: number = grantStatus.length;
    //   for (let i = 0; i < length; i++) {
    //     if (grantStatus[i] === 0) {
    //       // 用户授权，可以继续访问目标操作
    //       getCurrentWeather()
    //       return true;
    //     } else {
    //       // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
    //       promptAction.showToast({
    //         message: "主人，我需要大致的定位信息才能提醒你天气哦~"
    //       })
    //
    //       return false;
    //     }
    //   }
    //   return false;
    //   // 授权成功
    // }).catch((err) => {
    //   console.error(`requestPermissionsFromUser failed, code is ${err.code}, message is ${err.message}`);
    //   return false;
    // })
    let grantStatus: Array<number> = permissionData.authResults;
    let length: number = grantStatus.length;
    for (let i = 0; i < length; i++) {
      if (grantStatus[i] === 0) {
        // 用户授权，可以继续访问目标操作
        return true;
      } else {
        // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
        promptAction.showToast({
          message: "主人，我需要大致的定位信息才能提醒你天气哦~"
        })
        InformDialog("主人，我需要大致的定位信息才能提醒你天气哦~", "嗷嗷", "哒咩", "授权提醒",()=>{
          this.openPermissionsInSystemSettings()
        })
        return false;
      }
    }
    return false;
  }

  openPermissionsInSystemSettings(): void {
    let context = getContext(this) as common.UIAbilityContext;
    let wantInfo = {
      action: 'action.settings.app.info',
      parameters: {
        settingsParamBundleName: 'com.njutolove.petpetgo' // 打开指定应用的详情页面
      }
    }
    context.startAbility(wantInfo).then(() => {
      promptAction.showToast({
        message: "在应用权限中允许我获取您的地理位置哦~"
      })
    }).catch((err) => {
      // ...
    })
  }

  async onPageShow() {
    console.log('onPageShow~')
    BackgroundUtils.stopContinuousTask(this.context)
    console.log('map: ' + this.propertyAmount)
    // this.reqPermissionsFromUser()
    await (this.reqPermissionsFromUser(['ohos.permission.APPROXIMATELY_LOCATION']))&&getCurrentWeather()
    PreferencesUtils.preferencesGet('userid', -1).then((id) => {
      this.userid = String(id);
      console.log(String(id), 'id')
    }).catch((err) => {
      console.log('preference error' + err)
    });

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
    }, 100000)
    this.answer = '快来和我聊天吧(*≧▽≦)'
  }

  private updateForm() {
    // let formData = { fullness: this.fullness, cleanliness: this.cleanliness, mood: this.mood };
    // formProvider.updateForm(this.formId, formBindingData.createFormBindingData(formData))
    console.log('fromAction: updateForm undergoing');
    FormUtils.updateCards(getContext())
    console.log('fromAction: updateForm complete');
  }

  private async pullPanel(type: string) {
    this.properties = getProperties(type)
    const detectQuery = setTimeout(() => {
      promptAction.showToast({
        message: "网络不畅，正在请求"
      })
    }, 2000)

    switch (type) {
      case 'food':
        console.log('httputil pending, url:' + WebConstants.TEST_ENVIRONMENT + `/user/${this.userid??'nan'}/prop?type=food`)
        await useGet<resObject[], undefined>(WebConstants.TEST_ENVIRONMENT + `/user/${this.userid??'nan'}/prop?type=food`).then(async ({code, msg, data}) => {
          if (code == '0') {
            clearTimeout(detectQuery)
            this.propertyAmount = data;
            console.log('httputil' + data)
            data.map((item) => {
              console.log('httputil' + item.name + item.amount)
            })
          } else {
            console.log('httputil error')
            Alert(`错误：网络错误QAQ！`)
          }
        })
        this.curType = 'food'
        break
      case 'medicine':
        await useGet<resObject[], undefined>(WebConstants.TEST_ENVIRONMENT + `/user/${this.userid??'nan'}/prop?type=medicine`).then(async ({code, msg, data}) => {
          if (code == '0') {
            clearTimeout(detectQuery)
            this.propertyAmount = data;
            data.map((item) => {
              console.log('httputil' + item.name + item.amount)
            })
          } else {
            Alert(`错误：网络错误QAQ！`)
          }
        })
        this.curType = 'medicine'
        break
      case 'toys':
        await useGet<resObject[], undefined>(WebConstants.TEST_ENVIRONMENT + `/user/${this.userid??'nan'}/prop?type='toy'`).then(async ({code, msg, data}) => {
          if (code == '0') {
            clearTimeout(detectQuery)
            this.propertyAmount = data;
            data.map((item) => {
              console.log('httputil' + item.name + item.amount)
            })
          } else {
            Alert(`错误：网络错误QAQ！`)
          }
        })
        this.curType = 'toys'
        break
    }
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
              .animation({
                duration: 300,
                iterations: 1,
                curve: Curve.Linear
              })
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
        Pet({ userid: this.userid })

        // TODO：底下的三个button
        if (!this.isHidden) {
          Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
            Column() {
              Image($r('app.media.food_button'))
                .borderRadius(8)
                .width(80)
                .onClick(() => {
                  if (Number(this.fullness) < 100) {
                    // this.fullness = String(Number(this.fullness) + 10);
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
                    // this.mood = String(Number(this.mood) + 10);
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
                    // this.cleanliness = String(Number(this.cleanliness) + 10);
                    this.updateForm();
                  }
                  this.pullPanel('medicine')
                })
              Text('清洗保健').fontWeight(FontWeight.Bold)
            }
          }.height('25%').width('95%')
          .transition({ type: TransitionType.Insert, opacity: 0, translate: { x: -200, y: 0 } })
          .transition({ type: TransitionType.Delete, opacity: 0, translate: { x: -200, y: 0 } })
        } else {
          Scroll() {
            if (this.isLoadingAnswer) {
              LoadingProgress().color('#AC49F5')
                .width(50)
                .height(50)
            } else {
              Text(this.answer)
            }
          }
          .constraintSize({ maxHeight: '25%' })
          .width('95%')
          .borderRadius(20)
          .padding(15)
          .backgroundColor('#F1F3F5')
          .transition({ type: TransitionType.Insert, opacity: 0, translate: { x: 200, y: 0 } })
          .transition({ type: TransitionType.Delete, opacity: 0, translate: { x: 200, y: 0 } })
        }
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
              animateTo({ duration: 500 }, () => {
                this.isHidden = true
              })
            })
            .onBlur(() => {
              animateTo({ duration: 500 }, () => {
                this.isHidden = false
              })
              console.log('blur')
            })
            .onClick(() => {
              if (!AppStorage.Has('newHistoryId')) {
                useGetMaxHistoryId(this.userid)
              }
            })
            .defaultFocus(false)
            .focusOnTouch(true)
            .key('0')
          Button()
            .focusable(true)
            .defaultFocus(true)
            .width(0)
            .height(0)
            .visibility(Visibility.Hidden)
            .key('1')
          Image($r('app.media.message_send'))
            .width(30)
            .rotate({
              angle: 45,
            })
            .onClick(async () => {
              this.isLoadingAnswer = true
              let answer = await usePostMessage(+this.userid, this.text)
              this.text = ''
              this.isLoadingAnswer = false
              this.answer = answer
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }.onClick(() => {
        focusControl.requestFocus('1')
      })

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
          }

          Divider()
          Grid(this.scroller) {
            ForEach(this.properties, (item) => {
              GridItem() {
                Column() {
                  Image(item.url)
                    .borderRadius(10)
                    .objectFit(ImageFit.Contain)
                    .height(56)
                    .width(56)
                  Text(item.text)
                    .fontSize(12)
                    .height(12)
                  Text(this.propertyAmount.find(obj => obj.name === item.text) ? String(this.propertyAmount.find(obj => obj.name === item.text)
                    .amount) : '0')
                    .fontSize(12)
                    .height(12)
                }
              }.height(100).onClick(() => {
                this.fullness = String(Number(this.fullness) + item.effect[0])
                this.cleanliness = String(Number(this.cleanliness) + item.effect[1])
                this.mood = String(Number(this.mood) + item.effect[2])
                putPropertyUpdate(this.curType, item, this.userid, -1);
                // TODO: 如果要把forEach里面的数据-1，需要涉及到observed和objectlink，这部分还没有看懂
                this.show = false;
                // (this.propertyAmount.find(obj => obj.name === item.text)).amount--
                // console.log('index'+(this.propertyAmount.find(obj => obj.name === item.text)).amount)
                // this.propertyAmount = this.propertyAmount
              })
            }, (item) => {
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