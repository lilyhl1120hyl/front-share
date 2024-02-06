

import ProductItem from '../../../viewmodel/ProductItem';
import { WaterFlowDataSource } from '../../../viewmodel/WaterFlowDataSource';
import CommonConstants from '../../../common/constants/CommonConstant';
import { waterFlowData } from '../../../viewmodel/HomeViewModel';
import FlowItemComponent from './FlowItemComponent';

@Component
export default struct WaterFlowComponent {
  private datasource: WaterFlowDataSource = new WaterFlowDataSource();

  aboutToAppear() {
    this.datasource.setDataArray(waterFlowData);
  }

  build() {
    WaterFlow({ footer: (): void => this.itemFoot() }) {
      LazyForEach(this.datasource, (item: ProductItem) => {
        FlowItem() {
          FlowItemComponent({ item: item })
        }
      }, (item: ProductItem) => JSON.stringify(item))
    }
    .layoutWeight(CommonConstants.WATER_FLOW_LAYOUT_WEIGHT)
    .layoutDirection(FlexDirection.Column)
    .columnsTemplate(CommonConstants.WATER_FLOW_COLUMNS_TEMPLATE)
    .columnsGap($r('app.float.water_flow_columns_gap'))
    .rowsGap($r('app.float.water_flow_row_gap'))
  }

  @Builder
  itemFoot() {
    Column() {
      Text($r('app.string.footer_text'))
        .fontColor(Color.Gray)
        .fontSize($r('app.float.footer_text_size'))
        .width(CommonConstants.FULL_WIDTH)
        .height($r('app.float.footer_text_height'))
        .textAlign(TextAlign.Center)
    }
  }
}