

import { RankData } from './RankData';
import { rankData1, rankData2 } from '../model/DataModel';

export class RankViewModel {
  // Load data from the rankData1 of the Mock file.
  loadRankDataSource1(): RankData[] {
    return rankData1;
  }

  // Load data from the rankData2 of the Mock file,but rankData2 is different from rankData1.
  loadRankDataSource2(): RankData[] {
    return rankData2;
  }
}

