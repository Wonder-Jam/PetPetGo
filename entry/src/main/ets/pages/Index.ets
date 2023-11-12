@Entry
@Component
struct Index {

  build() {
    Row() {
      Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
        Column() {
          // TODO：顶部的两个按钮
          Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
            Button('OK', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
              })
            Button('OK', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
              })
          }
          // TODO：三个状态条
          Row() {
            Progress({ value: 20, type: ProgressType.Capsule }).width('100%').height(20).margin({ top: 10 })
          }
          Row() {
            Progress({ value: 20, type: ProgressType.Capsule }).width('100%').height(20).margin({ top: 10 })
          }
          Row() {
            Progress({ value: 20, type: ProgressType.Capsule }).width('100%').height(20).margin({ top: 10 })
          }
          // TODO：pet主体，目前采用的是image，但是实现需求里的交互应该要换组件
          Row() {
            Image($r('app.media.icon'))
              .width(250).height(250).margin(15)
          }
          // TODO：底下的三个button
          Flex({ alignItems: ItemAlign.Start, justifyContent: FlexAlign.SpaceBetween }) {
            Button('OK', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
              })
            Button('OK', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
              })
            Button('OK', { type: ButtonType.Normal, stateEffect: true })
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .width(90)
              .onClick(() => {
                console.log('ButtonType.Normal')
              })
          }
        }
        .width('100%')
      }
      .height('100%')
    }
  }
}