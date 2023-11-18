export class ChatItem {
  chatterType: 'user' | 'chatGPT'
  chatterId: string
  content: string
  itemId: string

  constructor({chatterType,chatterId,content,itemId}) {
    this.content = content
    this.chatterType = chatterType
    this.chatterId = chatterId,
    this.itemId = itemId
  }
}

export const ChatRecord: ChatItem[] = [
  new ChatItem({
    chatterType: 'user',
    chatterId: '211250164',
    content: '你好，请问你是chatGpt吗',
    itemId: '2',
  }),
  new ChatItem({
    chatterType: 'chatGPT',
    chatterId: '00001',
    content: '是的，你有什么问题要问我的吗？',
    itemId: '3',
  }),
  new ChatItem({
    chatterType: 'user',
    chatterId: '211250164',
    content: '长文本测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
    itemId: '4',
  }),
  new ChatItem({
    chatterType: 'chatGPT',
    chatterId: '00001',
    content: '长文本机器人测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
    itemId: '5',
  }),
  new ChatItem({
    chatterType: 'user',
    chatterId: '211250164',
    content: '你好，请问你是chatGpt吗',
    itemId: '2',
  }),
  new ChatItem({
    chatterType: 'chatGPT',
    chatterId: '00001',
    content: '是的，你有什么问题要问我的吗？',
    itemId: '3',
  }),
  new ChatItem({
    chatterType: 'user',
    chatterId: '211250164',
    content: '长文本测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
    itemId: '4',
  }),
  new ChatItem({
    chatterType: 'chatGPT',
    chatterId: '00001',
    content: '长文本机器人测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
    itemId: '5',
  }),
]