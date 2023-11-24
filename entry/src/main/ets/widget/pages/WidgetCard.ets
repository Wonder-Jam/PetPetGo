@Entry
@Component
struct WidgetCard {
  /*
   * The max lines.
   */
  readonly MAX_LINES: number = 1;

  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';

  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';

  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';

  /*
   * The with percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';

  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  build() {
    Stack() {
      Image($r("app.media.bg_widget"))
        .width(this.FULL_WIDTH_PERCENT)
        .height(this.FULL_HEIGHT_PERCENT)
        .objectFit(ImageFit.Cover)
      Column() {
        Row(){
          Image($r("app.media.pet"))
            .width("80%")
            .height("80%")
            .objectFit(ImageFit.ScaleDown)
          Column(){
            Row(){
              Image($r("app.media.fullness_widget"))
                .width(14)
                .height(14)
              Text("20")
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)

            Row(){
              Image($r("app.media.cleanliness_widget"))
                .width(13)
                .height(13)
                .padding(1)
              Text("20")
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)



            Row(){
              Image($r("app.media.mood_widget"))
                .width(14)
                .height(14)
              Text("20")
                .fontSize(10)
                .fontColor(Color.White)
            }
            .height(16)
            .width(30)
            .backgroundColor(Color.Gray)
            .margin(2)
            .justifyContent(FlexAlign.SpaceAround)

          }
          .height("100%")
          .justifyContent(FlexAlign.Start)
        }
        // Text($r('app.string.title_immersive'))
        //   .fontSize($r('app.float.title_immersive_font_size'))
        //   .textOverflow({ overflow: TextOverflow.Ellipsis })
        //   .fontColor($r('app.color.text_font_color'))
        //   .maxLines(this.MAX_LINES)
        // Text($r('app.string.detail_immersive'))
        //   .fontSize($r('app.float.detail_immersive_font_size'))
        //   .opacity($r('app.float.detail_immersive_opacity'))
        //   .margin({ top: $r('app.float.detail_immersive_margin_top') })
        //   .textOverflow({ overflow: TextOverflow.Ellipsis })
        //   .fontColor($r('app.color.text_font_color'))
        //   .maxLines(this.MAX_LINES)
      }
      .width(this.FULL_WIDTH_PERCENT)
      .height(this.FULL_HEIGHT_PERCENT)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.End)
      .padding($r('app.float.column_padding'))
    }
    .width(this.FULL_WIDTH_PERCENT)
    .height(this.FULL_HEIGHT_PERCENT)
    .onClick(() => {
      postCardAction(this, {
        "action": this.ACTION_TYPE,
        "abilityName": this.ABILITY_NAME,
        "params": {
          "message": this.MESSAGE
        }
      });
    })
  }
}