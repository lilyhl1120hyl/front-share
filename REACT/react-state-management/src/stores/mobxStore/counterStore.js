// 编写第一个mobx store小案例
import { computed, makeAutoObservable } from "mobx";

class CounterStore {
  // 定义数据
  count = 0;
  countList = [1, 3, 5, 7, 8];
  constructor() {
    // 把数据做成响应式
    makeAutoObservable(this, {
      filterList: computed,
    });
  }

  // 定义计算属性
  get filterList() {
    return this.countList.filter((item) => item > 3);
  }

  // 定义action函数，修改数据
  addCount = () => {
    this.count++;
  };

  addList = (data) => {
      this.countList.push(data); 
  };
}

export { CounterStore };
