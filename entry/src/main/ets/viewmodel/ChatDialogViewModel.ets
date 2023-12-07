import { useGet, usePost } from '../common/utils/HttpUtil'

export interface ChatDialogue {
  createdAt: number;
  dialogue: Dialogue;
  dialogueNo: number;
  id: number;
  petId: number;
  userId: number;
}

export interface Dialogue {
  answer: string;
  question: string;
}

export interface Message {
  userId: number;
  content: string;
}

class ChatDialogViewModel {
  ChatDialogList: ChatDialogue[];

  async useGetHistoryDialogue(): Promise<ChatDialogue[]> {
    await useGet<ChatDialogue[]>('').then(({data}) => {
      this.ChatDialogList = data;
    })
    return this.ChatDialogList;
  }

  useGetDefaultDialogue(): ChatDialogue[] {
    return fakeDialogueList;
  }

  useSendMessage(message: string) {
    return usePost<Dialogue, Message>('', {
      userId: 0,
      content: message
    })
  }
}

const fakeDialogueList: ChatDialogue[] = [
  {
    createdAt: 1637856000000, // Date for '2021-11-26'
    dialogue: { answer: '是的，你有什么问题要问我的吗', question: '你好，请问你是chatGpt吗?' },
    dialogueNo: 1,
    id: 1,
    petId: 101,
    userId: 201,
  },
  {
    createdAt: 1637942400000, // Date for '2021-11-27'
    dialogue: {
      answer: '长文本测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
      question: 'Have you been to Paris?'
    },
    dialogueNo: 2,
    id: 2,
    petId: 102,
    userId: 202,
  },
  {
    createdAt: 1638028800000, // Date for '2021-11-28'
    dialogue: { answer: 'I don\'t know', question: 'What\'s the capital of Australia?' },
    dialogueNo: 3,
    id: 3,
    petId: 103,
    userId: 203,
  },
  {
    createdAt: 1638115200000, // Date for '2021-11-29'
    dialogue: {
      answer: '长文本测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
      question: 'What is the color of the sky?'
    },
    dialogueNo: 4,
    id: 4,
    petId: 104,
    userId: 204,
  },
  {
    createdAt: 1638201600000, // Date for '2021-11-30'
    dialogue: { answer: 'Pizza', question: 'What is your favorite food?' },
    dialogueNo: 5,
    id: 5,
    petId: 105,
    userId: 205,
  },
  {
    createdAt: 1638288000000, // Date for '2021-12-01'
    dialogue: {
      answer: '长文本测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
      question: 'What is the largest land animal?'
    },
    dialogueNo: 6,
    id: 6,
    petId: 106,
    userId: 206,
  },
  {
    createdAt: 1638374400000, // Date for '2021-12-02'
    dialogue: { answer: 'Guitar', question: 'What musical instrument do you play?' },
    dialogueNo: 7,
    id: 7,
    petId: 107,
    userId: 207,
  },
  {
    createdAt: 1638460800000, // Date for '2021-12-03'
    dialogue: { answer: 'Summer', question: 'Which season do you like the most?' },
    dialogueNo: 8,
    id: 8,
    petId: 108,
    userId: 208,
  },
  {
    createdAt: 1638547200000, // Date for '2021-12-04'
    dialogue: { answer: 'Mount Everest', question: 'What is the highest mountain in the world?' },
    dialogueNo: 9,
    id: 9,
    petId: 109,
    userId: 209,
  },
  {
    createdAt: 1638633600000, // Date for '2021-12-05'
    dialogue: { answer: 'Dolphin', question: 'Which mammal is known for its intelligence?' },
    dialogueNo: 10,
    id: 10,
    petId: 110,
    userId: 210,
  },
];

// export class ChatItem {
//   chatterType: 'user' | 'chatGPT'
//   chatterId: string
//   content: string
//   itemId: string
//
//   constructor({chatterType,chatterId,content,itemId}) {
//     this.content = content
//     this.chatterType = chatterType
//     this.chatterId = chatterId,
//     this.itemId = itemId
//   }
// }

// export const ChatRecord: ChatItem[] = [
//   new ChatItem({
//     chatterType: 'user',
//     chatterId: '211250164',
//     content: '',
//     itemId: '2',
//   }),
//   new ChatItem({
//     chatterType: 'chatGPT',
//     chatterId: '00001',
//     content: '？',
//     itemId: '3',
//   }),
//   new ChatItem({
//     chatterType: 'user',
//     chatterId: '211250164',
//     content: '',
//     itemId: '4',
//   }),
//   new ChatItem({
//     chatterType: 'chatGPT',
//     chatterId: '00001',
//     content: '长文本机器人测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
//     itemId: '5',
//   }),
//   new ChatItem({
//     chatterType: 'user',
//     chatterId: '211250164',
//     content: '你好，请问你是chatGpt吗',
//     itemId: '2',
//   }),
//   new ChatItem({
//     chatterType: 'chatGPT',
//     chatterId: '00001',
//     content: '是的，你有什么问题要问我的吗？',
//     itemId: '3',
//   }),
//   new ChatItem({
//     chatterType: 'user',
//     chatterId: '211250164',
//     content: '长文本测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
//     itemId: '4',
//   }),
//   new ChatItem({
//     chatterType: 'chatGPT',
//     chatterId: '00001',
//     content: '长文本机器人测试：对话式交互一直存在于我们的日常生活中，工作时使用的钉钉，联系朋友使用的微信，都属于对话式交互应用。随着技术的发展，我们正在经历从「移动互联网时代」走向「人工智能时代」的过程中，人工智能扩大了对话式交互的使用场景，我们可以通过文字或语音的方式与机器对话来完成某些任务，这类机器人我们称之为 Chatbot。',
//     itemId: '5',
//   }),
// ]

let chatDialogViewModel = new ChatDialogViewModel();

export default chatDialogViewModel as ChatDialogViewModel;