export class TagModel {
  tagName: string
  nameColor: string
  borderColor: string
}

export class QuestionTypeModel {
  public id: number
  public name: string
  public icon?: string
  public describeInfo?: string
  public displayNewestFlag?: 0 | 1
  public tags?: TagModel[]
}

export class QueryQuestionListParams {
  type: number
  page: number
  questionBankType: number
  sort?: number
  keyword?: string
}

// @ts-ignore
@Observed
export class QuestionItemModel {
  public id: string
  public stem: string
  public difficulty: number
  public likeCount: number
  public views: number
  public citations?: number
  public createdAt?: string
  public creatorName?: string
  public content?: string
  public imgUrl?: string
  public creatorAvatar?: string
  public readFlag?: 0 | 1
}

export class HotQuestionModel {
  public id: number
  public questionNo?:string
  public stem?: string
  public content?: string
  public answer?: string
  public subjectName: string
  public questionType?: number
  public planSceneName?: string
  public difficulty?: number
  public citations?: number
  public createdAt?: string
  public creatorName?: string
  public creatorAvatar?: string
  public views?: number
  public likeCount?: number
}

export class questionDetailModel {
  public id: string
  public questionNo?:string
  public stem?: string
  public content?: string
  public answer?: string
  public questionType?: number
  public planSceneName?: string
  public difficulty?: number
  public citations?: number
  public createdAt?: string
  public creatorName?: string
  public creatorAvatar?: string
  public views?: number
  public likeCount?: number
  public collectFlag: number
  public likeFlag: number
  public stage: string[]
  public relatedQuestions?: relatedQuestionModel[]
}

export class relatedQuestionModel {
  id: string
  questionNo: string
  stem: string
  createdAt: string
}