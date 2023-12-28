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

export function InformDialog(content: string, confirmText:string, cancelText:string, title?: string, confirmAction?: () => void, cancelAction?: () => void){
  AlertDialog.show(
    {
      title: title,
      message: content,
      autoCancel: true,
      alignment: DialogAlignment.Center,
      primaryButton: {
        value: confirmText,
        fontColor: '#ffd175',
        action: confirmAction
      },
      secondaryButton: {
        value: cancelText,
        fontColor: '#ffd175',
        action: cancelAction
      },
    }
  )
}