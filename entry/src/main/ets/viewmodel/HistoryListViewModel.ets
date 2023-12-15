import { Alert } from '../Components/Dialog'
import { useGet } from '../common/utils/HttpUtil'
import WebConstants from '../common/constants/WebConstants'

export class HistoryItem {
  historyId: number
  lastAnswer: string
  lastChatAt: string
  // historyDetailId:string
  constructor(id, title, lastChatDate) {
    this.historyId = id
    this.lastAnswer = title
    this.lastChatAt = lastChatDate
  }
}

export const HistoryItems: HistoryItem[] = [
  new HistoryItem(1, '日本花样滑冰运动员羽生结弦社媒发文宣布离婚，距结婚仅 3 个月，哪些信息值得关注', '2023-11-08'),
  new HistoryItem(2, '如何评价缅方11月15日组织对明学昌抓捕期间，明学昌畏罪自杀身亡，其儿女被成功抓获并移交我国公安机关', '2023-11-08'),
  new HistoryItem(3, '明学昌畏罪自杀身亡，其儿女被成功抓获并移交我国公安机关', '2023-08-08'),
  new HistoryItem(4, 'item4', '2023-03-08'),
  new HistoryItem(5, 'item5', '2023-01-08'),
  new HistoryItem(6, 'item6', '2023-01-09'),
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