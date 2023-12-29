import { Alert } from '../Components/Dialog'
import { useGet } from '../common/utils/HttpUtil'
import WebConstants from '../common/constants/WebConstants'

export interface  HistoryItem {
  historyId: number
  lastAnswer: string
  lastChatAt: string
}

export const HistoryItems: HistoryItem[] = [
  { historyId: 1, lastAnswer: '日本花样滑冰运动员羽生结弦社媒发文宣布离婚，距结婚仅 3 个月，哪些信息值得关注', lastChatAt: '2023-11-08' },
  { historyId: 2, lastAnswer: '如何评价缅方11月15日组织对明学昌抓捕期间，明学昌畏罪自杀身亡，其儿女被成功抓获并移交我国公安机关', lastChatAt: '2023-11-08' },
  { historyId: 3, lastAnswer: '明学昌畏罪自杀身亡，其儿女被成功抓获并移交我国公安机关', lastChatAt: '2023-08-08' },
  { historyId: 4, lastAnswer: 'item4', lastChatAt: '2023-03-08' },
  { historyId: 5, lastAnswer: 'item5', lastChatAt: '2023-01-08' },
  { historyId: 6, lastAnswer: 'item6', lastChatAt: '2023-01-09' },
]

class HistoryListViewModel {
  historyList: HistoryItem[] = []

  useGetDefaultHistoryList() {
    return HistoryItems;
  }

  useGetHistoryList(userid): Promise<HistoryItem[]> {
    return new Promise((resolve) => {
      useGet<undefined, HistoryItem[]>(WebConstants.TEST_ENVIRONMENT + `/history?userId=${userid}`)
        .then(async ({code, msg, data}) => {
          if (code == '0') {
            this.historyList = data
          } else {
            this.historyList = []
            console.log('httputil error:', msg)
            Alert(`错误：网络错误QAQ！`)
          }
          resolve(this.historyList)
        })
    })
  }
}

let historyListViewModel = new HistoryListViewModel();

export default historyListViewModel as HistoryListViewModel;