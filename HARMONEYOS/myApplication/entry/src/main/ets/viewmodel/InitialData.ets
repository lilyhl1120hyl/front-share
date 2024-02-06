

export const initTabBarData = [
$r('app.string.mobile_phone'),
$r('app.string.clothes'),
$r('app.string.wear'),
$r('app.string.home_furnishing')
]

export class GoodsListItemType {
  goodsImg: Resource;
  goodsName: Resource;
  advertisingLanguage: Resource;
  evaluate: Resource;
  price: Resource;

  constructor(goodsImg: Resource, goodsName: Resource, price: Resource) {
    this.goodsImg = goodsImg;
    this.goodsName = goodsName;
    this.advertisingLanguage = $r('app.string.advertising_language');
    this.evaluate = $r('app.string.evaluate');
    this.price = price;
  }
}

export const goodsInitialList: GoodsListItemType[] = [
  new GoodsListItemType($r('app.media.goodsImg'), $r('app.string.goodsName'), $r('app.string.price_199')),
  new GoodsListItemType($r('app.media.goodsImg_2'), $r('app.string.another_goodsName'), $r('app.string.price_199')),
  new GoodsListItemType($r('app.media.goodsImg_3'), $r('app.string.goodsName'), $r('app.string.price_199')),
  new GoodsListItemType($r('app.media.goodsImg_4'), $r('app.string.another_goodsName'), $r('app.string.price_199'))
]
