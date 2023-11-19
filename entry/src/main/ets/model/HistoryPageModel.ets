export class HistoryItem {
  id: number
  title: string
  lastChatDate: string
  // historyDetailId:string
  constructor(id, title, lastChatDate) {
    this.id = id
    this.title = title
    this.lastChatDate = lastChatDate
  }
}

export const HistoryItems: HistoryItem[] = [
  new HistoryItem(1, '日本花样滑冰运动员羽生结弦社媒发文宣布离婚，距结婚仅 3 个月，哪些信息值得关注', '23年11月8日'),
  new HistoryItem(2, '如何评价缅方11月15日组织对明学昌抓捕期间，明学昌畏罪自杀身亡，其儿女被成功抓获并移交我国公安机关', '23年11月8日'),
  new HistoryItem(3, '明学昌畏罪自杀身亡，其儿女被成功抓获并移交我国公安机关', '23年8月8日'),
  new HistoryItem(4, 'item4', '23年3月8日'),
  new HistoryItem(5, 'item5', '23年1月8日'),
  new HistoryItem(6, 'item6', '23年19月8日'),
]

