export function Alert(content: string, title?: string, confirmAction?: () => void, cancelAction?: () => void){
  AlertDialog.show(
    {
      title: title,
      message: content,
      autoCancel: true,
      alignment: DialogAlignment.Center,
      confirm: {
        value: '确定',
        fontColor: '#ffd175',
        action: confirmAction
      },
      cancel: cancelAction
    }
  )
}